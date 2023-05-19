unit Server.Config;

interface

uses
  System.IniFiles, System.SysUtils, FireDAC.Comp.Client, System.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Phys.PGDef, FireDAC.Phys.IBBase, FireDAC.Phys.PG, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.DataSet, System.Classes, System.IOUtils,
  Server.Connection,
  {$IFDEF MSWINDOWS}
  Vcl.Forms,
  {$ENDIF MSWINDOWS}
  Utils.Criptografia;

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
  Database: string;
  Server: string;
  UserName: string;
  Password: string;
  Params: TStrings;
  Port: Integer;
  LPath: string;
begin
  {$IFDEF MSWINDOWS}
  var IniFile: TIniFile;
  //IniFile := TIniFile.Create(TPath.Combine(GetCurrentDir, 'ConfigServer.Ini'));
  IniFile := TIniFile.Create(ChangeFileExt( Application.ExeName, '.ini'));
  {$ENDIF}
  {$IFDEF LINUX} //path quando executa a API como container no Docker
  var IniFile: TMemIniFile;
  IniFile := TMemIniFile.Create('/root/deploy/ConfigServer.ini');
  {$ENDIF}
  try
    Database := IniFile.ReadString('Config', 'Database', '');
    Server := IniFile.ReadString('Config', 'Server', '');
    UserName := IniFile.ReadString('Config', 'UserName', '');
    Password := 'rm045369';//TCriptografia.Descriptografar(IniFile.ReadString('Config', 'Password', ''));
    Port := StrToInt(IniFile.ReadString('Config', 'Port', '5432'));
    Params := TStringList.Create;
    Params.AddPair('DriverID', 'PG');
    Params.AddPair('Server', Server);
    Params.AddPair('Database', Database);
    Params.AddPair('User_Name', UserName);
    Params.AddPair('Password', Password);
    Params.AddPair('Port', Port.ToString);
    Params.AddPair('Pooled', 'True');
    Params.AddPair('GUIDEndian', 'Big');

    FInstance.FDManager := TFDManager.Create(nil);
    FInstance.FDManager.AddConnectionDef('WKServer', 'PG', Params);
    FInstance.FDManager.Active := True;
//    Writeln('Conectando com o servidor ->> ' + Server);
//
//    Writeln(Database + #13,
//    Server + #13,
//    UserName + #13,
//    Password + #13,
//    Port.ToString + #13)
  finally
    IniFile.Free;
  end;
end;

end.

