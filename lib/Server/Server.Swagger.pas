unit Server.Swagger;

interface

uses
  classes,
  sysutils,
  System.Rtti,
  Swager.Json.DTO,
  System.Json,
  System.StrUtils,
  Swager.Json.Body,
  Server.Attributes,
  Server.ResourceBaseClass,
  Server.AngularModel,
  Utils.Strings,
  Swager.Json.Paths;

type
  TSwagerAPI = class
  private
    FoutPaht: string;
    FFieldType: string;
    Lclass: string;
    Lcontraints: string;
    FSchemaDefinitions: TjsonObject;
    Lsize: string;
    FServer: TServer;
    FbodySwager: TRootDTO;
    FOutJson: TStringList;
    FPathsJson: TStringList;
    FAngularModel: TAngularModel;
    FDefinitionsJson: TStringList;
    procedure GetClassesProc(AClass: TPersistentClass);
    procedure setSchemaProps(sFieldType, sDescription, sSize, sName,
      sContraints: string; pRequired: TJSONArray; pProperts: TjsonObject);

    class function GetRttiType(Obj: TObject): TRttiType;
    procedure ParseClass(AClassName: String);
  public
    procedure MakeReposioty;
    constructor create;
    destructor destroy;
  end;

implementation

{ TSwagerAPI }

constructor TSwagerAPI.create;
begin
  FbodySwager := TRootDTO.create;
  FServer := TServer.Create;
  FServer.url := 'http://' + _ctServer + '/v1';
  FbodySwager.servers.Add(FServer);

  FOutJson := TStringList.create;
  FPathsJson := TStringList.create;
  FDefinitionsJson := TStringList.create;
  FoutPaht := ExtractFilePath(GetModuleName(HInstance)) + 'www' + PathDelim +
    'api' + PathDelim + 'help' + PathDelim + 'swagger.json';

  Inherited;
end;

procedure TSwagerAPI.MakeReposioty;
var
  _index: integer;
  _ClassFinder: TClassFinder;
  pathSwaggerJSON: String;
begin
  FSchemaDefinitions := TjsonObject.create;
  FOutJson.Text := FbodySwager.ToString;
  _ClassFinder := TClassFinder.create(nil);
  if assigned(_ClassFinder) then
  begin
    try
      _ClassFinder.GetClasses(GetClassesProc);

    finally
      _ClassFinder.Free;
    end;
    FOutJson.Text := StringReplace(FOutJson.Text, '"definitions":{}',
      '"definitions": ' + FSchemaDefinitions.ToString + '',
      [rfReplaceAll, rfIgnoreCase]);

    FOutJson.Text := StringReplace(FOutJson.Text, '"paths":{}',
      '"paths":{' + FPathsJson.Text + '}', [rfReplaceAll, rfIgnoreCase]);

    pathSwaggerJSON := ExtractFilePath(GetModuleName(HInstance)) + 'www' +
    PathDelim + 'api' + PathDelim + 'help';
    if not DirectoryExists(pathSwaggerJSON) then
      ForceDirectories(pathSwaggerJSON);

    FOutJson.SaveToFile(FoutPaht);

  end;

end;

destructor TSwagerAPI.destroy;
begin
  FbodySwager := TRootDTO.create;
  FreeAndNil(FOutJson);
  FreeAndNil(FPathsJson);
  FreeAndNil(FDefinitionsJson);

  FreeAndNil(FSchemaDefinitions);
end;

procedure TSwagerAPI.GetClassesProc(AClass: TPersistentClass);
var
  RttiContext: TRttiContext;
  Classe: TRttiType;
  Attribute: TCustomAttribute;
begin
  RttiContext := TRttiContext.create;
  Classe := RttiContext.GetType(AClass);
  for Attribute in Classe.GetAttributes do
    if Attribute is Resource then
      ParseClass(Classe.QualifiedName);
end;

class function TSwagerAPI.GetRttiType(Obj: TObject): TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.create;
  Result := RttiContext.GetType(Obj.ClassInfo);
end;

procedure TSwagerAPI.setSchemaProps(sFieldType, sDescription, sSize, sName,
  sContraints: string; pRequired: TJSONArray; pProperts: TjsonObject);
var
  Obj: TjsonObject;
  SwagerDataType: string;
begin
  SwagerDataType := LowerCase(sFieldType);

  if (SwagerDataType = 'datetime') or (SwagerDataType = 'time') or
    (SwagerDataType = 'date') then
    SwagerDataType := 'date';
  if (SwagerDataType = 'double') then
    SwagerDataType := 'number';

  if (AnsiLowerCase(SwagerDataType) = AnsiLowerCase('TBytea')) then
    SwagerDataType := 'string';
  Obj := TjsonObject.create;
  Obj.AddPair('type', SwagerDataType);
  if sDescription = '' then
  begin
    sDescription := 'Campo ' + sName;
  end;
  Obj.AddPair('description', sDescription);
  if SwagerDataType = 'integer' then
  begin
    Obj.AddPair('format', 'int64');
    Obj.AddPair('example', '1');
  end;

  if SwagerDataType = 'date' then
  begin
    Obj.AddPair('pattern', '/([0-9]{4})-(?:[0-9]{2})-([0-9]{2})/');
    Obj.AddPair('example', '2023-01-17');
  end;
  if (SwagerDataType = 'string') and (sSize <> '') then
    Obj.AddPair('size', copy(sSize, 3, Length(sSize)));

  pProperts.AddPair(sName, Obj);

  if (sContraints = 'NotNull') or (sContraints = 'PrimaryKey') then
    pRequired.Add(sName);
  // Ajustar para o padrao do TypeScript
  if (SwagerDataType = 'integer') then
    SwagerDataType := 'number';

  if SwagerDataType = 'date' then
    SwagerDataType := 'Date';
  // permitir que a pk seja opcional
  if (sContraints = 'PrimaryKey') then
    FAngularModel.FieldsList.Add(sName + '?:' + SwagerDataType)
  else
    FAngularModel.FieldsList.Add(sName + ':' + SwagerDataType)
end;

procedure TSwagerAPI.ParseClass(AClassName: String);
var
  RttiContext: TRttiContext;
  RttiInstanceType: TRttiInstanceType;
  RttiMethod: TRttiMethod;
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  LstrTmp: string;
  LfieldType: string;
  LResouce: TRoot;
  Instance: TObject;
  LSchemaDetail: TjsonObject;
  LRequired: TJSONArray;
  LProperts: TjsonObject;

begin

  LResouce := TRoot.create;
  FAngularModel := TAngularModel.create;
  Lclass := LowerCase(SplitString(AClassName, '.')[1]);
  LstrTmp := LResouce.ToString;
  LstrTmp := copy(LstrTmp, 2, Length(LstrTmp) - 2);
  LstrTmp := StringReplace(LstrTmp, '$ResourceBase', Lclass,
    [rfReplaceAll, rfIgnoreCase]);
  if FPathsJson.Count = 0 then

    FPathsJson.Add(LstrTmp)
  else
    FPathsJson.Add(', ' + LstrTmp);

  RttiContext := TRttiContext.create;
  RttiInstanceType := RttiContext.FindType(AClassName).AsInstance;
  RttiMethod := RttiInstanceType.GetMethod('Create');
  Instance := RttiMethod.Invoke(RttiInstanceType.MetaclassType, []).AsObject;
  RttiType := GetRttiType(Instance);
  LSchemaDetail := TjsonObject.create;
  LSchemaDetail.AddPair('type', 'object');
  LSchemaDetail.AddPair('description', 'Dados ' + Lclass);
  LRequired := TJSONArray.create;
  LProperts := TjsonObject.create;

  for RttiField in RttiType.GetFields do
  begin
    Lcontraints := '';
    Lsize := '';
    for RttiAttribute in RttiField.GetAttributes do
    begin
      if RttiAttribute is DBField then
      begin

        if RttiField.FieldType.TypeKind in [tkInteger, tkInt64] then
        begin
          LfieldType := 'integer';
        end
        else if RttiField.FieldType.TypeKind
          in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar,
          tkWideString, tkChar] then
        begin
          LfieldType := 'string';

        end
        else if RttiField.FieldType.TypeKind in [tkFloat] then
        begin
          case IndexStr(RttiField.FieldType.Name,
            ['TDateTime', 'TDate', 'TTime']) of

            0:
              LfieldType := 'DateTime';
            1:
              LfieldType := 'Date';
            2:
              LfieldType := 'Time';
          else
            LfieldType := 'Double';
          end;
        end
        else if RttiField.FieldType.TypeKind in [tkEnumeration] then
          LfieldType := 'boolean'
        else if RttiField.FieldType.Name = 'TMacAddress' then
          LfieldType := 'MacAddress'
        else if RttiField.FieldType.Name = 'TBytea' then
          LfieldType := 'byte'
        else
          LfieldType := 'string';

        if (RttiAttribute as DBField).Constraints = PrimaryKey then
          Lcontraints := 'PrimaryKey';
        if (RttiAttribute as DBField).Constraints = NotNull then
          Lcontraints := 'NotNully';

        setSchemaProps(LfieldType, '', Lsize, (RttiField.Name), Lcontraints,
          LRequired, LProperts);

      end;
    end;
  end;
  LSchemaDetail.AddPair('required', LRequired);
  LSchemaDetail.AddPair('properties', LProperts);
  FSchemaDefinitions.AddPair(Lclass, LSchemaDetail);
  FDefinitionsJson.Clear;
  FDefinitionsJson.Add(FSchemaDefinitions.ToJSON);
  try
    FAngularModel.ClassName := Lclass;
    FAngularModel.saveModel;
  finally
    FreeAndNil(FAngularModel);
  end;

end;

end.
