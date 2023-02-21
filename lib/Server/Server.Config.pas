unit Server.Config;

interface

uses
  System.IniFiles, System.SysUtils, FireDAC.Comp.Client, System.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Phys.PGDef, FireDAC.Phys.IBBase, FireDAC.Phys.PG, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.DataSet, System.Classes, System.IOUtils,
  Server.Connection, Utils.Criptografia;

type
  TServerConfig = class
  private
    FDManager: TFDManager;
    procedure ConfigDB;
    class var
      FInstance: TServerConfig;
  public
    class function GetInstance: TServerConfig;
  end;

implementation

{ TServer }

class function TServerConfig.GetInstance: TServerConfig;
begin
  if FInstance = nil then
  begin
    FInstance := TServerConfig.Create;
    FInstance.ConfigDB;
  end;
  Result := FInstance;
end;

procedure TServerConfig.ConfigDB;
var
  IniFile: TMemIniFile;
  Database: string;
  Server: string;
  UserName: string;
  Password: string;
  Params: TStrings;
  Port: Integer;
  LPath: string;
begin
  IniFile := TMemIniFile.Create('/root/deploy/ConfigServer.ini');
  //TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) + 'ConfigServer.Ini');//TIniFile.Create(TPath.Combine(GetCurrentDir, 'ConfigServer.Ini'));
  try
//    {$IFDEF MSWINDOWS}
      Database := IniFile.ReadString('Config', 'Database', '');
      Server := IniFile.ReadString('Config', 'Server', '');
      UserName := IniFile.ReadString('Config', 'UserName', '');
      Password := 'rm045369';//TCriptografia.Descriptografar(IniFile.ReadString('Config', 'Password', ''));
      Port := StrToInt(IniFile.ReadString('Config', 'Port', '5432'));
//    {$ENDIF}
//    {$IFDEF LINUX}
//      Database := 'HungerApp';
//      Server := 'localhost';
//      UserName := 'postgres';
//      Password := 'rm045369';
//      Port := 5432;
//    {$ENDIF}
    Params := TStringList.Create;
    Params.AddPair('DriverID', 'PG');
    Params.AddPair('Server', Server);
    Params.AddPair('Database', Database);
    Params.AddPair('User_Name', UserName);
    Params.AddPair('Password', Password);
    Params.AddPair('Port', Port.ToString);
    Params.AddPair('Pooled', 'True');

    FInstance.FDManager := TFDManager.Create(nil);
    FInstance.FDManager.AddConnectionDef('WKServer', 'PG', Params);
    FInstance.FDManager.Active := True;
    Writeln('Conectando com o servidor ->> ' + Server);

    Writeln(Database + #13,
    Server + #13,
    UserName + #13,
    Password + #13,
    Port.ToString + #13)

  finally
    IniFile.Free;
  end;
end;

end.

