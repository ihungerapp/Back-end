unit Server.WebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon, Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  FireDAC.Stan.Param, Web.WebFileDispatcher, Web.HTTPProd, System.JSON, DataSnap.DSAuth, Datasnap.DSProxyJavaScript,
  IPPeerServer, Datasnap.DSMetadata, Datasnap.DSServerMetadata, Datasnap.DSClientMetadata, Datasnap.DSCommonServer,
  Datasnap.DSHTTP, System.Rtti, Server.Attributes, Server.Config, Server.Connection, Data.DB,
  System.Generics.Collections,
  Server.Authentication;

type
  TWebModuleApi = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleApiWebActionPadraoAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleApiwebAuthorizationAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    procedure GetClassesProc(AClass: TPersistentClass);
    procedure SetAction(Classe: TRttiType; Attribute: TCustomAttribute; Metodo: TRttiMethod; AttributeMethod: TCustomAttribute);
    procedure WebModuleApiWebAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure Execute(AClassName, AMethodName: String; Params: array of TValue);
    procedure SetClassName(lDados: TArray<String>; var ClassName: string);
    procedure SetParamsGet(Request: TWebRequest; var PageNumber: Integer; var PageSize: Integer; var Direction: String; var Sort: String; var Search: String; var Join:string; var Method:string);overload;
    procedure SetParamsGet(Request: TWebRequest; var PageNumber, PageSize: Integer; var Direction, Sort, Search, Join: string; var Method:string; var JSON: TJSONObject);overload;
    procedure ExecAction(Request: TWebRequest; Response: TWebResponse; Name: String);
    procedure ValidarAcesso(pValue: String);
    function ValidarUsuarioPadrao(AParams:TDictionary<string,string>):Boolean;
  public
  end;

var
  WebModuleClass: TComponentClass = TWebModuleApi;

implementation


{$R *.dfm}

uses
  Web.WebReq, FireDAC.Comp.Client, System.Types, System.DateUtils,
  Server.Message, Server.MessageList, Server.Token, System.NetEncoding;

procedure TWebModuleApi.WebModuleApiWebActionPadraoAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lDados: TArray<String>;
  Resource: String;
  Item: String;
  I: Integer;
  Redirect: Boolean;
begin
  Redirect := False;
  I := 0;
  lDados := string(Request.PathInfo).Split(['/']);
  for Item in lDados do
  begin
    if Item = 'v1' then
    begin
      Resource := lDados[I+1];
      Break;
    end
    else
      Inc(I);
  end;
  for I := 0 to Self.Actions.Count-1 do
  begin
    if Self.Actions.Items[I].MethodType = Request.MethodType then
    begin
      if Self.Actions.Items[I].PathInfo = '/v1/' + Resource then
      begin
        ExecAction(Request, Response, Self.Actions.Items[I].Name);
        Redirect := True;
      end;
    end;
  end;
  if not(Redirect) then
    Response.Content := 'Hunger App Server - 1.0';
end;

procedure TWebModuleApi.WebModuleApiwebAuthorizationAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  LAuthentication: TAuthentication;
  lMsg: TMessageType;
  lUsuario: String;
  LJSONObject: TJSONObject;
begin
  Response.ContentType  := 'application/json;charset=UTF-8';
  LAuthentication := (TAuthentication.NewInstance as TAuthentication);
  if LAuthentication.Authenticate(Request, Response) then
  begin
    LJSONObject :=  TJSONObject(TJSONObject.ParseJSONValue(Request.Content)) as TJSONObject;
    lUsuario := LJSONObject.GetValue<string>('user');
    lMsg := IAutorizado;
    lMsg.Content := TJSONObject(TToken.ObterTokenAsJsonValue(lUsuario,LAuthentication.UserID));
    TMessage.Create(lMsg).SendMessage(Response);
  end
  else
    TMessage.Create(ENaoAutorizado).SendMessage(Response);
end;

procedure TWebModuleApi.WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.SetCustomHeader('Access-Control-Allow-Origin','*');
  Response.SetCustomHeader('Access-Control-Allow-Methods','Content-Type');
  Response.SetCustomHeader('Access-Control-Allow-Methods','Authorization');
  Response.SetCustomHeader('Access-Control-Allow-Methods','GET,POST,PUT,PATCH,OPTIONS,DELETE');
  if trim(Request.GetFieldByName('Access-Control-Request-Headers')) <> EmptyStr then
  begin
    Response.SetCustomHeader('Access-Control-Allow-Headers', Request.GetFieldByName('Access-Control-Request-Headers'));
    Handled := True;
  end;

  if Request.Method <> 'OPTIONS' then
  begin
    Response.SetCustomHeader('path',Request.PathInfo);
    if LowerCase(Request.PathInfo) = '/v1/ping' then
      TMessage.Create(IServidorConnectado,'Server connectado').SendMessage(Response)
    else if LowerCase(Request.PathInfo) <> '/v1/authorization' then
      ValidarAcesso(Request.GetFieldByName('x-api-key'));
  end;
end;

procedure TWebModuleApi.WebModuleCreate(Sender: TObject);
var
  ClassFinder: TClassFinder;
begin
  ClassFinder := TClassFinder.Create(Nil);
  try
    ClassFinder.GetClasses(GetClassesProc);
    TServerConfig.GetInstance;
  finally
    ClassFinder.Free;
  end;
end;

procedure TWebModuleApi.GetClassesProc(AClass: TPersistentClass);
var
  RttiContext: TRttiContext;
  Classe: TRttiType;
  Attribute: TCustomAttribute;
  Metodo: TRttiMethod;
  AttributeMethod: TCustomAttribute;
begin
  RttiContext := TRttiContext.Create;
  Classe := RttiContext.GetType(AClass);
  for Attribute in Classe.GetAttributes do
    if Attribute is Resource then
      for Metodo in Classe.GetMethods do
        for AttributeMethod in Metodo.GetAttributes do
          SetAction(Classe, Attribute, Metodo, AttributeMethod);
end;

procedure TWebModuleApi.SetAction(Classe: TRttiType; Attribute: TCustomAttribute; Metodo: TRttiMethod; AttributeMethod: TCustomAttribute);
begin
  Self.Actions.Add;
  with Self.Actions.Items[Self.Actions.Count - 1] do
  begin
    PathInfo := '/v1/' + Resource(Attribute).ResourceName;
    Name := Classe.QualifiedName + '.' + Metodo.Name;
    if AttributeMethod is Get then
      MethodType := mtGet
    else if AttributeMethod is Post then
      MethodType := mtPost
    else if AttributeMethod is Put then
      MethodType := mtPut
    else if AttributeMethod is Patch then
      MethodType := mtPatch
    else if AttributeMethod is Delete then
      MethodType := mtDelete;
    OnAction := WebModuleApiWebAction;
  end;
end;

procedure TWebModuleApi.WebModuleApiWebAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  ExecAction(Request, Response, TWebActionItem(Sender).Name);
end;

procedure TWebModuleApi.ExecAction(Request: TWebRequest; Response: TWebResponse; Name: String);
var
  ClassName: String;
  MethodName: String;
  lDados: TArray<String>;
  Body: TJSONObject;
  lParams: Array of TValue;
  lMethodType: Array of TValue;
  Resource: String;
  ID: String;
  PageNumber: Integer;
  PageSize: Integer;
  Direction: String;
  Sort: String;
  Search: String;
  Join:string;
  Method: String;
  Item: String;
  JSON:TJSONObject;
  I: Integer;
begin
  lDados := Name.Split(['.']);
  lMethodType := [Request];
  MethodName := lDados[Length(lDados)-1];
  SetClassName(lDados, ClassName);
  Body := nil;
  if Request.Content <> EmptyStr then
    Body := TJSONObject(TJSONObject.ParseJSONValue(Request.Content)) as TJSONObject;
  lDados := string(Request.PathInfo).Split(['/']);
  I := 0;
  ID := EmptyStr;
  for Item in lDados do
  begin
    if Item = 'v1' then
    begin
      Resource := lDados[I+1];
      if ((I + 3) = Length(lDados)) then
      begin
        ID := lDados[I+2];
        Break;
      end;
    end
    else
      Inc(I);
  end;

  if Request.MethodType = mtGet then
  begin
    SetParamsGet(Request, PageNumber, PageSize, Direction, Sort, Search, Join, Method, JSON);
    lParams := [Response, PageNumber, PageSize, Direction, Sort, Search, ID, Join, Method, JSON, Request];
  end
  else if Request.MethodType in [mtPost] then
    lParams := [Response, Body]
  else if Request.MethodType in [mtPut] then
    lParams := [Response, StrToIntDef(ID, -1), Body]
  else if Request.MethodType in [mtPatch] then
    lParams := [Response, StrToIntDef(ID, -1), Body, Request]
  else if Request.MethodType in [mtDelete] then
    lParams := [Response, ID.ToInteger];
  Response.StatusCode := 200;
  Execute(ClassName, MethodName, lParams);
end;

procedure TWebModuleApi.Execute(AClassName, AMethodName: String; Params: array of TValue);
var
  RttiContext: TRttiContext;
  RttiInstanceType: TRttiInstanceType;
  RttiMethod: TRttiMethod;
  RttiProperty: TRttiProperty;
  Instance: TObject;
begin
  RttiContext := TRttiContext.Create;
  RttiInstanceType := RttiContext.FindType(AClassName).AsInstance;

  RttiMethod := RttiInstanceType.GetMethod('Create');
  Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType,[]).AsObject;

  RttiMethod := RttiInstanceType.GetMethod(AMethodName);
  RttiMethod.Invoke(Instance, Params).AsString;
  Instance.Free;
end;

procedure TWebModuleApi.SetClassName(lDados: TArray<String>; var ClassName: string);
var
  I: Integer;
begin
  ClassName := EmptyStr;
  for I := 0 to Length(lDados) - 2 do
    ClassName := ClassName + lDados[I] + '.';
  ClassName := ClassName.TrimRight(['.']);
end;

procedure TWebModuleApi.SetParamsGet(Request: TWebRequest; var PageNumber,
  PageSize: Integer; var Direction, Sort, Search, Join: string; var Method:string;
  var JSON: TJSONObject);
var
  LJSONString:String;
begin
  SetParamsGet(Request, PageNumber, PageSize, Direction, Sort, Search, Join, Method);
  JSON := nil;
  if Request.QueryFields.IndexOfName('JSON') >= 0 then
  begin
    LJSONString := Request.QueryFields.Values['JSON'].Replace('<!','{',[]).Replace('!>','}',[]);
    JSON := TJSONObject.ParseJSONValue(LJSONString) AS TJSONObject;
  end;
end;

procedure TWebModuleApi.SetParamsGet(Request: TWebRequest; var PageNumber: Integer; var PageSize: Integer; var Direction: String; var Sort: String; var Search: String; var Join:string; var Method:string);
begin
  PageNumber := 1;
  PageSize := 50;
  Direction := EmptyStr;
  Sort := EmptyStr;
  Search := EmptyStr;
  Join := EmptyStr;
  Method := EmptyStr;
  if Request.QueryFields.IndexOfName('pageNumber') >= 0 then
    PageNumber := Request.QueryFields.Values['pageNumber'].ToInteger;
  if Request.QueryFields.IndexOfName('pageSize') >= 0 then
    PageSize := Request.QueryFields.Values['pageSize'].ToInteger;
  if Request.QueryFields.IndexOfName('direction') >= 0 then
    Direction := Request.QueryFields.Values['direction'];
  if Request.QueryFields.IndexOfName('sort') >= 0 then
    Sort := Request.QueryFields.Values['sort'];
  if Request.QueryFields.IndexOfName('search') >= 0 then
    Search := Request.QueryFields.Values['search'];
  if Request.QueryFields.IndexOfName('join') >= 0 then
    Join := Request.QueryFields.Values['join'];
  if Request.QueryFields.IndexOfName('method') >= 0 then
    Method := Request.QueryFields.Values['method'];
end;

procedure TWebModuleApi.ValidarAcesso(pValue: String);
const
  TAG: String = 'Bearer ';
Var
  lToken: String;
  lResult: boolean;
begin
  lResult := False;
  if Pos(TAG,pValue) = 1 then
  begin
    lToken := StringReplace(pValue,TAG,'',[]);
    lResult := TToken.Validar(lToken);
  end;
  if Not lResult then
  begin
    TMessage.Create(EAcessoNegado,'Token inválido.').SendMessage(Response);
  end;
end;

function TWebModuleApi.ValidarUsuarioPadrao(AParams: TDictionary<string, string>): Boolean;
const
  USER = 'WK_TECNOLOGY';
  PASSWORD = '12345';
var
  LUser,LPassword:String;
begin
  Result := False;

  LUser := AParams.Items['user'];
  LPassword := AParams.Items['password'];

  if (LUser.ToUpper = USER) and (LPassword.ToUpper = PASSWORD) then
    Result := True;
end;

initialization

finalization
  Web.WebReq.FreeWebModules;

end.
