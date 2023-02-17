unit Server.Token;

interface

uses
  System.JSON, Data.DB;

type
  TToken = class
  public
    class function ObterVencimento: TDateTime;
    class function ObterChave: String;
    class function Obter(Usuario: String; UserID: Integer): String;
    class function Validar(const pToken: String): Boolean;
    class function ObterTokenAsJsonValue(Usuario: String; UserID: Integer): TJsonValue;overload;
    class function ObterTokenAsJsonValue(DataSet:TDataSet): TJsonValue;overload;
    class function ObterClaims(PRequestField: string): tjsonobject; static;
  end;

implementation

uses
  JOSE.Core.JWT, JOSE.Core.JWA, JOSE.Core.Builder, JOSE.Core.JWK, JOSE.Types.Bytes, System.NetEncoding, System.SysUtils,
  System.DateUtils;


{ TTokenWs }

class function TToken.Obter(Usuario: String; UserID: Integer): String;
Var
  LToken: TJWT;
begin
  LToken := Nil;
  Try
    LToken := TJWT.Create;
    LToken.Claims.Subject := Usuario;
    LToken.Claims.IssuedAt := ObterVencimento;
    LToken.Claims.SetClaimOfType<Integer>('UserID', UserID);
    Result := TJOSE.SHA256CompactToken(ObterChave,LToken);
  Finally
    if Assigned(LToken) then
      LToken.Free;
  End;
end;

class function TToken.ObterChave: String;
const
  _SECRET_KEY: String = 'hunger@app$2023';
Var
  lBase: TBase64Encoding;
begin
  lBase := nil;
  Try
    lBase := TBase64Encoding.Create;
    Result := '@'+lBase.Encode(_SECRET_KEY);
  Finally
    lBase.Free;
  End;
end;

class function TToken.ObterClaims(PRequestField: string): tjsonobject;
Var
  LKey: TJWK;
  LToken: TJWT;
  LCompactToken: TJOSEBytes;
begin
  Result := nil;

  Try
    LKey := TJWK.Create(ObterChave);
    LCompactToken := StringReplace(PRequestField, 'Bearer ', '', []);
    LToken := TJOSE.Verify(LKey, LCompactToken);

    case LToken.Verified of False: Exit; end;

    Result := LToken.Claims.JSON;
  Except
    On E: Exception do Result := nil;
  End;
end;

class function TToken.ObterTokenAsJsonValue(DataSet: TDataSet): TJsonValue;
Var
  lObj: TJSONObject;
begin
  lObj := TJSONObject.Create;
  lObj.AddPair('token', TJSONString.Create(Obter(DataSet.FieldByName('nm_usuario').AsString, DataSet.FieldByName('tp_usuario').AsInteger)));
  lObj.AddPair('tipo', TJSONNumber.Create(DataSet.FieldByName('tp_usuario').AsInteger));
  lObj.AddPair('id', TJSONNumber.Create(DataSet.FieldByName('id_usuarios').AsInteger));
  Result := lObj;
end;

class function TToken.ObterTokenAsJsonValue(Usuario: String; UserID: Integer): TJsonValue;
Var
  lObj: TJSONObject;
begin
  lObj := TJSONObject.Create;
  lObj.AddPair('token', TJSONString.Create(Obter(Usuario, UserID)));
  Result := lObj;
end;

class function TToken.ObterVencimento: TDateTime;
Var
  Dia, Mes, Ano: Word;
begin
  DecodeDate(Now, Ano, Mes, Dia);
  Result := EncodeDateTime(Ano, Mes, Dia, 23,59,59,0);
end;

class function TToken.Validar(const pToken: String): Boolean;
Var
  LKey: TJWK;
  LToken: TJWT;
  LCompactToken: TJOSEBytes;
begin
  LToken := nil;
  Try
    Try
      LKey := TJWK.Create(ObterChave);
      LCompactToken := pToken;
      LToken := TJOSE.Verify(LKey, LCompactToken);
      Result := LToken.Verified;
      if   LToken.Claims.IssuedAt < Now then
        Result := False;
    Except
      On E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    if Assigned(LToken) then
      LToken.Free;
  End;
end;

end.
