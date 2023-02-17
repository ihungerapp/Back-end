unit JOSE.Core.JWS;

interface

uses
  System.SysUtils, JOSE.Types.Bytes, JOSE.Core.Base, JOSE.Core.Parts, JOSE.Core.JWA, JOSE.Core.JWK, JOSE.Core.JWT,
  JOSE.Core.JWA.Signing;

type
  TJWS = class(TJOSEParts)
  private
    const COMPACT_PARTS = 3;
  private
    FKey: TJOSEBytes;
  private
    function GetSigningInput: TJOSEBytes;
    function GetHeader: TJOSEBytes;
    function GetPayload: TJOSEBytes;
    function GetSignature: TJOSEBytes;
    procedure SetHeader(const Value: TJOSEBytes);
    procedure SetPayload(const Value: TJOSEBytes);
    procedure SetSignature(const Value: TJOSEBytes);
  protected
    function GetAlgorithm(AAlgId: TJOSEAlgorithmId): IJOSESigningAlgorithm;
    function GetCompactToken: TJOSEBytes; override;
    procedure SetCompactToken(const Value: TJOSEBytes); override;
  public
    constructor Create(AToken: TJWT); override;
    procedure SetKey(const AKey: TBytes); overload;
    procedure SetKey(const AKey: TJOSEBytes); overload;
    procedure SetKey(const AKey: TJWK); overload;
    procedure SetKeyFromCert(const ACert: TJOSEBytes); overload;
    function Sign: TJOSEBytes; overload;
    function Sign(AKey: TJWK; AAlgId: TJOSEAlgorithmId): TJOSEBytes; overload;
    function VerifySignature: Boolean; overload;
    function VerifySignature(AKey: TJWK; const ACompactToken: TJOSEBytes): Boolean; overload;
    property Key: TJOSEBytes read FKey;
    property Header: TJOSEBytes read GetHeader write SetHeader;
    property Payload: TJOSEBytes read GetPayload write SetPayload;
    property Signature: TJOSEBytes read GetSignature write SetSignature;
    property SigningInput: TJOSEBytes read GetSigningInput;
  end;

implementation

uses
  System.Types, System.StrUtils, JOSE.Signing.Base, JOSE.Encoding.Base64, JOSE.Hashing.HMAC, JOSE.Core.JWA.Factory;

constructor TJWS.Create(AToken: TJWT);
var
  LIndex: Integer;
begin
  inherited Create(AToken);

  for LIndex := 0 to COMPACT_PARTS - 1 do
    FParts.Add(TJOSEBytes.Empty);
end;

function TJWS.GetAlgorithm(AAlgId: TJOSEAlgorithmId): IJOSESigningAlgorithm;
var
  LAlgId: string;
begin
  LAlgId := FToken.Header.Algorithm;

  if LAlgId.IsEmpty then
    raise EJOSEException.CreateFmt('Signature algorithm header (%s) not set.', [THeaderNames.ALGORITHM]);

  Result := TJOSEAlgorithmRegistryFactory.Instance
                                         .SigningAlgorithmRegistry
                                         .GetAlgorithm(LAlgId);

  if Result = nil then
    raise EJOSEException.CreateFmt('Signing algorithm (%s) is not supported.', [LAlgId]);
end;

function TJWS.GetCompactToken: TJOSEBytes;
begin
  Result := Header + PART_SEPARATOR + Payload + PART_SEPARATOR + Signature;
end;

function TJWS.GetHeader: TJOSEBytes;
begin
  Result := FParts[0]
end;

function TJWS.GetPayload: TJOSEBytes;
begin
  Result := FParts[1];
end;

function TJWS.GetSignature: TJOSEBytes;
begin
  Result := FParts[2];
end;

function TJWS.GetSigningInput: TJOSEBytes;
begin
  Result := Header + PART_SEPARATOR + Payload;
end;

procedure TJWS.SetCompactToken(const Value: TJOSEBytes);
var
  LRes: TStringDynArray;
begin
  LRes := SplitString(Value, PART_SEPARATOR);
  if Length(LRes) = COMPACT_PARTS then
  begin
    FParts[0] := LRes[0];
    FParts[1] := LRes[1];
    FParts[2] := LRes[2];
    FToken.Header.URLEncoded := LRes[0];
    FToken.Claims.URLEncoded := LRes[1];
  end
  else
    raise EJOSEException.CreateFmt('A JWS Compact Serialization must have %d parts', [COMPACT_PARTS]);
end;

procedure TJWS.SetHeader(const Value: TJOSEBytes);
begin
  FParts[0] := Value;
end;

procedure TJWS.SetKey(const AKey: TBytes);
begin
  FKey := AKey;
end;

procedure TJWS.SetKey(const AKey: TJOSEBytes);
begin
  FKey := AKey;
end;

procedure TJWS.SetKey(const AKey: TJWK);
begin
  FKey := AKey.Key;
end;

procedure TJWS.SetKeyFromCert(const ACert: TJOSEBytes);
begin
  FKey.AsBytes := TSigningBase.PublicKeyFromCertificate(ACert.AsBytes);
end;

procedure TJWS.SetPayload(const Value: TJOSEBytes);
begin
  FParts[1] := Value;
end;

procedure TJWS.SetSignature(const Value: TJOSEBytes);
begin
  FParts[2] := Value;
end;

function TJWS.Sign(AKey: TJWK; AAlgId: TJOSEAlgorithmId): TJOSEBytes;
begin
  SetKey(AKey);
  SetHeaderAlgorithm(AAlgId);

  Result := Sign();
end;

function TJWS.Sign: TJOSEBytes;
var
  LAlgId: TJOSEAlgorithmId;
  LAlg: IJOSESigningAlgorithm;
begin
  LAlgId.AsString := FToken.Header.Algorithm;
  LAlg := GetAlgorithm(LAlgId);

  if not FSkipKeyValidation then
    LAlg.ValidateSigningKey(FKey);

  Header := TBase64.URLEncode(ToJSON(FToken.Header.JSON));
  Payload := TBase64.URLEncode(ToJSON(FToken.Claims.JSON));
  Signature := LAlg.Sign(FKey, SigningInput);

  Result := Signature;
end;

function TJWS.VerifySignature(AKey: TJWK; const ACompactToken: TJOSEBytes): Boolean;
begin
  SetKey(AKey);
  SetCompactToken(ACompactToken);

  Result := VerifySignature;
end;

function TJWS.VerifySignature: Boolean;
var
  LAlgId: TJOSEAlgorithmId;
  LAlg: IJOSESigningAlgorithm;
begin
  LAlgId.AsString := FToken.Header.Algorithm;
  LAlg := GetAlgorithm(LAlgId);

  if not FSkipKeyValidation then
    LAlg.ValidateVerificationKey(FKey);

  Result := LAlg.VerifySignature(FKey, SigningInput, Signature);
  FToken.Verified := Result;
end;

end.
