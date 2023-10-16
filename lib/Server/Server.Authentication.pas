unit Server.Authentication;

interface

uses
  System.SysUtils, Web.HTTPApp, Server.Connection, FireDAC.Comp.Client;

type
  TAuthentication = class
  private
    FParameters: String;
    FUserID: Integer;
    FCpfCnpj: String;
    FDataBaseName: String;
    constructor Create(aNameResource, aNameFieldUser, aNameFieldPassword, aCPFCNPJ: String);
    procedure OpenQuery(SQL, Fields, TableName, Where: String; Query: TFDQuery);
  procedure SetUserID(const Value: Integer);
  public
    destructor Destroy; override;
    class function GetInstance(aNameResource, aNameFieldUser, aNameFieldPassword, aCPFCNPJ: String): TAuthentication;
    class function NewInstance: TObject; override;
    function Authenticate(Request: TWebRequest; Response: TWebResponse) : Boolean;
    property UserID: Integer read FUserID write SetUserID;
    property CpfCnpj: String read FCpfCnpj write FCpfCnpj;
    property DataBaseName: String read FDataBaseName write FDataBaseName;
  end;

var
  Authentication: TAuthentication;

implementation

uses
  System.JSON, System.Rtti, Server.Config;

{ TAuthentication }

function TAuthentication.Authenticate(Request: TWebRequest; Response: TWebResponse) : Boolean;
const
  SQL = 'SELECT %s FROM %s WHERE %s';
  SQL_GetPrimaryKeyName =
  '%s SELECT                '+
  '   pg_attribute.attname,  '+
  '   format_type(pg_attribute.atttypid, pg_attribute.atttypmod)  '+
  ' FROM pg_index, pg_class, pg_attribute, pg_namespace  '+
  ' WHERE  '+
  '   pg_class.oid = %s::regclass AND  '+
  '   indrelid = pg_class.oid AND  '+
  '   pg_class.relnamespace = pg_namespace.oid AND  '+
  '   pg_attribute.attrelid = pg_class.oid AND  '+
  '   pg_attribute.attnum = any(pg_index.indkey) '+
  '  AND indisprimary %s';

var
  LAutParameters: TArray<String>;
  LJSONValue: TJSONValue;
  lFields: String;
  lPrimaryKeyName: String;
  lTableName: String;
  lWhere: String;
  User: String;
  Password: String;
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  try
    LAutParameters := FParameters.Split([';']);
    LJSONValue := TJSONObject.ParseJSONValue(Request.Content);
    User := LJSONValue.GetValue<string>('user');
    Password := LJSONValue.GetValue<string>('password');
    CpfCnpj := LJSONValue.GetValue<string>('cpfCnpj');

    //Obter nome do banco de dados para conexão com o banco correto do usuário
    TServerConfig.GetInstance('EmpresaConDef', 'EMPRESA');
    lFields := '"DATABASE_NAME"';
    lTableName := '"CADEMP"';
    lWhere := LAutParameters[3] + ' = ' + QuotedStr(CpfCnpj);
    OpenQuery(SQL, lFields, lTableName, lWhere, Connection.QueryEmpresa);
    if (Connection.QueryEmpresa.RecordCount = 0)
    or (Connection.QueryEmpresa.FieldByName('DATABASE_NAME').AsString = EmptyStr) then
    begin
      Result := False;
      Exit;
    end
    else
      FDataBaseName := Connection.QueryEmpresa.FieldByName('DATABASE_NAME').AsString;

    TServerConfig.GetInstance('ServerConDef', FDataBaseName);
    lTableName := QuotedStr(LAutParameters[0]);
    lFields := EmptyStr;
    lWhere := EmptyStr;
    OpenQuery(SQL_GetPrimaryKeyName, lFields, lTableName, lWhere, Connection.Query);
    lTableName := LAutParameters[0];
    lPrimaryKeyName := Connection.Query.FieldByName('attname').AsString;
    lFields := LAutParameters[1] + ', ' + '"' + lPrimaryKeyName + '"';
    lWhere := LAutParameters[1] + ' = ' + QuotedStr(User) + ' AND ' +
              LAutParameters[2] + ' = ' + QuotedStr(Password);
    OpenQuery(SQL, lFields, lTableName, lWhere, Connection.Query);
    UserID := Connection.Query.FieldByName(lPrimaryKeyName).AsInteger;
    Result := Connection.Query.RecordCount > 0;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
end;

constructor TAuthentication.Create(aNameResource, aNameFieldUser, aNameFieldPassword, aCPFCNPJ: String);
begin
  FParameters := aNameResource + ';' + aNameFieldUser + ';' + aNameFieldPassword + ';' + aCPFCNPJ;
end;

destructor TAuthentication.Destroy;
begin

  inherited;
end;

class function TAuthentication.GetInstance(aNameResource, aNameFieldUser, aNameFieldPassword, aCPFCNPJ: String): TAuthentication;
begin
  Result := Self.Create(aNameResource, aNameFieldUser, aNameFieldPassword, aCPFCNPJ);
end;

class function TAuthentication.NewInstance: TObject;
begin
  if not Assigned(Authentication) then
    Authentication := TAuthentication(inherited NewInstance);
  Result := Authentication;
end;

procedure TAuthentication.OpenQuery(SQL, Fields, TableName, Where: String; Query: TFDQuery);
begin
  Query.SQL.Clear;
  Query.SQL.Add(Format(SQL, [Fields, TableName, Where]));
  Query.Open;
end;

procedure TAuthentication.SetUserID(const Value: Integer);
begin
  FUserID := Value;
end;

end.
