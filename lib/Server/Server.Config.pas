unit Server.Config;

interface

uses
  System.IniFiles, System.SysUtils, FireDAC.Comp.Client, System.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
//  FireDAC.VCLUI.Wait,
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
  IniFile: TIniFile;
  Database: string;
  Server: string;
  UserName: string;
  Password: string;
  Params: TStrings;
  Port: Integer;
  LPath: string;
begin
  IniFile := TIniFile.Create(TPath.Combine(GetCurrentDir, 'ConfigServer.Ini'));
  try
    {$IFDEF MSWINDOWS}
      Database := IniFile.ReadString('Config', 'Database', '');
      Server := IniFile.ReadString('Config', 'Server', '');
      UserName := IniFile.ReadString('Config', 'UserName', '');
      Password := '912167';//TCriptografia.Descriptografar(IniFile.ReadString('Config', 'Password', ''));
      Port := StrToInt(IniFile.ReadString('Config', 'Port', '5432'));
    {$ENDIF}
    {$IFDEF LINUX}
      Database := 'wkLogtech';
      Server := 'localhost';
      UserName := 'postgres';
      Password := '912167';
      Port := 5432;
    {$ENDIF}
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

  finally
    IniFile.Free;
  end;
end;

// procedure TServerConfig.ConfigDB;
//var
//  IniFile: TIniFile;
//  Database: string;
//  Server: string;
//  UserName: string;
//  Password: string;
//  Params: TStrings;
//begin
//  IniFile := TIniFile.Create(TPath.Combine(GetCurrentDir, 'ConfigServer.Ini'));
//  try
//    Server := IniFile.ReadString('Conexao', 'Server', '');
//    Database := IniFile.ReadString('Conexao', 'Database', '');
//    UserName := IniFile.ReadString('Conexao', 'User_Name', '');
//    Password := IniFile.ReadString('Conexao', 'Password', '');
//
//    Params := TStringList.Create;
//    Params.AddPair('DriverID', 'FB');
//    Params.AddPair('Server', Server);
//    Params.AddPair('Database', Database);
//    Params.AddPair('User_Name', UserName);
//    Params.AddPair('Password', Password);
//    Params.AddPair('Pooled', 'True');
//
//    FInstance.FDManager := TFDManager.Create(nil);
//    FInstance.FDManager.AddConnectionDef('EdmilServer', 'FB', Params);
//    FInstance.FDManager.Active := True;
//    Writeln('Conectando com o servidor ->> ' + Server);
//  finally
//    IniFile.Free;
//  end;
//end;
end.

