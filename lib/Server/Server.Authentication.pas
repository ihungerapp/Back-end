unit Server.Authentication;

interface

uses
  System.SysUtils, Web.HTTPApp, Server.Connection;

type
  TAuthentication = class
    private
      FParameters: String;
    FUserID: Integer;
      constructor Create(aNameResource, aNameFieldUser, aNameFieldPassword: String);
      procedure OpenQuery(SQL, Fields, TableName, Where: String; Connection: TConnection);
    procedure SetUserID(const Value: Integer);
    public
      destructor Destroy; override;
      class function GetInstance(aNameResource, aNameFieldUser, aNameFieldPassword: String): TAuthentication;
      class function NewInstance: TObject; override;
      function Authenticate(Request: TWebRequest; Response: TWebResponse) : Boolean;
      property UserID: Integer read FUserID write SetUserID;
  end;

var
  Authentication: TAuthentication;

implementation

uses
  System.JSON, System.Rtti;

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
    lTableName := QuotedStr(LAutParameters[0]);
    OpenQuery(SQL_GetPrimaryKeyName, lFields, lTableName, lWhere, Connection);
    lTableName := LAutParameters[0];
    lPrimaryKeyName := Connection.Query.FieldByName('attname').AsString;
    lFields := LAutParameters[1] + ', ' + lPrimaryKeyName;
    lWhere := LAutParameters[1] + ' = ' + QuotedStr(User) + ' AND ' +
              LAutParameters[2] + ' = ' + QuotedStr(Password);
    OpenQuery(SQL, lFields, lTableName, lWhere, Connection);
    UserID := Connection.Query.FieldByName(lPrimaryKeyName).AsInteger;
    Result := Connection.Query.RecordCount > 0;
  finally
    Connection.Free;
  end;
end;

constructor TAuthentication.Create(aNameResource, aNameFieldUser, aNameFieldPassword: String);
begin
  FParameters := aNameResource + ';' + aNameFieldUser + ';' + aNameFieldPassword;
end;

destructor TAuthentication.Destroy;
begin

  inherited;
end;

class function TAuthentication.GetInstance(aNameResource, aNameFieldUser, aNameFieldPassword: String): TAuthentication;
begin
  Result := Self.Create(aNameResource, aNameFieldUser, aNameFieldPassword);
end;

class function TAuthentication.NewInstance: TObject;
begin
  if not Assigned(Authentication) then
    Authentication := TAuthentication(inherited NewInstance);
  Result := Authentication;
end;

procedure TAuthentication.OpenQuery(SQL, Fields, TableName, Where: String; Connection: TConnection);
begin
  Connection.Query.SQL.Clear;
  Connection.Query.SQL.Add(Format(SQL, [Fields, TableName, Where]));
  Connection.Query.Open;
end;

procedure TAuthentication.SetUserID(const Value: Integer);
begin
  FUserID := Value;
end;

end.
