unit uService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, System.Types,
  IPPeerServer,
  IPPeerAPI,
  IdHTTPWebBrokerBridge,
  Server.Config,
  Server.Constants,
  Server.Authentication,
  Datasnap.DSSession;

type
  THungerServer = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure TerminateThreads;
    function BindPort(APort: Integer): Boolean;
    function CheckPort(APort: Integer): Integer;
    procedure SetPort(const AServer: TIdHTTPWebBrokerBridge; APort: String);
    procedure StartServer(const AServer: TIdHTTPWebBrokerBridge);
    procedure StopServer(const AServer: TIdHTTPWebBrokerBridge);
    procedure WriteCommands;
    procedure WriteStatus(const AServer: TIdHTTPWebBrokerBridge);
    procedure RunServer(APort: Integer);
  public
    function GetServiceController: TServiceController; override;
  end;

var
  HungerServer: THungerServer;

implementation

uses
  Web.WebReq, Server.WebModule;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  HungerServer.Controller(CtrlCode);
end;

function THungerServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure THungerServer.ServiceCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(nil);
end;

procedure THungerServer.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    Sleep(1000);
    ServiceThread.ProcessRequests(False);
  end;
end;

procedure THungerServer.ServiceStart(Sender: TService; var Started: Boolean);
begin
  try
    if not FServer.Active then
    begin
      if WebRequestHandler <> nil then
        WebRequestHandler.WebModuleClass := WebModuleClass;
      StartClassGroup(TComponent);
      ActivateClassGroup(TComponent);
      RunServer(8081);
    end;
  except
    on e: exception do
      Writeln(e.ClassName, ': ', e.Message);
  end;
end;

procedure THungerServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
  ServiceThread.Terminate;
end;

procedure THungerServer.TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

function THungerServer.BindPort(APort: Integer): Boolean;
var
  LTestServer: IIPTestServer;
begin
  Result := True;
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(APort, nil);
  except
    Result := False;
  end;
end;

function THungerServer.CheckPort(APort: Integer): Integer;
begin
  if BindPort(APort) then
    Result := APort
  else
    Result := 0;
end;

procedure THungerServer.SetPort(const AServer: TIdHTTPWebBrokerBridge;
  APort: String);
begin
  if not AServer.Active then
  begin
    APort := APort.Replace(cCommandSetPort, '').Trim;
    if CheckPort(APort.ToInteger) > 0 then
    begin
      AServer.DefaultPort := APort.ToInteger;
      Writeln(Format(sPortSet, [APort]));
    end
    else
      Writeln(Format(sPortInUse, [APort]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure THungerServer.StartServer(const AServer: TIdHTTPWebBrokerBridge);
begin
  if not AServer.Active then
  begin
    if CheckPort(AServer.DefaultPort) > 0 then
    begin
      TAuthentication.GetInstance('"Acessos".usuario', 'nome_usuario', 'senha');
      AServer.Active := True;
    end
    else
      Writeln(Format(sPortInUse, [AServer.DefaultPort.ToString]));
  end
  else
    Writeln(sServerRunning);
end;

procedure THungerServer.StopServer(const AServer: TIdHTTPWebBrokerBridge);
begin
  if AServer.Active then
  begin
    Writeln(sStoppingServer);
    TerminateThreads;
    AServer.Active := False;
    AServer.Bindings.Clear;
    Writeln(sServerStopped);
  end
  else
    Writeln(sServerNotRunning);
  Write(cArrow);
end;

procedure THungerServer.WriteCommands;
begin
  Writeln(sCommands);
  Write(cArrow);
end;

procedure THungerServer.WriteStatus(const AServer: TIdHTTPWebBrokerBridge);
begin
  Writeln(sIndyVersion + AServer.SessionList.Version);
  Writeln(sActive + AServer.Active.ToString(TUseBoolStrs.True));
  Writeln(sPort + AServer.DefaultPort.ToString);
  Writeln(sSessionID + AServer.SessionIDCookieName);
  Write(cArrow);
end;

procedure THungerServer.RunServer(APort: Integer);
var
  LResponse: string;
begin
    TServerConfig.GetInstance;
    FServer.Bindings.Clear;
    FServer.DefaultPort := APort;
    StartServer(FServer);
end;

end.
