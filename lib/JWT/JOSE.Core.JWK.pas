unit JOSE.Core.JWK;

interface

uses
  System.SysUtils, JOSE.Types.Bytes, JOSE.Core.Base, JOSE.Encoding.Base64;

type
  TJWK = class(TJOSEBase)
  private
    FKey: TJOSEBytes;
  public
    constructor Create(AKey: TJOSEBytes); overload;
    property Key: TJOSEBytes read FKey write FKey;
  end;

  TKeyPair = class
  private
    FPrivateKey: TJWK;
    FPublicKey: TJWK;
  public
    constructor Create; overload;
    constructor Create(const APublicKey, APrivateKey: TJOSEBytes); overload;
    destructor Destroy; override;
    procedure SetSymmetricKey(const ASecret: TJOSEBytes);
    procedure SetAsymmetricKeys(const APublicKey, APrivateKey: TJOSEBytes);
    property PrivateKey: TJWK read FPrivateKey write FPrivateKey;
    property PublicKey: TJWK read FPublicKey write FPublicKey;
  end;

implementation

{ TJWK }

constructor TJWK.Create(AKey: TJOSEBytes);
begin
  inherited Create;
  FKey := AKey;
end;

{ TKeyPair }

constructor TKeyPair.Create;
begin
  FPrivateKey := TJWK.Create();
  FPublicKey := TJWK.Create();
end;

constructor TKeyPair.Create(const APublicKey, APrivateKey: TJOSEBytes);
begin
  FPublicKey := TJWK.Create(APublicKey);
  FPrivateKey := TJWK.Create(APrivateKey);
end;

destructor TKeyPair.Destroy;
begin
  FPublicKey.Free;
  FPrivateKey.Free;
  inherited;
end;

procedure TKeyPair.SetAsymmetricKeys(const APublicKey, APrivateKey: TJOSEBytes);
begin
  FPublicKey.Key := APublicKey;
  FPrivateKey.Key := APrivateKey;
end;

procedure TKeyPair.SetSymmetricKey(const ASecret: TJOSEBytes);
begin
  FPublicKey.Key := ASecret;
  FPrivateKey.Key := ASecret;
end;

end.
