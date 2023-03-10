unit Server.ResourceBaseClass;

interface

uses
  System.Classes, System.Rtti, System.JSON, Web.HTTPApp, Server.Attributes,
  Server.Message, Server.MessageList, System.Generics.Collections,
  Server.Connection, System.DateUtils;

type
  TResourceBaseClass = class(TPersistent)
  private
    FFieldsJSON: TStringList;
    function GetRttiType: TRttiType; overload;
    function GetRttiType(Instance: TObject): TRttiType; overload;
    function GetValueSequence(SequenceName: String): Integer;
    function GetRttiField(Name: String; Instance: TObject): TRttiField;
    procedure SetDados(Dados: TJSONObject; List: TObjectList<TObject>);
    procedure AddResourceList(Dados: TJSONObject; List: TObjectList<TObject>; Resource: TObject);
    procedure SetValueObject(FieldName: String; Value: String; Instance: TObject);
    procedure ValidateInteger(FieldName, Value: String);
    procedure ValidateNotNull(Instance: TObject);
    procedure ValidateID(ID: Integer; Instance: TObject);
    procedure SetPrimaryKey(ID: Integer);
    function GetResourceName(AClass: TClass): String;
  protected
    FResponse: TWebResponse;
    FResult: Boolean;
    procedure ValidateBusiness(List: TObjectList<TObject>); virtual;
    function GetWherePadrao: String; virtual;
  public
    procedure SetAutoInc(Instance: TObject);
    [Get]
    procedure Get(Response: TWebResponse; PageNumber: Integer; PageSize: Integer;
      Direction: String; Sort: String; Search: String; ID: String; Join:string;
      Method:string; JSON:TJSONObject; Request: TWebRequest);
    [Post]
    procedure Post(Response: TWebResponse; Dados: TJSONObject); virtual;
    [Put]
    procedure Put(Response: TWebResponse; ID: Integer; Dados: TJSONObject); virtual;
    [Delete]
    procedure Delete(Response: TWebResponse; ID: Integer); virtual;
  end;

implementation

uses
  System.SysUtils, Server.DAO, Server.Controller;

{ TResourceBaseClass }
procedure TResourceBaseClass.AddResourceList(Dados: TJSONObject;
  List: TObjectList<TObject>; Resource: TObject);
var
  Item: TJSONPair;
  FieldName: String;
  Value: String;
begin
  FFieldsJSON := TStringList.Create;
  for Item in Dados do
  begin
    FieldName := Item.JsonString.Value;
    Value := Item.JsonValue.Value;
    SetValueObject(FieldName, Value, Resource);
  end;
  SetAutoInc(Resource);
  ValidateNotNull(Resource);
  List.Add(Resource);
  ValidateBusiness(List);
end;

procedure TResourceBaseClass.Delete(Response: TWebResponse; ID: Integer);
begin
  FResponse := Response;
  SetPrimaryKey(ID);
  TDAO.Delete(Response, Self);
end;

procedure TResourceBaseClass.SetPrimaryKey(ID: Integer);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  RttiType := GetRttiType;
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
        if (RttiAttribute as DBField).Constraints = PrimaryKey then
          RttiField.SetValue(Self, ID)
end;

function TResourceBaseClass.GetResourceName(AClass: TClass): String;
var
  RttiContext: TRttiContext;
  Classe: TRttiType;
  Attribute: TCustomAttribute;
begin
  RttiContext := TRttiContext.Create;
  Classe := RttiContext.GetType(AClass);
  for Attribute in Classe.GetAttributes do
    if Attribute is Resource then
      Result := Resource(Attribute).ResourceName;
end;

function TResourceBaseClass.GetRttiField(Name: String; Instance: TObject): TRttiField;
var
  RttiType: TRttiType;
begin
  RttiType := GetRttiType(Instance);
  Result := RttiType.GetField(Name);
end;

function TResourceBaseClass.GetRttiType(Instance: TObject): TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  Result := RttiContext.GetType(Instance.ClassInfo);
end;

procedure TResourceBaseClass.ValidateBusiness(List: TObjectList<TObject>);
begin

end;

procedure TResourceBaseClass.ValidateID(ID: Integer; Instance: TObject);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  if ID > 0 then
  begin
    RttiType := GetRttiType(Instance);
    for RttiField in RttiType.GetFields do
      for RttiAttribute in RttiField.GetAttributes do
        if RttiAttribute is DBField then
          if (RttiAttribute as DBField).Constraints = PrimaryKey then
            if RttiField.GetValue(Instance).AsInteger <> ID then
              TMessage.Create(EDadosNaoSalvos, 'ID Incompat?vel').SendMessage(FResponse);
  end;
end;

function TResourceBaseClass.GetRttiType: TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  Result := RttiContext.GetType(Self.ClassInfo);
end;

procedure TResourceBaseClass.Get(Response: TWebResponse; PageNumber: Integer; PageSize: Integer;
      Direction: String; Sort: String; Search: String; ID: String; Join:string;
      Method:string; JSON:TJSONObject; Request: TWebRequest);
var
  List: TObjectList<TObject>;
  RttiType: TRttiType;
  RttiAttribute: TCustomAttribute;
  Controller: TObject;
  ControllerClass: TClass;
  ControllerObj: TObject;
  LResultJSON: TJSONObject;
begin
  FResponse := Response;
  Response.ContentType  := 'application/json;charset=UTF-8';
  if Method <> EmptyStr then
  begin
    List := TObjectList<TObject>.Create;
    LResultJSON := TJSONObject.Create;
    try
      List.Add(Self);
      for Controller in List do
      begin
        RttiType := GetRttiType(Controller);
        for RttiAttribute in RttiType.GetAttributes do
          if RttiAttribute is Controllers then
          begin
            ControllerClass := (RttiAttribute as Controllers).ControllerClass;
            ControllerObj := ControllerClass.Create;
            TController(ControllerObj).SetLengthParams(12);
            TController(ControllerObj).SetParams(Response, 0);
            TController(ControllerObj).SetParams(PageNumber, 1);
            TController(ControllerObj).SetParams(PageSize, 2);
            TController(ControllerObj).SetParams(Direction, 3);
            TController(ControllerObj).SetParams(Sort, 4);
            TController(ControllerObj).SetParams(Search, 5);
            TController(ControllerObj).SetParams(ID, 6);
            TController(ControllerObj).SetParams(GetWherePadrao, 7);
            TController(ControllerObj).SetParams(Join, 8);
            TController(ControllerObj).SetParams(Method, 9);
            TController(ControllerObj).SetParams(JSON, 10);
            TController(ControllerObj).SetParams(Request, 11);
            LResultJSON := TController(ControllerObj).Execute(Method);
          end;
      end;

      try
        Response.ContentType  := 'application/json;charset=UTF-8';
        Response.Content := LResultJSON.ToString;
        Response.SendResponse;
      except
        on E: Exception do
          TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Response);
      end;
    finally
      FreeAndNil(LResultJSON);
    end;
  end
  else
    TDAO.Select(Response, Self, PageNumber, PageSize, Direction, Sort, Search, ID, GetWherePadrao,Join,JSON);
end;

function TResourceBaseClass.GetWherePadrao: String;
begin
  Result := EmptyStr;
end;

procedure TResourceBaseClass.Post(Response: TWebResponse; Dados: TJSONObject);
var
  List: TObjectList<TObject>;
begin
  FResponse := Response;
  List := TObjectList<TObject>.Create;
  SetDados(Dados, List);
  TDAO.Insert(Response, List, Dados, GetResourceName(Self.ClassType));
end;

procedure TResourceBaseClass.Put(Response: TWebResponse; ID: Integer; Dados: TJSONObject);
var
  List: TObjectList<TObject>;
begin
  FResponse := Response;
  List := TObjectList<TObject>.Create;
  SetDados(Dados, List);
  ValidateID(ID, Self);
  ValidateNotNull(Self);
  List.Add(Self);
  TDAO.Update(Response, List, Dados);
end;

procedure TResourceBaseClass.SetDados(Dados: TJSONObject; List: TObjectList<TObject>);
var
  LJSONString: String;
  LJSONArray: TJSONArray;
  LJSONObject: TJSONObject;
  i: Integer;
  LResourceObject: TObject;
  LResourceClass: TClass;
begin
  LJSONObject := TJSONObject.Create;
  LJSONArray := TJSONArray.Create;
  LJSONString := TJSONObject(Dados).ToJSON;
  if Pos('[', LJSONString) > 0 then
  begin
    LJSONString := TJSONObject(Dados.GetValue(GetResourceName(Self.ClassType))).ToJSON;
    LJSONArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(LJSONString), 0) as TJSONArray;
  end
  else
  begin
    LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(LJSONString), 0) as TJSONObject;
    //LJSONObject := Dados;
    LResourceObject := Self;
  end;

  try
    if LJSONObject.ToJson <> '{}' then
      AddResourceList(LJSONObject, List, Self);
    for i := 0 to Pred(LJSONArray.Count) do
    begin
      LJSONObject := LJSONArray.Items[i] as TJSONObject;
      LResourceClass := Self.ClassType;
      LResourceObject := LResourceClass.Create;
      AddResourceList(LJSONObject, List, LResourceObject);
    end;
  finally
    if LJSONArray.ToJson = '[]' then
      LJSONArray.DisposeOf;
    LJSONObject.DisposeOf;
  end;
end;

procedure TResourceBaseClass.SetValueObject(FieldName: String; Value: String; Instance: TObject);
var
  RttiField: TRttiField;
  RttiValue: TValue;
begin
  RttiField := GetRttiField(FieldName, Instance);
  if RttiField <> nil then
  begin
    if RttiField.FieldType.TypeKind in [tkInteger] then
    begin
      if Value <> EmptyStr then
      begin
        ValidateInteger(FieldName, Value);
        RttiValue := Value.ToInteger;
      end;
    end
    else if RttiField.FieldType.TypeKind in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar, tkWideString, tkChar] then
      RttiValue := Value
    else if RttiField.FieldType.TypeKind in [tkEnumeration] then
      RttiValue := Value.ToBoolean
    else if RttiField.FieldType.TypeKind in [tkFloat] then
    begin
      if (RttiField.FieldType.Name = 'TDateTime')then
        RttiValue := StrToDateTime(Value)
      else if (RttiField.FieldType.Name = 'TDate') then
        RttiValue := StrToDate(Value)
      else if (RttiField.FieldType.Name = 'TTime') then
        RttiValue := StrToTime(Value)
      else
        RttiValue:= StringReplace(Value, '.', ',', [rfReplaceAll]).ToDouble;
    end
    else if (RttiField.FieldType.Name = 'TMacAddress')then
      RttiValue := TMacAddress.Create(Value)
    else if (RttiField.FieldType.Name = 'TBytea')then
      RttiValue := TBytea.Create(Value);

    RttiField.SetValue(Instance, RttiValue);
    FFieldsJSON.Add(FieldName);
  end;
end;

procedure TResourceBaseClass.ValidateInteger(FieldName: String; Value: String);
var
  I: Integer;
begin
  if not(TryStrToInt(Value, I)) then
    TMessage.Create(EDadosNaoSalvos, FieldName + ' deve ser um n?mero v?lido').SendMessage(FResponse);
end;

procedure TResourceBaseClass.ValidateNotNull(Instance: TObject);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  RttiType := GetRttiType(Instance);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
        if (RttiAttribute as DBField).Constraints in [NotNull] then
          if FFieldsJSON.IndexOf(RttiField.Name) < 0 then
            TMessage.Create(ECampoNotNullNaoPreenchido, RttiField.Name + ' ? obrigat?rio').SendMessage(FResponse);
end;

procedure TResourceBaseClass.SetAutoInc(Instance: TObject);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  SequenceName: String;
  Value: Integer;
begin
  RttiType := GetRttiType(Instance);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is AutoInc then
      begin
        SequenceName := (RttiAttribute as AutoInc).SequenceName;
        Value := GetValueSequence(SequenceName);
        RttiField.SetValue(Instance, Value);
      end;
end;

function TResourceBaseClass.GetValueSequence(SequenceName: String): Integer;
const
  SQL = 'SELECT nextval(%s) seq';
var
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(Format(SQL, [QuotedStr(SequenceName)]));
    Connection.Query.Open;
    Result := Connection.Query.FieldByName('seq').AsInteger;
  finally
    Connection.Free;
  end;
end;

end.
