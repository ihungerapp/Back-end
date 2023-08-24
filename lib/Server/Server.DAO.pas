unit Server.DAO;

interface

uses
  Server.Message, System.Rtti, Server.Attributes, FireDAC.Stan.Param, Web.HTTPApp, System.JSON,
  System.Generics.Collections, Server.Connection, Server.MessageList, System.DateUtils, System.Classes;

type
  TExec = (teInsert, teUpdate, teDelete);
  TPesquisa = (tpInicio, tpTodoCampo, tpFim, tpSemIncidencia);

  TDAO = class
  private
    class function GetRttiType(Obj: TObject): TRttiType; static;
    class function GetTableName(Obj: TObject): String; static;
    class function GetRelationship(Obj: TObject; var NameRelationship: String): TObjectList<TObject>; static;
    class function GetFields(Obj: TObject; ListHeader: Boolean = False; ListSelect: Boolean = False): String;
    class function GetWhere(Obj: TObject; ID: String; Search: String; WherePadrao: String; TipoPesquisa:TPesquisa): String; overload;
    class function GetOrder(Obj: TObject; Sort: String; Direction: String): String;
    class function GetTotalElements(lSQL: String): Integer;
    class procedure SetFieldsAndParams(Tipo: TExec; Obj: TObject; var FieldsName: String; var ParamsOrWhereName: String;
    Params: TFDParams; ParamsRelationship: TFDParams = nil);
    class procedure ExecQuery(var Result: TMessageType; lSQL: string; Params: TFDParams);
    class procedure SetParams(Obj: TObject; RttiField: TRttiField; RttiAttribute: TCustomAttribute;
    Params: TFDParams; ParamsRelationship: TFDParams = nil);
    class procedure SetDadosInMessage(Obj: TObject; var Result: TMessageType; pChave: string = ''; aResourceName: String = ''; aJSONArray: TJSONArray = nil);
    class procedure InsertAplicativosLojas(ID: Integer; Dados: TJSONObject; Connection: TConnection); static;
    class function GetID(Obj: TObject): Integer; static;
    class function GetJoin(AJoin:string):string;static;
    class function OpenQuery(Response: TWebResponse; lSQL: string; Obj: TObject): TJSONArray; overload;
    class function OpenQuery(Response: TWebResponse; lSQL: string; Connection: TConnection): TConnection; overload;
    class function GetPrimaryKeyName(Instance: TObject): String;
    class function IsValidGuid(GUID: String): Boolean;

  public
    class procedure Select(Response: TWebResponse; Obj: TObject; PageNumber: Integer; PageSize: Integer; Direction: String; Sort: String; Search: String; ID: String; WherePadrao: String;Join:string; JSON:TJSONObject);overload;
    class procedure Insert(Response: TWebResponse; ListObj: TObjectList<TObject>; Dados: TJSONObject; aResourceName: String = '');
    class procedure Update(Response: TWebResponse; ListObj: TObjectList<TObject>; Dados: TJSONObject; aResourceName: String = '');
    class procedure Delete(Response: TWebResponse; Obj: TObject);
    class function CreateJSONObject(Connection: TConnection; Params: array of TValue):TJSONObject;static;
    class function GetWhere(Search: String; TipoPesquisa:TPesquisa; Response: TWebResponse): String; overload;
    class function OpenQueryToJSON(const SQL, Where, Servico: String; const Params: array of TValue): TJSONObject;
  end;

implementation

uses
  Data.DB, System.StrUtils, System.SysUtils;

{ TDAO }
class procedure TDAO.Insert(Response: TWebResponse; ListObj: TObjectList<TObject>;
Dados: TJSONObject; aResourceName: String = '');
var
  Connection: TConnection;
  TableName: String;
  FieldsName: String;
  ParamsName: String;
  ParamsValues: String;
  PrimaryKeyName: String;
  SQL: String;
  LChave: String;
  Params: TFDParams;
  lParam: TFDParam;
  ParamsRelationship: TFDParams;
  LNameRelationship: String;
  Mensagem: TMessageType;
  Obj: TObject;
  RttiType: TRttiType;
  LJSONArray: TJSONArray;
  ListRelationship: TObjectList<TObject>;
  I: Integer;
begin
  Response.ContentType  := 'application/json;charset=UTF-8';
  Mensagem := IRegistroInserido;
  Connection := TConnection.Create;
  if ListObj.Count > 1 then
    LJSONArray := TJSONArray.Create;
  try
    try
      //Connection.DB.StartTransaction;
      for Obj in ListObj do
      begin
        PrimaryKeyName := GetPrimaryKeyName(Obj);
        SQL := 'INSERT INTO %s (%s) VALUES (%s) RETURNING ' + PrimaryKeyName;
        Params := TFDParams.Create;
        TableName := GetTableName(Obj);
        SetFieldsAndParams(teInsert, Obj, FieldsName, ParamsName, Params);
        Connection.Query.SQL.Clear;

        ParamsValues := EmptyStr;
        for I := 0 to Pred(Params.Count) do
        begin
          if I > 0 then
            ParamsValues := ParamsValues + ', ';
          if Params[I].DataType in [ftString, ftDateTime, ftDate] then
            ParamsValues := ParamsValues + QuotedStr(Params[I].Value)
          else
          if Params[I].DataType in [ftFloat] then
            ParamsValues := ParamsValues + StringReplace(FloatToStr(Params[I].Value), ',', '.', [rfReplaceAll])
          else
          if Params[I].DataType in [ftBoolean] then
            ParamsValues := ParamsValues + QuotedStr(Params[I].Value)
          else
            ParamsValues := ParamsValues + IntToStr(Params[I].Value)
        end;

        Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName, ParamsValues]));
//        Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName, ParamsName]));
//        Connection.Query.Params.Clear;
//        Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName,
//                                 StringReplace(ParamsName, '"', '', [rfReplaceAll])]));
//        Connection.Query.Params := Params;
        Connection.Query.Open;
        LChave := Connection.Query.FieldByName(StringReplace(PrimaryKeyName, '"', '', [rfReplaceAll])).AsString;

        ListRelationship := nil;
        ListRelationship := GetRelationship(Obj, LNameRelationship);
        if Assigned(ListRelationship) and (ListRelationship.Count > 0) then
        begin
          for I := 0 to Pred(ListRelationship.Count) do
          begin
            lParam := Params.Add;
            lParam.Name := PrimaryKeyName;
            lParam.ParamType := ptInput;
            lParam.DataType := ftInteger;
            lParam.Value := LChave.ToInteger;

            PrimaryKeyName := GetPrimaryKeyName(ListRelationship.Items[I]);
            SQL := 'INSERT INTO %s (%s) VALUES (%s) RETURNING ' + PrimaryKeyName;
            ParamsRelationship := TFDParams.Create;
            TableName := GetTableName(ListRelationship.Items[I]);
            SetFieldsAndParams(teInsert, ListRelationship.Items[I], FieldsName,
              ParamsName, ParamsRelationship, Params);
            Connection.Query.SQL.Clear;
            Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName, ParamsName]));
            Connection.Query.Params := ParamsRelationship;
            Connection.Query.Open;
          end;
          ListRelationship.Clear;
        end;

        RttiType := GetRttiType(Obj);
        if RttiType.ToString = 'TAplicativos' then
          InsertAplicativosLojas(GetID(Obj), Dados, Connection);

        if ListObj.Count = 1 then
          SetDadosInMessage(Obj, Mensagem, LChave)
        else
          SetDadosInMessage(Obj, Mensagem, LChave, aResourceName, LJSONArray);
      end;
      //Connection.DB.Commit;
    except
      on E: Exception do
      begin
        //Connection.DB.Rollback;
        TMessage.Create(EDadosNaoSalvos, E.Message).SendMessage(Response);
      end;
    end;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
  TMessage.Create(Mensagem).SendMessage(Response);
end;

class procedure TDAO.Select(Response: TWebResponse; Obj: TObject; PageNumber: Integer;
PageSize: Integer; Direction: String; Sort: String; Search: String; ID: String;
WherePadrao: String; Join:string; JSON:TJSONObject);
const
  SQL = 'SELECT %s FROM %s %s %s %s %s';
var
  lFields: String;
  lTableName: String;
  lWhere: String;
  lOrder: String;
  lPagination: String;
  lSQL: String;
  lDados: TJSONArray;
  lResult: TJSONObject;
  lTotalElements: Integer;
  lTotalPages: Integer;
  lJoin:string;
  LTpPesquisa:TPesquisa;
  LValueTypeSearch:string;
begin
  LTpPesquisa := tpTodoCampo;
  if Assigned(JSON) then
  begin
    LValueTypeSearch := JSON.GetValue<string>('TypeSearch').ToLower;
    if(LValueTypeSearch = 'first') then
      LTpPesquisa := tpInicio
    else if LValueTypeSearch = 'all' then
      LTpPesquisa := tpTodoCampo
    else if LValueTypeSearch = 'last' then
      LTpPesquisa := tpFim
    else if LValueTypeSearch = 'no incidence' then
      LTpPesquisa := tpSemIncidencia;
  end;
  if ID = 'list-select' then
    lFields := GetFields(Obj, False, True)
  else if ID = EmptyStr then
    lFields := GetFields(Obj, True)
  else
    lFields := GetFields(Obj);
  lTableName := GetTableName(Obj);
  lWhere := GetWhere(Obj, ID, Search, WherePadrao, LTpPesquisa);
  lOrder := GetOrder(Obj, Sort, Direction);
  lPagination := ' LIMIT ' + PageSize.ToString + ' OFFSET ' + (PageSize * (PageNumber-1)).ToString;
  lJoin := GetJoin(Join);
  lSQL := Format(SQL, [lFields, lTableName, lJoin, lWhere, lOrder, lPagination]);
  lDados := OpenQuery(Response, lSQL, Obj);

  Response.ContentType  := 'application/json;charset=UTF-8';
  if ID = 'list-select' then
  begin
    Response.Content := lDados.ToString;
    Response.SendResponse;
  end
  else if ID = EmptyStr then
  begin
    lResult := TJSONObject.Create;
    lResult.AddPair('content', lDados);
    lSQL := 'SELECT COUNT(*) AS QTD FROM %s %s %s';
    lSQL := Format(lSQL, [lTableName, lJoin, lWhere]);
    lTotalElements := GetTotalElements(lSQL);
    lResult.AddPair('totalElements', TJSONNumber.Create(lTotalElements));
    if (lTotalElements mod PageSize) <> 0 then
      lTotalPages := (lTotalElements div PageSize) + 1
    else
      lTotalPages := (lTotalElements div PageSize);
    lResult.AddPair('totalPages', TJSONNumber.Create(lTotalPages));
    lResult.AddPair('pageSize', TJSONNumber.Create(PageSize));
    lResult.AddPair('pageNumber', TJSONNumber.Create(PageNumber));
    Response.Content := lResult.ToString;
    Response.SendResponse;
  end
  else
  begin
    if lDados.Count >=1 then
    begin
      lResult := TJSONObject(lDados.Items[0]);
      Response.Content := lResult.ToString;
      Response.SendResponse;
    end
    else
    begin
      Response.Content := '{}';
      Response.SendResponse;
    end;
  end;
end;

class procedure TDAO.SetFieldsAndParams(Tipo: TExec; Obj: TObject; var FieldsName: String; var ParamsOrWhereName: String;
    Params: TFDParams; ParamsRelationship: TFDParams = nil);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  FieldsName := EmptyStr;
  ParamsOrWhereName := EmptyStr;
  RttiType := GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
  begin
    for RttiAttribute in RttiField.GetAttributes do
      if (RttiAttribute is DBField)
      and (((RttiAttribute as DBField).ListSelect) or (Tipo = teInsert)) then
      begin
        if (((RttiAttribute as DBField).Constraints = PrimaryKey) and (Tipo in [teUpdate, teDelete])) then
        begin
          if ParamsOrWhereName <> EmptyStr then
            ParamsOrWhereName := ParamsOrWhereName + ' AND ';
          ParamsOrWhereName := ParamsOrWhereName + (RttiAttribute as DBField).FieldName + ' = :' + (RttiAttribute as DBField).FieldName;
          SetParams(Obj, RttiField, RttiAttribute, Params);
        end
        else
        if ((RttiAttribute as DBField).Constraints <> PrimaryKey)
        and (Tipo <> teDelete) then
        begin
          FieldsName := FieldsName + (RttiAttribute as DBField).FieldName;
          if Tipo = teUpdate then
          begin
            if (RttiAttribute as DBField).FieldName = 'PEDIDO_STATUS' then
              FieldsName := FieldsName + ' = :' + (RttiAttribute as DBField).FieldName + '::pedido_status'
            else
            if (RttiAttribute as DBField).FieldName = 'PEDIDO_ITEM_STATUS' then
              FieldsName := FieldsName + ' = :' + (RttiAttribute as DBField).FieldName + '::pedido_item_status'
            else
            if (RttiAttribute as DBField).FieldName = 'MESA_UUID' then
              FieldsName := FieldsName + ' = :' + (RttiAttribute as DBField).FieldName + '::uuid'
            else
              FieldsName := FieldsName + ' = :' + (RttiAttribute as DBField).FieldName;

            if RttiField.FieldType.Name = 'TMacAddress' then
              FieldsName := FieldsName + '::macaddr'
            else if RttiField.FieldType.Name = 'TBytea' then
              FieldsName := FieldsName + '::bytea';
          end;
          FieldsName := FieldsName + ',';
          SetParams(Obj, RttiField, RttiAttribute, Params, ParamsRelationship);
        end;
      end;
  end;
  FieldsName := FieldsName.TrimRight([',']);
  if Tipo = teInsert then
  begin
    ParamsOrWhereName := ':' + StringReplace(FieldsName, ',', ',:', [rfReplaceAll]);
    ParamsOrWhereName := EmptyStr;
    RttiType := GetRttiType(Obj);
    for RttiField in RttiType.GetFields do
    begin
      for RttiAttribute in RttiField.GetAttributes do
        if (RttiAttribute is DBField)
        and ((RttiAttribute as DBField).Constraints <> PrimaryKey)
        and not Assigned((RttiAttribute as DBField).AutoIncrement) then
        begin
          if (RttiAttribute as DBField).FieldName = 'PEDIDO_STATUS' then
            ParamsOrWhereName := ParamsOrWhereName + ':' + (RttiAttribute as DBField).FieldName + '::pedido_status'
          else
          if (RttiAttribute as DBField).FieldName = 'PEDIDO_ITEM_STATUS' then
            ParamsOrWhereName := ParamsOrWhereName + ':' + (RttiAttribute as DBField).FieldName + '::pedido_item_status'
          else
            ParamsOrWhereName := ParamsOrWhereName + ':' + (RttiAttribute as DBField).FieldName;

          if RttiField.FieldType.Name = 'TPoint' then
            ParamsOrWhereName := ParamsOrWhereName + '::point'
          else if RttiField.FieldType.Name = 'TMacAddress' then
            ParamsOrWhereName := ParamsOrWhereName + '::macaddr'
          else if RttiField.FieldType.Name = 'TBytea' then
            ParamsOrWhereName := ParamsOrWhereName + '::bytea'
          else if RttiField.FieldType.Name = 'TIP' then
            ParamsOrWhereName := ParamsOrWhereName + '::inet';
          ParamsOrWhereName := ParamsOrWhereName + ',';
        end;
    end;
    ParamsOrWhereName := ParamsOrWhereName.TrimRight([',']);
  end
  else if Tipo in [teUpdate, teDelete] then
    ParamsOrWhereName := ParamsOrWhereName.TrimRight([',']);
end;

class function TDAO.GetFields(Obj: TObject; ListHeader: Boolean = False; ListSelect: Boolean = False): String;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  Result := EmptyStr;
  RttiType := GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
      begin
        if ListHeader then
        begin
          if (RttiAttribute as DBField).Header then
            Result := Result + (RttiAttribute as DBField).FieldName + ' as "' + RttiField.Name + '",';
        end
        else if ListSelect then
        begin
          if (RttiAttribute as DBField).ListSelect then
            Result := Result + (RttiAttribute as DBField).FieldName + ' as "' + RttiField.Name + '",';
        end
        else
          Result := Result + (RttiAttribute as DBField).FieldName + ' as "' + RttiField.Name + '",';
      end;
  Result := Result.TrimRight([',']);
end;

class function TDAO.GetOrder(Obj: TObject; Sort: String; Direction: String): String;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  Padrao: String;
begin
  Result := EmptyStr;
  Padrao := EmptyStr;
  RttiType := GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
      begin
        if (RttiAttribute as DBField).Sort then
        begin
          if Padrao <> EmptyStr then
            Padrao := Padrao + ',';
          Padrao := Padrao + (RttiAttribute as DBField).FieldName;
          if Direction = 'desc' then
            Padrao := Padrao + ' DESC';
        end;
        if LowerCase(RttiField.Name) = LowerCase(Sort) then
        begin
          Result := ' ORDER BY ' + (RttiAttribute as DBField).FieldName;
          if Direction = 'desc' then
            Result := Result + ' DESC';
        end;
      end;
  if Result = EmptyStr then
    if Padrao <> EmptyStr then
      Result := ' ORDER BY ' + Padrao;
end;

class function TDAO.GetPrimaryKeyName(Instance: TObject): String;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  RttiType := GetRttiType(Instance);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
        if (RttiAttribute as DBField).Constraints = PrimaryKey then
          Result := (RttiAttribute as DBField).FieldName;
end;

class function TDAO.GetTotalElements(lSQL: String): Integer;
var
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(lSQL);
    Connection.Query.Open;
    Result := Connection.Query.FieldByName('QTD').AsInteger;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
end;

class function TDAO.GetWhere(Search: String; TipoPesquisa: TPesquisa;
Response: TWebResponse): String;
const
  cSQL_ColsTable =
    'SELECT column_name,'+
    ' data_type,'+
    ' table_catalog,'+
    ' table_name,'+
    ' ordinal_position,'+
    ' is_nullable,'+
    ' table_schema'+
    ' FROM'+
    ' information_schema.columns'+
    ' WHERE table_name = %s and'+
    ' column_name = %s';
var
  ListWhere: TArray<String>;
  Itens: TStringList;
  Item: String;
  TableName: String;
  FieldName: String;
  Filter: String;
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  Result := EmptyStr;
  if Search <> EmptyStr then
  try
    Itens := TStringList.Create;
    ListWhere := Search.Split(['@@@']);
    for Item in ListWhere do
    begin
      if Length(Item.Split([':'])) = 3  then
      begin
        TableName := Item.Split([':'])[0];
        FieldName := Item.Split([':'])[1];
        Filter := Item.Split([':'])[2];

        //Seleciona as colunas da tabela para que seja feito a identificação do
        //tipo de dados e atribuir corretamente na cláusula where
        Connection := OpenQuery(Response, Format(cSQL_ColsTable, [QuotedStr(TableName), QuotedStr(FieldName)]), Connection);
        if (Connection.Query.FieldByName('data_type').AsString = 'integer') or
           (Connection.Query.FieldByName('data_type').AsString = 'numeric') or
           (Connection.Query.FieldByName('data_type').AsString = 'boolean') then
        begin
          if Result = EmptyStr then
            Result := ' WHERE (' + TableName + '.' + FieldName + ') = ' + Filter
          else
            Result := Result + ' AND (' + TableName + '.' + FieldName + ') = ' + Filter;
        end
        else
        begin
          if (TipoPesquisa = tpInicio) then
            Filter := Filter+'%'
          else if(TipoPesquisa = tpTodoCampo) then
            Filter := '%' + Filter + '%'
          else if (TipoPesquisa = tpFim) then
            Filter := '%'+Filter;

          if TipoPesquisa = tpSemIncidencia then
          begin
            if Result = EmptyStr then
              Result := ' WHERE ' + TableName + '.' + FieldName + ' = ' + QuotedStr(Filter)
            else
              Result := Result + ' AND ' + TableName + '.' + FieldName + ' = ' + QuotedStr(Filter);
          end
          else
          if Result = EmptyStr then
            Result := ' WHERE lower(' + TableName + '.' + FieldName + ') LIKE lower(' + QuotedStr(Filter) + ')'
          else
            Result := Result + ' AND lower(' + TableName + '.' + FieldName + ') LIKE lower(' + QuotedStr(Filter) + ')';
        end;
      end;
    end;
  finally
    Itens.Free;
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
end;

class function TDAO.CreateJSONObject(Connection: TConnection; Params: array of TValue): TJSONObject;
var
  lItem: TJSONObject;
  Field: TField;
  lTableName: String;
  lWhere: String;
  lSQL: String;
  lResult: TJSONObject;
  lTotalElements: Integer;
  lTotalPages: Integer;
  lJoin:string;
  PageSize: Integer;
  PageNumber: Integer;
  lJsonArray: TJSONArray;
begin

  PageNumber:=StrToInt(Params[1].ToString);
  PageSize:=StrToInt(Params[2].ToString);
  lJsonArray := TJSONArray.Create;
  try
    while not(Connection.Query.Eof) do
    begin
      lItem := TJSONObject.Create;
      for Field in Connection.Query.Fields do
        if Field.DataType = ftInteger then
          lItem.AddPair(LowerCase(Field.FieldName), TJSONNumber.Create(Field.AsInteger))
        else if Field.DataType = ftBoolean then
          lItem.AddPair(LowerCase(Field.FieldName), TJSONBool.Create(Field.Value))
        else if Field.DataType in [ftDate] then
        begin
          if Field.AsString <> EmptyStr then
            lItem.AddPair(LowerCase(Field.FieldName), Copy(DateToISO8601(Field.Value), 1, 10))
          else
            lItem.AddPair(LowerCase(Field.FieldName), '')
        end
        else
          lItem.AddPair(LowerCase(Field.FieldName), Field.AsString);
      lJsonArray.AddElement(lItem);
      Connection.Query.Next;
    end;

    lResult := TJSONObject.Create;
    lResult.AddPair('content', lJsonArray);
    lTotalElements := Connection.Query.RecordCount;
    lResult.AddPair('totalElements', TJSONNumber.Create(lTotalElements));
    if (lTotalElements mod PageSize) <> 0 then
      lTotalPages := (lTotalElements div PageSize) + 1
    else
      lTotalPages := (lTotalElements div PageSize);
    lResult.AddPair('totalPages', TJSONNumber.Create(lTotalPages));
    lResult.AddPair('pageSize', TJSONNumber.Create(PageSize));
    lResult.AddPair('pageNumber', TJSONNumber.Create(PageNumber));
    Result := lResult;
  finally
    //lJsonArray.Free;
  end;
end;

class procedure TDAO.Delete(Response: TWebResponse; Obj: TObject);
const
  SQL = 'DELETE FROM %s WHERE %s';
var
  TableName: String;
  FieldsName: String;
  WhereCondition: String;
  Params: TFDParams;
  Mensagem: TMessageType;
begin
  Mensagem := IRegistroExcluido;
  Params := TFDParams.Create;
  TableName := GetTableName(Obj);
  SetFieldsAndParams(teDelete, Obj, FieldsName, WhereCondition, Params);
  ExecQuery(Mensagem, Format(SQL, [TableName, WhereCondition]), Params);
  Response.ContentType  := 'application/json;charset=UTF-8';
  TMessage.Create(Mensagem).SendMessage(Response);
end;

class procedure TDAO.SetParams(Obj: TObject; RttiField: TRttiField; RttiAttribute: TCustomAttribute;
    Params: TFDParams; ParamsRelationship: TFDParams = nil);
var
  lParam: TFDParam;
  LAttribute: TCustomAttribute;
begin
  lParam := Params.Add;
  lParam.Name := (RttiAttribute as DBField).FieldName;
  lParam.ParamType := ptInput;
  if RttiField.FieldType.TypeKind in [tkInteger] then
  begin
    lParam.DataType := ftInteger;
    lParam.Value := RttiField.GetValue(Obj).AsInteger;
  end
  else if RttiField.FieldType.TypeKind in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar, tkWideString, tkChar] then
  begin
    if (Length(RttiField.GetValue(Obj).AsString) = 38)
    and (IsValidGuid(RttiField.GetValue(Obj).AsString)) then
      lParam.DataType := ftGuid
    else
      lParam.DataType := ftString;
    for LAttribute in RttiField.GetAttributes do
    begin
      if (LAttribute is DBFieldTypeMemo) then
      begin
        lParam.DataType := ftWideMemo;
        break;
      end;
    end;
    lParam.Value := RttiField.GetValue(Obj).AsString;
  end
  else if RttiField.FieldType.TypeKind in [tkFloat] then
  begin
    case IndexStr(RttiField.FieldType.Name, ['TDateTime', 'TDate', 'TTime']) of
      0:
      begin
        lParam.DataType := ftDateTime;
        lParam.Value := RttiField.GetValue(Obj).AsType<TDateTime>;
      end;
      1:
      begin
        lParam.DataType := ftDate;
        lParam.Value := RttiField.GetValue(Obj).AsType<TDate>;
      end;
      2:
      begin
        lParam.DataType := ftTime;
        lParam.Value := RttiField.GetValue(Obj).AsType<TTime>;
      end;
      else
      begin
        lParam.DataType := ftFloat;
        lParam.Value := RttiField.GetValue(Obj).AsExtended;
      end;
    end;
  end
  else if RttiField.FieldType.TypeKind in [tkEnumeration] then
  begin
    lParam.DataType := ftBoolean;
    lParam.Value := RttiField.GetValue(Obj).AsBoolean;
  end
  else if RttiField.FieldType.TypeKind in [tkRecord] then
  begin
    case IndexStr(RttiField.FieldType.Name, ['TDateTime']) of
      0:
      begin
        lParam.DataType := ftDateTime;
        lParam.Value := RttiField.GetValue(Obj).AsType<TDateTime>;
      end;
    end;
  end
  else if RttiField.FieldType.Name = 'TMacAddress' then
  begin
    lParam.DataType := ftString;
    lParam.Value := TMacAddress(RttiField.GetValue(Obj).AsObject).Value;
  end
  else if RttiField.FieldType.Name = 'TBytea' then
  begin
    lParam.DataType := ftString;
    lParam.Size := TBytea(RttiField.GetValue(Obj).AsObject).Value.Text.Length;
    lParam.Value := TBytea(RttiField.GetValue(Obj).AsObject).Value.Text;
  end
  else
  begin
    lParam.DataType := ftString;
    lParam.Value := RttiField.GetValue(Obj).AsString;
  end;

  //Ao modelar o banco definir o nome das FKs igual das referentes PKs para que possa atribuir valor na FK
  //durante a inserção de tabelas que possuem um ou mais relacionamentos
  if Assigned(ParamsRelationship) then
  begin
    if Assigned(ParamsRelationship.FindParam(lParam.Name)) and (lParam.DataType = ftInteger)then
    begin
      lParam.Value := ParamsRelationship.FindParam(lParam.Name).Value;
    end;
  end;
end;

class procedure TDAO.SetDadosInMessage(Obj: TObject; var Result: TMessageType; pChave: string = ''; aResourceName: String = ''; aJSONArray: TJSONArray = nil);
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  Dados: TJSONObject;
  DadosArray: TJSONObject;
begin
  Dados := TJSONObject.Create;
  RttiType := GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
      begin
        if RttiField.FieldType.TypeKind in [tkInteger] then
        begin
          if ((RttiAttribute as DBField).Constraints = PrimaryKey) and (pChave <> EmptyStr) then
            Dados.AddPair(RttiField.Name, TJSONNumber.Create(pChave.ToInteger))
          else
            Dados.AddPair(RttiField.Name, TJSONNumber.Create(RttiField.GetValue(Obj).AsInteger));
        end
        else if RttiField.FieldType.TypeKind in [tkInt64] then
        begin
          if ((RttiAttribute as DBField).Constraints = PrimaryKey) and (pChave <> EmptyStr) then
            Dados.AddPair(RttiField.Name, TJSONNumber.Create(pChave.ToInt64))
          else
            Dados.AddPair(RttiField.Name, TJSONNumber.Create(RttiField.GetValue(Obj).AsInt64))
        end
        else if RttiField.FieldType.TypeKind in [tkString, tkUString, tkUnicodeString, tkWString, tkWideChar, tkWideString, tkChar] then
          Dados.AddPair(RttiField.Name, RttiField.GetValue(Obj).AsString)
        else if RttiField.FieldType.TypeKind in [tkFloat] then
            Dados.AddPair(RttiField.Name, TJSONNumber.Create(TDateTime(RttiField.GetValue(Obj).AsExtended)))
        else if RttiField.FieldType.TypeKind in [tkEnumeration] then
          Dados.AddPair(RttiField.Name, TJSONBool.Create(RttiField.GetValue(Obj).AsBoolean))
        else if RttiField.FieldType.Name = 'TMacAddress' then
          Dados.AddPair(RttiField.Name, TMacAddress(RttiField.GetValue(Obj).AsObject).Value)
        else if RttiField.FieldType.Name = 'TBytea' then
          Dados.AddPair(RttiField.Name, TBytea(RttiField.GetValue(Obj).AsObject).Value.Text)
        else
          Dados.AddPair(RttiField.Name, RttiField.GetValue(Obj).AsString)
      end;

  if Assigned(aJSONArray) then
  begin
    DadosArray := TJSONObject.Create;
    aJSONArray.AddElement(Dados);
    DadosArray.AddPair(aResourceName, aJSONArray);
    Result.Content := DadosArray;
  end
  else
    Result.Content := Dados;
end;

class procedure TDAO.ExecQuery(var Result: TMessageType; lSQL: string; Params: TFDParams);
var
  Connection: TConnection;
begin
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(lSQL);
    Connection.Query.Params := Params;
    try
      Connection.Query.ExecSQL;
    except
      on E: Exception do
      begin
        Result := EDadosNaoExcluidos;
      end;
    end;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
end;

class function TDAO.OpenQuery(Response: TWebResponse; lSQL: string; Obj: TObject): TJSONArray;
var
  lItem: TJSONObject;
  lItemRelacionado: TJSONArray;
  lItemObjRelacionado: TJSONObject;
  Field: TField;
  Connection: TConnection;
  ListRelationship: TObjectList<TObject>;
  LNameRelationship: String;
  RttiAttribute: TCustomAttribute;
  RttiType: TRttiType;
  InstanceObj: TObject;
  RttiField: TRttiField;
begin
  Result := TJSONArray.Create;
  Connection := TConnection.Create;
  try
    Connection.Query.SQL.Add(lSQL);
    try
      Connection.Query.Open;
      Connection.Query.First;
      while not(Connection.Query.Eof) do
      begin
        lItem := TJSONObject.Create;
        Result.AddElement(lItem);
        for Field in Connection.Query.Fields do
          if Field.DataType = ftInteger then
            lItem.AddPair(LowerCase(Field.FieldName), TJSONNumber.Create(Field.AsInteger))
          else if Field.DataType = ftBoolean then
            lItem.AddPair(LowerCase(Field.FieldName), TJSONBool.Create(Field.Value))
          else if Field.DataType in [ftDate] then
            lItem.AddPair(LowerCase(Field.FieldName), Copy(DateToISO8601(Field.Value), 1, 10))
          else
            lItem.AddPair(LowerCase(Field.FieldName), Field.AsString);

        //Insere array de objetos se existir relacionamento entre tabelas
//        ListRelationship := GetRelationship(Obj, LNameRelationship);
//        RttiType := GetRttiType(Obj);
//        for RttiField in RttiType.GetFields do
//        begin
//          for RttiAttribute in RttiField.GetAttributes do
//            if (RttiAttribute is DBRelationship) then
//            begin
//              (RttiAttribute as DBRelationship).NameRelationship := LNameRelationship;
//              if Assigned((RttiAttribute as DBRelationship).ListRelationship) then
//                DBRelationship(RttiAttribute).ListRelationship.Add(InstanceObj);
//            end;
//        end;
//        ListRelationship := nil;
//        ListRelationship := GetRelationship(Obj, LNameRelationship);
//        if Assigned(ListRelationship) and (ListRelationship.Count > 0) then
//        begin
//          lItemRelacionado := TJSONArray.Create;
//          lItemObjRelacionado := TJSONObject.Create;
//          lItemRelacionado.AddElement(lItemObjRelacionado);
//          lItem.AddPair(LowerCase(LNameRelationship), lItemRelacionado);
//        end;
        Connection.Query.Next;
      end;
    except
      on E: Exception do
        TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Response);
    end;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
end;

class procedure TDAO.Update(Response: TWebResponse; ListObj: TObjectList<TObject>;
Dados: TJSONObject; aResourceName: String = '');
const
  SQL = 'UPDATE %s SET %s WHERE %s';
var
  Connection: TConnection;
  TableName: String;
  FieldsName: String;
  WhereCondition: String;
  Params: TFDParams;
  Mensagem: TMessageType;
  Obj: TObject;
  RttiType: TRttiType;
  LJSONArray: TJSONArray;
  ListRelationship: TObjectList<TObject>;
  LNameRelationship: String;
begin
  Response.ContentType  := 'application/json;charset=UTF-8';
  Mensagem := IRegistroAlterado;
  Connection := TConnection.Create;
  if ListObj.Count > 1 then
    LJSONArray := TJSONArray.Create;
  try
    try
      //Connection.DB.StartTransaction;
      for Obj in ListObj do
      begin
        Params := TFDParams.Create;
        TableName := GetTableName(Obj);
        SetFieldsAndParams(teUpdate, Obj, FieldsName, WhereCondition, Params);
        Connection.Query.SQL.Clear;
        Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName, WhereCondition]));
        Connection.Query.Params := Params;
        Connection.Query.ExecSQL;
        RttiType := GetRttiType(Obj);
        if RttiType.ToString = 'TAplicativos' then
          InsertAplicativosLojas(GetID(Obj), Dados, Connection);

        ListRelationship := nil;
        ListRelationship := GetRelationship(Obj, LNameRelationship);
        if Assigned(ListRelationship) and (ListRelationship.Count > 0) then
        begin
          Params.Clear;
          TableName := GetTableName(ListRelationship.Items[0]);
          SetFieldsAndParams(teUpdate, ListRelationship.Items[0], FieldsName,
            WhereCondition, Params);
          Connection.Query.SQL.Clear;
          Connection.Query.SQL.Add(Format(SQL, [TableName, FieldsName, WhereCondition]));
          Connection.Query.Params := Params;
          Connection.Query.ExecSQL;
          ListRelationship.Delete(0);
        end;

        if ListObj.Count = 1 then
          SetDadosInMessage(Obj, Mensagem)
        else
          SetDadosInMessage(Obj, Mensagem, EmptyStr, aResourceName, LJSONArray);
      end;
      //Connection.DB.Commit;
    except
      on E: Exception do
      begin
        //Connection.DB.Rollback;
        TMessage.Create(EDadosNaoSalvos, E.Message).SendMessage(Response);
      end;
    end;
  finally
//    Connection.DB.Connected := False;
//    Connection.Free;
  end;
  TMessage.Create(Mensagem).SendMessage(Response);
end;

class function TDAO.GetRelationship(Obj: TObject; var NameRelationship: String): TObjectList<TObject>;
var
  RttiType: TRttiType;
  RttiAttribute: TCustomAttribute;
  RttiField: TRttiField;
begin
  Result := nil;
  RttiType := GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if (RttiAttribute is DBRelationship) then
      begin
        Result := (RttiAttribute as DBRelationship).ListRelationship;
        NameRelationship := (RttiAttribute as DBRelationship).NameRelationship;
      end;
end;

class function TDAO.GetRttiType(Obj: TObject): TRttiType;
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  Result := RttiContext.GetType(Obj.ClassInfo);
end;

class function TDAO.GetTableName(Obj: TObject): String;
var
  RttiType: TRttiType;
  RttiAttribute: TCustomAttribute;
begin
  Result := EmptyStr;
  RttiType := GetRttiType(Obj);
  for RttiAttribute in RttiType.GetAttributes do
    if RttiAttribute is Table then
      Result := (RttiAttribute as Table).TableName;
end;

class function TDAO.GetWhere(Obj: TObject; ID: String; Search: String;
WherePadrao: String; TipoPesquisa:TPesquisa): String;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
  ListWhere: TArray<String>;
  Item: String;
  TableName: String;
  FieldName: String;
  Filter: String;
  LFilter: String;
  LFieldConverter: String;
begin
  Result := EmptyStr;
  if ((ID <> EmptyStr) and (ID <> 'list-select')) then
  begin
    RttiType := GetRttiType(Obj);
    for RttiField in RttiType.GetFields do
      for RttiAttribute in RttiField.GetAttributes do
        if RttiAttribute is DBField then
          if (RttiAttribute as DBField).Constraints = PrimaryKey then
          begin
            Result := ' WHERE ' + (RttiAttribute as DBField).FieldName + ' = ' + ID;
          end;
  end
  else if Search <> EmptyStr then
  begin
    ListWhere := Search.Split(['@@@']);
    for Item in ListWhere do
    begin
      if (Length(Item.Split([':'])) = 2)
      or (Length(Item.Split([':'])) = 3)  then
      begin
        if Length(Item.Split([':'])) = 2 then
        begin
          FieldName := Item.Split([':'])[0];
          Filter := Item.Split([':'])[1];
        end;

        if Length(Item.Split([':'])) = 3 then
        begin
          TableName := Item.Split([':'])[0];
          FieldName := Item.Split([':'])[1];
          Filter := Item.Split([':'])[2];
        end;

        RttiType := GetRttiType(Obj);
        for RttiField in RttiType.GetFields do
          for RttiAttribute in RttiField.GetAttributes do
            if RttiAttribute is DBField then
              if LowerCase(RttiField.Name) = LowerCase(FieldName) then
                if ((RttiField.FieldType.ToString) = 'Integer') or (RttiField.FieldType.ToString = 'Boolean') then
                  begin
                    if Length(Item.Split([':'])) = 2 then
                      if Result = EmptyStr then
                        Result := ' WHERE (' + (RttiAttribute as DBField).FieldName + ') = ' + Filter
                      else
                        Result := Result + ' AND (' + (RttiAttribute as DBField).FieldName + ') = ' + Filter;
                    if Length(Item.Split([':'])) = 3 then
                      if Result = EmptyStr then
                        Result := ' WHERE ' + TableName + '.' + FieldName + ' = ' + Filter
                      else
                        Result := Result + ' AND ' + TableName + '.' + FieldName + ' = ' + Filter;
                  end
                  else
                  begin
                    LFieldConverter := EmptyStr;
                    if (Length(Filter) = 36)
                    and (IsValidGuid('{' + Filter + '}')) then
                      LFieldConverter := '::uuid';

                    if (TipoPesquisa = tpInicio) then
                      Filter := Filter+'%'
                    else if(TipoPesquisa = tpTodoCampo) then
                      Filter := '%' + Filter + '%'
                    else if (TipoPesquisa = tpFim) then
                      Filter := '%'+Filter;

                    if Length(Item.Split([':'])) = 2 then
                      if TipoPesquisa = tpSemIncidencia then
                      begin
                        if Result = EmptyStr then
                          Result := ' WHERE ' + (RttiAttribute as DBField).FieldName +
                                    ' = ' + QuotedStr(Filter) + LFieldConverter
                        else
                          Result := Result + ' AND ' + (RttiAttribute as DBField).FieldName +
                                   ' = ' + QuotedStr(Filter) + LFieldConverter;
                      end
                      else
                      if Result = EmptyStr then
                        Result := ' WHERE lower(' + (RttiAttribute as DBField).FieldName +
                                  ') LIKE lower(' + QuotedStr(Filter) + ')'
                      else
                        Result := Result + ' AND lower(' + (RttiAttribute as DBField).FieldName +
                                  ') LIKE lower(' + QuotedStr('%' + Filter + '%') + ')';

                    if Length(Item.Split([':'])) = 3 then
                      if TipoPesquisa = tpSemIncidencia then
                      begin
                        if Result = EmptyStr then
                          Result := ' WHERE ' + TableName + '.' + FieldName + ' = ' + QuotedStr(Filter)
                        else
                          Result := Result + ' AND ' + TableName + '.' + FieldName + ' = ' + QuotedStr(Filter);
                      end
                      else
                      if Result = EmptyStr then
                        Result := ' WHERE lower(' + TableName + '.' + FieldName + ') LIKE lower(' + QuotedStr(Filter) + ')'
                      else
                        Result := Result + ' AND lower(' + TableName + '.' + FieldName + ') LIKE lower(' + QuotedStr(Filter) + ')';
                  end;
      end;
    end;
  end;
  if WherePadrao <> EmptyStr then
  begin
    if Result = EmptyStr then
      Result := ' WHERE ' + WherePadrao
    else
      Result := Result + ' AND ' + WherePadrao;
  end;
end;

class procedure TDAO.InsertAplicativosLojas(ID: Integer; Dados: TJSONObject; Connection: TConnection);
var
  Item: TJSONArray;
  Elemento: TJSONValue;
begin
  Connection.Query.ExecSQL('DELETE FROM aplicativos_lojas WHERE id_aplicativos = :id', [ID], [ftInteger]);
  if Dados.TryGetValue('lojas', Item) then
    if Item.Count > 0 then
      for Elemento in Item do
        Connection.Query.ExecSQL('INSERT INTO aplicativos_lojas (id_aplicativos, id_lojas) VALUES(:id_aplicativos, :id_lojas)', [ID, Elemento.Value.ToInteger], [ftInteger, ftInteger]);
end;

class function TDAO.IsValidGuid(GUID: String): Boolean;
begin
  try
    StringToGUID(GUID);
    Result := True;
  except
    Result := False;
  end;
end;

class function TDAO.OpenQuery(Response: TWebResponse; lSQL: string;
Connection: TConnection): TConnection;
begin
  Result := Connection;
  Connection.Query.SQL.Clear;
  Connection.Query.SQL.Add(lSQL);
  try
    Connection.Query.Open;
  except
    on E: Exception do
      TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Response);
  end;
end;

class function TDAO.OpenQueryToJSON(const SQL, Where, Servico: String; const Params: array of TValue): TJSONObject;
var
  Connection: TConnection;
  lJsonString: String;
  lJsonArray: TJSONArray;
  lJsonPair: TJSONPair;
begin
  Result := TJSONObject.Create;
  lJsonArray := TJSONArray.Create;
  lJsonPair := TJSONPair.Create(Servico, lJsonArray);

  Connection := TConnection.Create;
  Connection.Query.SQL.Add(Format(SQL, [Where]));
  try
    Connection.Query.Open;
    Connection.Query.First;
    while not Connection.Query.Eof do
    begin
      lJsonString := Connection.Query.FieldByName('to_json').Value;
      lJsonArray.AddElement(TJSONValue.ParseJSONValue(TEncoding.UTF8.GetBytes(LJSONString), 0) as TJSONValue);
      Connection.Query.Next;
    end;
    Result := Result.AddPair(lJsonPair);
  except
    on E: Exception do
      TMessage.Create(EErroGeral, 'Erro ao executar a consulta (' + E.Message + ')').SendMessage(Params[0].AsType<TWebResponse>);
  end;
end;

class function TDAO.GetID(Obj: TObject): Integer;
var
  RttiType: TRttiType;
  RttiField: TRttiField;
  RttiAttribute: TCustomAttribute;
begin
  Result := 0;
  RttiType := GetRttiType(Obj);
  for RttiField in RttiType.GetFields do
    for RttiAttribute in RttiField.GetAttributes do
      if RttiAttribute is DBField then
        if (RttiAttribute as DBField).Constraints = PrimaryKey then
          Result := RttiField.GetValue(Obj).AsInteger;
end;
class function TDAO.GetJoin(AJoin:string): string;
begin
  Result := EmptyStr;
  if AJoin.IsEmpty then Exit;
  Result := AJoin.Replace('!@!','%',[rfReplaceAll]);
end;
end.
