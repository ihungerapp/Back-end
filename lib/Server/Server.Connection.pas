unit Server.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Stan.Def, FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Stan.Async, FireDAC.UI.Intf,
//  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Stan.Option, FireDAC.Stan.Pool, FireDAC.Phys.PG;

type
  TConnection = class
  private
    FQuery: TFDQuery;
    FDB: TFDConnection;
    Fdriver: TFDPhysPGDriverLink;
  public
    property DB: TFDConnection read FDB write FDB;
    property Query: TFDQuery read FQuery write FQuery;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
//  Vcl.Dialogs,
  Server.Config;

{ TConnection }

constructor TConnection.Create;
begin
  try
    Fdriver := TFDPhysPGDriverLink.Create(Nil);
    {$IFDEF WINDOWS}
      Fdriver.VendorLib := ExtractFilePath(GetModuleName(HInstance)) + 'libpq.dll';
    {$ENDIF}
    {$IFDEF LINUX}
    //Rodar o comando: sudo apt-get install libpq-dev
    {$ENDIF}
//    if not Assigned(DB) then
//    begin
//      DB := TFDConnection.Create(nil);
//      DB.ConnectionDefName := 'WKServer';
//      DB.Connected := True;
//    end;
    Query := TFDQuery.Create(nil);
    Query.ConnectionName := 'WKServer';
//    writeln('Chamou query');
//    Query.Connection := DB;
  except
    on E: Exception do
      Writeln('TConnection.Create ' + E.Message);
  end;
end;

destructor TConnection.Destroy;
begin
  Query.Close;
  Query.Free;
  DB.Connected := False;
  DB.Free;
  inherited;
end;

end.

