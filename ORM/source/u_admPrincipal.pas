unit u_admPrincipal;

interface

uses
  Data.DB,
  Winapi.Windows, Winapi.Messages,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  System.Math, System.IniFiles, System.Variants, System.SysUtils,
  System.UiTypes, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.IBDef, FireDAC.Phys.IB, FireDAC.Phys.IBBase,
  FireDAC.Phys.FBDef, FireDAC.Phys.FB, FireDAC.Phys.PGDef, FireDAC.Phys.PG, uPostmanJson;

type
  ActionINI = (iniRead, iniWrite);
  TadmPrincipal = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    btn_gerar: TButton;
    edt_caminho: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    Button2: TButton;
    rg_01: TRadioButton;
    rg_02: TRadioButton;
    edt_banco: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edt_host: TEdit;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    edt_porta: TEdit;
    Label5: TLabel;
    edt_usuario: TEdit;
    Label6: TLabel;
    edt_senha: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    mm_modelo: TMemo;
    Label9: TLabel;
    tabelas: TFDQuery;
    ds_tabelas_edicao: TDataSource;
    FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Open: TOpenDialog;
    mm_modelo_save: TMemo;
    campos: TFDQuery;
    PrimaryKey: TFDQuery;
    PG: TProgressBar;
    lbl_informa: TLabel;
    GroupBox3: TGroupBox;
    edt_localiza: TEdit;
    SpeedButton3: TSpeedButton;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    mm_Controllers: TMemo;
    tabelas_edicao: TFDMemTable;
    tabelas_edicaonome_tabela: TStringField;
    tabelas_edicaochecked: TBooleanField;
    tabelas_edicaonome_classe: TStringField;
    tabelas_edicaonot_null: TIntegerField;
    tabelas_edicaoschema: TStringField;
    mm_dao: TMemo;
    tabelas_edicaolsequence: TStringField;
    cbResources: TCheckBox;
    cbControllers: TCheckBox;
    cbDAOs: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btn_gerarClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    iniFile: TIniFile;
    function MontaDBField: String;
    procedure ConfigINI(enuAction: ActionINI);
  public
    { Public declarations }
  end;

var
  admPrincipal: TadmPrincipal;

implementation

{$R *.dfm}

function PrimeiraLetraMaiscula(Str: string): string;
var
  i: integer;
  esp: boolean;
begin
  str := LowerCase(Trim(str));
  for i := 1 to Length(str) do
  begin
    if i = 1 then
      str[i] := UpCase(str[i])
    else
      begin
        if i <> Length(str) then
        begin
          esp := (str[i] = ' ');
          if esp then
            str[i+1] := UpCase(str[i+1]);
        end;
      end;
  end;
  Result := Str;
end;

Procedure FindReplace(const Enc, subs: String; Var Texto: TMemo);
Var
  i, Posicao: Integer;
  Linha: string;
Begin
  For i:= 0 to Texto.Lines.count - 1 do
  begin
    Linha := Texto. Lines[i];
    Repeat
      Posicao := Pos(Enc,Linha);
      If Posicao > 0 then
      Begin
        Delete(Linha,Posicao,Length(Enc));
        Insert(Subs,Linha,Posicao);
        Texto.Lines[i]:=Linha;
      end;
    until Posicao = 0;
  end;
end;

procedure TadmPrincipal.FormCreate(Sender: TObject);
begin
  iniFile := TIniFile.Create(Application.GetNamePath + Application.ExeName + '.ini');
  ConfigINI(iniRead);
end;

procedure TadmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(iniFile);
end;

procedure TadmPrincipal.btn_gerarClick(Sender: TObject);
var
  i: Integer;
  pJson, pJsonResources, pSaveArquivo: TStringList;
  schema, tabela: String;
begin
  ConfigINI(iniWrite);
  pSaveArquivo := TStringList.Create;
  pJson := TStringList.Create;
  pJsonResources := TStringList.Create;
  try
    if not DirectoryExists(Trim(edt_caminho.Text)) then
    begin
      if MessageDlg('O diretório "' + Trim(edt_caminho.Text) + '" não existe. ' + #13#10 +
                    'Deseja cria-lo?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
        Exit;
      CreateDir(Trim(edt_caminho.Text));
    end;
    i:= 0;
    tabelas_edicao.First;
    while not tabelas_edicao.Eof do
    begin
      inc(i);
      PG.Position:= i;
      schema := tabelas_edicaoschema.AsString;
      if tabelas_edicaochecked.AsBoolean then
      begin
        //RESOURCE
        if cbResources.Checked then
        begin
          if not DirectoryExists(edt_caminho.text  + '\Resources\') then
            ForceDirectories(edt_caminho.text  + '\Resources\');

          mm_modelo_save.Lines.Clear;
          mm_modelo_save.Lines.Add(mm_modelo.Text);
          FindReplace('@tabela', QuotedStr('"' + tabelas_edicaoschema.AsString + '".' + tabelas_edicaonome_tabela.AsString), mm_modelo_save);
          FindReplace('@sequence', QuotedStr(tabelas_edicaolsequence.AsString), mm_modelo_save);
          FindReplace('@classe_resource', QuotedStr(LowerCase(tabelas_edicaonome_tabela.AsString)), mm_modelo_save);
          FindReplace('@classe', tabelas_edicaonome_classe.AsString, mm_modelo_save);
          FindReplace('@DBField', MontaDBField, mm_modelo_save);
          mm_modelo_save.Lines.SaveToFile(trim(edt_caminho.text + '\Resources\')+ 'Resources.'+tabelas_edicaonome_classe.AsString+'.pas');
        end;

        //CONTROLLER
        if cbControllers.Checked then
        begin
          if not DirectoryExists(edt_caminho.text  + '\Controllers\') then
            ForceDirectories(edt_caminho.text  + '\Controllers\');

          mm_modelo_save.Lines.Clear;
          mm_modelo_save.Lines.Add(mm_Controllers.Text);
          FindReplace('@nomeController', PrimeiraLetraMaiscula(tabelas_edicaonome_tabela.AsString), mm_modelo_save);
          FindReplace('@Resources', 'Resources.'+tabelas_edicaonome_classe.AsString, mm_modelo_save);
          FindReplace('@classe', PrimeiraLetraMaiscula(tabelas_edicaonome_classe.AsString), mm_modelo_save);
          mm_modelo_save.Lines.SaveToFile(trim(edt_caminho.text + '\Controllers\')+ 'Controller.'+PrimeiraLetraMaiscula(tabelas_edicaonome_classe.AsString)+'.pas');
        end;

        //DAO
        if cbDAOs.Checked then
        begin
          if not DirectoryExists(edt_caminho.text  + '\DAO\') then
            ForceDirectories(edt_caminho.text  + '\DAO\');

          mm_modelo_save.Lines.Clear;
          mm_modelo_save.Lines.Add(mm_dao.Text);
          FindReplace('@classe', PrimeiraLetraMaiscula(tabelas_edicaonome_classe.AsString), mm_modelo_save);
          mm_modelo_save.Lines.SaveToFile(trim(edt_caminho.text + '\DAO\')+ 'DAO.'+PrimeiraLetraMaiscula(tabelas_edicaonome_classe.AsString)+'.pas');
        end;

        //POSTMAN
        tabela := tabelas_edicaonome_tabela.AsString;
      end;
      APPLICATION.PROCESSMESSAGES;
      lbl_informa.Caption:= FormatFloat('000', i) + ' de '+ FormatFloat('000', tabelas_edicao.RecordCount);
      tabelas_edicao.Next;

      if schema <> tabelas_edicaoschema.AsString then
      begin
        pJsonResources.Add(StringReplace(TPostman.PostmanResources(EmptyStr).Text, '@tabela', (tabela), [rfReplaceAll]));
        pJson.Add(StringReplace(TPostman.PostmanSchemas(schema).Text, '@texto', pJsonResources.Text, [rfReplaceAll]));
        pJsonResources.Clear;
      end
      else
      if (schema = tabelas_edicaoschema.AsString) and (tabelas_edicao.Eof) then
      begin
        pJsonResources.Add(StringReplace(TPostman.PostmanResources(EmptyStr).Text, '@tabela', (tabela), [rfReplaceAll]));
        pJson.Add(StringReplace(TPostman.PostmanSchemas(schema).Text, '@texto', pJsonResources.Text, [rfReplaceAll]))
      end
      else
      if schema = tabelas_edicaoschema.AsString then
        pJsonResources.Add(StringReplace(TPostman.PostmanResources(',').Text, '@tabela', (tabela), [rfReplaceAll]))
    end;
    pSaveArquivo.Add(StringReplace(TPostman.PostmanJson.Text, '@texto', pJson.Text, [rfReplaceAll]));
    pSaveArquivo.SaveToFile(trim(edt_caminho.text) + PathDelim + 'Resources.json');
  finally
    pJson.Free;
    pJsonResources.Free;
    pSaveArquivo.Free;
  end;

end;

procedure TadmPrincipal.Button2Click(Sender: TObject);
var
  vsqlTabela: string;
begin
  ConfigINI(iniWrite);
  FDConnection.Params.Clear;
  FDConnection.LoginPrompt := False;
  if rg_01.checked then
  begin
    FDConnection.DriverName  := 'FB';
    FDConnection.Params.Add('Database='+edt_banco.Text);
    FDConnection.Params.Add('DriverID=FB');
    FDConnection.Params.Add('hostname='+edt_host.Text);
    FDConnection.Params.Add('user_name='+edt_usuario.Text);
    FDConnection.Params.Add('password='+edt_senha.Text);
    FDConnection.Params.Add('port='+'3050');
    FDConnection.Params.Add('blobsize=-1');
    vsqlTabela := 'SELECT RDB$RELATION_NAME AS NOME_TABELA ' +
                  '  FROM RDB$RELATIONS ' +
                  ' WHERE RDB$VIEW_BLR IS NULL ' +
                  ' ORDER BY RDB$RELATION_NAME DESC';
  end
  else
  begin
    FDConnection.DriverName  := 'PG';
    FDConnection.Params.Add('Database='+edt_banco.Text);
    FDConnection.Params.Add('DriverID=PG');
    FDConnection.Params.Add('Server='+edt_host.Text);
    FDConnection.Params.Add('user_name='+edt_usuario.Text);
    FDConnection.Params.Add('password='+edt_senha.Text);
    FDConnection.Params.Add('port='+edt_porta.Text);

    vsqlTabela := '  SELECT distinct  '+
                  '  	tab.table_name AS NOME_TABELA    '+
                  '     , tab.table_schema   '+
                  ' 	, inf.column_default '+
                  ' 	, SUBSTRING(inf.column_default FROM (STRPOS(inf.column_default, ''.'') + 1) FOR ((STRPOS(inf.column_default, '':'') - 1) - (STRPOS(inf.column_default, ''.'') + 1))) LSEQUENCE '+
                  '  FROM INFORMATION_SCHEMA.tables tab   '+
                  '  left join information_schema.columns inf on inf.table_name = tab.table_name   '+
                  '  where inf.is_nullable = ''NO''  '+
                  '   	and inf.udt_name = ''int4''  '+
                  '  	and inf.table_schema <> ''pg_catalog''  '+
                  ' 	and inf.table_name = tab.table_name  '+
                  ' 	and inf.column_default is not null '+
                  ' 	and substring(inf.column_default FROM 1 FOR 1) LIKE ''n'' '+
                  '   ORDER BY tab.table_schema, tab.table_name ';
  end;
  FDConnection.Open;
  tabelas.SQL.Text := vsqlTabela;
  tabelas.Open;
  tabelas_edicao.Open;
  tabelas_edicao.EmptyDataSet;
  tabelas.First;
  if not tabelas.IsEmpty then
  begin
    while not tabelas.Eof do
    begin
      if (rg_01.checked) and (pos('$',tabelas.FieldByName('NOME_TABELA').AsString) > 0) then
      begin
        tabelas.Next;
        continue;
      end;
      tabelas_edicao.Insert;
      tabelas_edicaochecked.AsBoolean   := false;
      tabelas_edicaonome_tabela.AsString:= tabelas.Fields[0].AsString;
      tabelas_edicaoschema.AsString:= tabelas.Fields[1].AsString;
      tabelas_edicaolsequence.AsString:= tabelas.Fields[3].AsString;
      tabelas_edicao.Post;
      tabelas.Next;
    end;
    tabelas_edicao.First;
  end;
  PG.Max:= tabelas_edicao.RecordCount;
  lbl_informa.Caption:= '0 de '+ FormatFloat('000', tabelas_edicao.RecordCount);
end;

procedure TadmPrincipal.ConfigINI(enuAction: ActionINI);
begin
  case enuAction of
  iniRead :
    Begin
      edt_banco.Text := iniFile.ReadString('Data_Base', 'pathDB', '');
      edt_host.Text := iniFile.ReadString('Data_Base', 'host', '');
      edt_porta.Text := iniFile.ReadString('Data_Base', 'port', '');
      edt_usuario.Text := iniFile.ReadString('Data_Base', 'user', '');
      edt_senha.Text := iniFile.ReadString('Data_Base', 'password', '');
      edt_caminho.Text := iniFile.ReadString('Units', 'path', '');
    End;
  iniWrite :
    Begin
      iniFile.WriteString('Data_Base', 'pathDB', edt_banco.Text);
      iniFile.WriteString('Data_Base', 'host', edt_host.Text);
      iniFile.WriteString('Data_Base', 'port', edt_porta.Text);
      iniFile.WriteString('Data_Base', 'user', edt_usuario.Text);
      iniFile.WriteString('Data_Base', 'password', edt_senha.Text);
      iniFile.WriteString('Units', 'path', edt_caminho.Text);
    End;
  end;
end;

procedure TadmPrincipal.DBGrid1DblClick(Sender: TObject);
begin
 if ((Sender as TDBGrid).DataSource.Dataset.IsEmpty) then
    Exit;
  (Sender as TDBGrid).DataSource.Dataset.Edit;
  (Sender as TDBGrid).DataSource.Dataset.FieldByName('checked').AsBoolean := not
    (Sender as TDBGrid).DataSource.Dataset.FieldByName('checked').AsBoolean;
  if (Sender as TDBGrid).DataSource.Dataset.FieldByName('checked').AsBoolean then
    (Sender as TDBGrid).DataSource.Dataset.FieldByName('nome_classe').AsString := LowerCase((Sender as TDBGrid).DataSource.Dataset.FieldByName('nome_tabela').AsString)
  else
    (Sender as TDBGrid).DataSource.Dataset.FieldByName('nome_classe').Clear;
  (Sender as TDBGrid).DataSource.Dataset.Post;
end;

procedure TadmPrincipal.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check: Integer;
  R: TRect;
begin
  inherited;
  if ((Sender as TDBGrid).DataSource.Dataset.IsEmpty) then
    Exit;
  // Desenha um checkbox no dbgrid
  if Column.FieldName = 'checked' then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    if ((Sender as TDBGrid).DataSource.Dataset.FieldByName('checked').AsBoolean = True) then
      Check := DFCS_CHECKED
    else
      Check := 0;
    R := Rect;
    InflateRect(R, -2, -2); { Diminue o tamanho do CheckBox }
    DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON,
      DFCS_BUTTONCHECK or Check);
  end;
end;

function TadmPrincipal.MontaDBField: String;
var
  vsqlpk,
  vsqlcampos: string;
  vPrimary : String;
  vType    : String;
  vTamanho : String;
  vNot_Null: String;
  vResult  : String;
begin
  // Verifica os campos da tabela
  campos.Close;
  if rg_01.checked then
  begin
    vsqlcampos := 'SELECT r.RDB$FIELD_NAME AS nome ' +
                  '     , r.RDB$DESCRIPTION AS descricao ' +
                  '     , f.RDB$FIELD_LENGTH AS tamanho ' +
                  '     , r.RDB$NULL_FLAG as Not_null ' +
                  '     , CASE f.RDB$FIELD_TYPE ' +
                  '         WHEN 261 THEN ''BLOB'' ' +
                  '         WHEN 14 THEN ''CHAR'' ' +
                  '         WHEN 40 THEN ''CSTRING'' ' +
                  '         WHEN 11 THEN ''D_FLOAT'' ' +
                  '         WHEN 27 THEN ''DOUBLE'' ' +
                  '         WHEN 10 THEN ''FLOAT'' ' +
                  '         WHEN 16 THEN ''INT64'' ' +
                  '         WHEN 8 THEN ''INTEGER'' ' +
                  '         WHEN 9 THEN ''QUAD'' ' +
                  '         WHEN 7 THEN ''SMALLINT'' ' +
                  '         WHEN 12 THEN ''DATE'' ' +
                  '         WHEN 13 THEN ''TIME'' ' +
                  '         WHEN 35 THEN ''TIMESTAMP'' ' +
                  '         WHEN 37 THEN ''VARCHAR'' ' +
                  '         ELSE ''UNKNOWN'' ' +
                  '       END AS tipo ' +
                  '  FROM RDB$RELATION_FIELDS r ' +
                  '  LEFT JOIN RDB$FIELDS f ON r.RDB$FIELD_SOURCE = f.RDB$FIELD_NAME ' +
                  ' WHERE r.RDB$RELATION_NAME = :NAME ' +
                  ' ORDER BY r.RDB$FIELD_POSITION; ';
    vsqlpk := 'SELECT RDB$FIELD_NAME AS NOME ' +
              '  FROM RDB$RELATION_CONSTRAINTS C ' +
              '  LEFT JOIN RDB$INDEX_SEGMENTS S ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME ' +
              ' WHERE C.RDB$RELATION_NAME = :NAME ' +
              '   AND C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
              ' ORDER BY RDB$FIELD_POSITION; ';
  end
  else
  begin
    vsqlcampos := ' SELECT column_name as nome  ' +
                  '      , column_name as descricao  ' +
                  '      , character_maximum_length as tamanho  ' +
                  '      , is_nullable as not_null0  ' +
                  '      , case is_nullable  ' +
                  '          when ''NO'' then ''1''  ' +
                  '          else ''0''  ' +
                  '        end as not_null  ' +
                  '      , udt_name as tipo  ' +
                  ' 	 , table_schema  ' +
                  '   FROM INFORMATION_SCHEMA.columns ' +
                  '  where ' +
                  '    table_name = :NAME  '+
                  '  ORDER BY ordinal_position  ';

    vsqlpk := ' select kcu.column_name as nome ' +
              '    from information_schema.key_column_usage kcu ' +
              '    left join information_schema.table_constraints tc on kcu.constraint_catalog = tc.constraint_catalog ' +
              '                                                     and kcu.constraint_schema = tc.constraint_schema ' +
              '                                                     and kcu.constraint_name = tc.constraint_name ' +
//              '   where kcu.table_schema = ''public'' ' +
              '   where kcu.table_name = :NAME ' +
              '     and tc.constraint_type = ''PRIMARY KEY'' ' +
              '   order by kcu.ordinal_position; ';
  end;
  campos.SQL.Text := vsqlcampos;
  campos.ParamByName('NAME').AsString:= tabelas_edicaonome_tabela.AsString;
  campos.Open;
  // Verifica a primaryKey
  PrimaryKey.Close;
  PrimaryKey.SQL.Text := vsqlpk;
  PrimaryKey.ParamByName('NAME').AsString:= tabelas_edicaonome_tabela.AsString;
  PrimaryKey.Open;
  vPrimary:= PrimaryKey.FieldByName('NOME').AsString;
  campos.First;
  while not campos.Eof do
  begin
    vTamanho:= '';
    vType   := '';
    if campos.FieldByName('TAMANHO').AsString <> '' then
      vTamanho:= ','+campos.FieldByName('TAMANHO').AsString;
    if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'VARCHAR|CHAR|TEXT|PEDIDO_STATUS|PEDIDO_ITEM_STATUS') > 0 then
      vType:= 'String'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'INT4|INT8|INT64|SMALLINT|INTEGER') > 0 then
      vType:= 'Integer'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'DATETIME|TIMESTAMPTZ|TIMESTAMP') > 0 then
      vType:= 'TDateTime'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'DATE') > 0 then
      vType:= 'TDate'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'FLOAT|FLOAT8|CURRENCY|NUMERIC|DOUBLE') > 0 then
      vType:= 'Currency'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'TIME') > 0 then
      vType:= 'TTime'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'TIME') > 0 then
      vType:= 'TTime'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'BYTEA') > 0 then
      vType:= 'TBytea'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'UUID') > 0 then
      vType:= 'String'
    else if Pos(UpperCase(campos.FieldByName('TIPO').AsString), 'BOOL') > 0 then
      vType:= 'Boolean';

//    else if Pos(campos.FieldByName('TIPO').AsString, 'BLOB') > 0 then
//      vType:= 'TBlob';

    if vType <> '' then
      if vPrimary = campos.FieldByName('NOME').AsString then
      begin
        if vResult <> '' then
          vResult := vResult+'    ';
  //      vResult:= vResult + '[DBField('+QuotedStr(UpperCase(campos.FieldByName('NOME').AsString))+', True, True, False, False, PrimaryKey'+ vTamanho +')]'+ #13#10 +
        vResult := vResult + '[DBField('+QuotedStr(UpperCase(campos.FieldByName('NOME').AsString))+', True, True, False, PrimaryKey)]'+ #13#10 +
                  '    '+campos.FieldByName('NOME').AsString+': '+ vType +';'+ #13#10 + #13#10  ;
      end
      else
      begin
        if vResult <> '' then
          vResult:= vResult+'    ';
        vNot_Null:= 'Null';
        if campos.FieldByName('NOT_NULL').AsInteger = 1 then
          vNot_Null:= 'NotNull';
  //      vResult:= vResult +'[DBField('+QuotedStr(UpperCase(campos.FieldByName('NOME').AsString))+', True, True, False, False,'+ vNot_Null + vTamanho +')]'+ #13#10 +
        vResult:= vResult +'[DBField('+QuotedStr(UpperCase(campos.FieldByName('NOME').AsString))+', True, True, False, '+ vNot_Null + ')]'+ #13#10 +
                  '    '+campos.FieldByName('NOME').AsString+': '+ vType +';'+ #13#10 + #13#10 ;
      end;
    Campos.next;
  end;
  Result:= vResult;
end;

procedure TadmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  tabelas_edicao.First;
  tabelas_edicao.DisableControls;
  while not tabelas_edicao.Eof do
  begin
//    if (tabelas_edicao.IsEmpty) then
//      Exit;

    tabelas_edicao.Edit;
    tabelas_edicao.FieldByName('checked').AsBoolean := not tabelas_edicao.FieldByName('checked').AsBoolean;

    if tabelas_edicao.FieldByName('checked').AsBoolean then
      tabelas_edicao.FieldByName('nome_classe').AsString := LowerCase(tabelas_edicao.FieldByName('nome_tabela').AsString)
    else
      tabelas_edicao.FieldByName('nome_classe').Clear;

    tabelas_edicao.Post;
    tabelas_edicao.Next;
  end;
  tabelas_edicao.EnableControls;
  tabelas_edicao.First;
end;

procedure TadmPrincipal.SpeedButton3Click(Sender: TObject);
begin
  tabelas_edicao.Filtered:= false;
  tabelas_edicao.Filter  := ' nome_tabela like '+ QuotedStr('%'+ edt_localiza.Text + '%');
  tabelas_edicao.Filtered:= true;
end;
end.
