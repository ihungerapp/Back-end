  {_____________________________________________________________________________

  █░█░█ █ █░░ █▀ █▀█ █▄░█   █░░ █░█ ▀█
  ▀▄▀▄▀ █ █▄▄ ▄█ █▄█ █░▀█   █▄▄ █▄█ █▄ ©  2023

  Generate model interface to angular Type Script
  ______________________________________________________________________________
}
unit Server.AngularModel;

interface

uses
  sysutils,
  JSON,
  strutils,
  Utils.Strings,
  classes;

type
  TAngularModel = class
  private
    FSchema: TstringList;
    FClassName: string;
    FFieldsList: TstringList;
    function GetAliasName(value:string):string;

  published
    property ClassName: string read FClassName write FClassName;
    property FieldsList: TstringList read FFieldsList write FFieldsList;

  public
    procedure saveModel;
    constructor create;
    destructor destroy;
  end;

implementation

{ TAngularModel }

constructor TAngularModel.create;
begin
  FFieldsList := TstringList.create;
  FSchema := TstringList.create;
end;
destructor TAngularModel.destroy;
begin
  FreeAndNil(FFieldsList);
  FreeAndNil(FSchema);
end;

function TAngularModel.GetAliasName(value:string): string;
var
  FileMaper:string;
  ListAlias:TStringList;
  MapLine:string;

  function getLineAlias(value:string):string;
  var
    Index:Integer;
  begin
    for Index := 0 to ListAlias.Count -1 do
    begin
      if StartsStr (LowerCase( value),LowerCase( ListAlias[index])) then
      begin
        result:= ListAlias[index];
        break;
      end;
    end;
  end;
begin
 result:=value;
 FileMaper:=   ExtractFilePath(GetModuleName(HInstance))+'ResourcesNamesMapper.txt';
 if FileExists(fileMaper) then
 begin
  try
    ListAlias:=TStringList.Create;
    ListAlias.LoadFromFile(FileMaper);
    MapLine:=  getLineAlias(value);
    if (MapLine <>'') and ( pos('=',MapLine) > 0) then
    begin
      result:=SplitString(MapLine,'=')[1];
    end;
  finally
    FreeAndNil(ListAlias);
  end;
 end;
end;

procedure TAngularModel.saveModel;
var
  Index: Integer;
  SingularName: string;
  PluralName: string;
  Outfile: string;

begin
  if ClassName = '' then
    raise Exception.create('Nome da classe deve ser informada');
  try

    ClassName:= GetAliasName(ClassName ) ;
    SingularName := TUtilString.SingularMode(TUtilString.Captalize(ClassName));
    PluralName := TUtilString.PluralMode(TUtilString.Captalize(ClassName));

    FSchema.add('  export interface ' + SingularName + 'Req {');
    for Index := 0 to FFieldsList.Count - 1 do
    begin
      if index < FFieldsList.Count - 1 then
        FSchema.add('    ' + FFieldsList[Index] + ',')
      else
        FSchema.add('    ' + FFieldsList[Index]);
    end;
    FSchema.add('  }');
    FSchema.add('  export interface ' + SingularName + ' {');
    for Index := 0 to FFieldsList.Count - 1 do
    begin
      if index < FFieldsList.Count - 1 then
        FSchema.add('    ' + FFieldsList[Index] + ',')
      else
        FSchema.add('    ' + FFieldsList[Index]);
    end;
    FSchema.add('  }');

    FSchema.add('  export interface ' + PluralName + ' {  ');
    FSchema.add('    content: ' + SingularName + '[],     ');
    FSchema.add('    totalElements: number,   ');
    FSchema.add('    totalPages: number,      ');
    FSchema.add('    pageSize: number,        ');
    FSchema.add('    pageNumber: number       ');
    FSchema.add(' }                           ');

    FSchema.add('  export interface ' + SingularName + 'Res {');

    FSchema.add('    content: {       ');
    for Index := 0 to FFieldsList.Count - 1 do
    begin
      if index < FFieldsList.Count - 1 then
        FSchema.add('      ' + FFieldsList[Index] + ',')
      else
        FSchema.add('      ' + FFieldsList[Index])
    end;
    FSchema.add('    },');
    FSchema.add('    mensagem: string,');
    FSchema.add('    sucesso: boolean ');

    FSchema.add('  }');

    Outfile := ExtractFilePath(GetModuleName(HInstance)) + 'www' + PathDelim +
      'clientes' + PathDelim + 'Angular' + PathDelim + 'Models';
    ForceDirectories(Outfile);

    Outfile := Outfile + PathDelim + LowerCase(ClassName) +'.ts';
    FSchema.SaveToFile(Outfile);
  except
    on e: Exception do
    begin
      raise Exception.create('[Angular Cliente ] Erro ao exportar ' +
        e.Message);
    end;

  end;
end;

end.
