unit Server.ServerConsole;

interface

uses

  System.SysUtils,
  System.Classes,
  System.Types,
  IPPeerServer,
  IPPeerAPI,
  IdHTTPWebBrokerBridge,
  Server.Config,
  Web.WebReq,
  Web.WebBroker,
  Server.Constants,
  Server.ResourceBaseClass,
  Server.Authentication,
  Datasnap.DSSession;

type
  Tbase = class(TResourceBaseClass)

  end;

type
  TServerConsole = class(TPersistent)
  public
    procedure TerminateThreads;
    function BindPort(APort: Integer): Boolean;
    function CheckPort(APort: Integer): Integer;
    procedure SetPort(const AServer: TIdHTTPWebBrokerBridge; APort: String);
    procedure StartServer(const AServer: TIdHTTPWebBrokerBridge);
    procedure StopServer(const AServer: TIdHTTPWebBrokerBridge);
    procedure WriteCommands;
    procedure WriteStatus(const AServer: TIdHTTPWebBrokerBridge);
    procedure RunServer(APort: Integer);
  end;

var
  globalServer: TServerConsole;

implementation

uses
  Server.Swagger;

procedure TServerConsole.TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

function TServerConsole.BindPort(APort: Integer): Boolean;
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

function TServerConsole.CheckPort(APort: Integer): Integer;
begin
  if BindPort(APort) then
    Result := APort
  else
    Result := 0;
end;

procedure TServerConsole.SetPort(const AServer: TIdHTTPWebBrokerBridge;
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

procedure TServerConsole.StartServer(const AServer: TIdHTTPWebBrokerBridge);
begin
  if not AServer.Active then
  begin
    if CheckPort(AServer.DefaultPort) > 0 then
    begin
      AServer.Bindings.Clear;
      TAuthentication.GetInstance('"CADUSER"', '"NOME_USUARIO"', '"SENHA"', '"CPF"');
      AServer.Active := True;
    end
    else
      Writeln(Format(sPortInUse, [AServer.DefaultPort.ToString]));
  end
  else
    Writeln(sServerRunning);
end;

procedure TServerConsole.StopServer(const AServer: TIdHTTPWebBrokerBridge);
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

procedure TServerConsole.WriteCommands;
begin
  Writeln(sCommands);
  Write(cArrow);
end;

procedure TServerConsole.WriteStatus(const AServer: TIdHTTPWebBrokerBridge);
begin
  Writeln(sIndyVersion + AServer.SessionList.Version);
  Writeln(sActive + AServer.Active.ToString(TUseBoolStrs.True));
  Writeln(sPort + AServer.DefaultPort.ToString);
  Writeln(sSessionID + AServer.SessionIDCookieName);
  Write(cArrow);
end;

procedure TServerConsole.RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
  LResponse: string;
begin

  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    Writeln('Iniciando conexao ao banco de dados');
    TServerConfig.GetInstance('EmpresaConDef', 'EMPRESA');
    Writeln('Conexao concluida');
  except
    on e: exception do
    begin
      LResponse := e.Message;
      LResponse := '';
      Writeln('Conexao ao banco dados falhou ' + e.Message);
    end;
  end;

  try
    LServer.DefaultPort := APort;

    sleep(300);
    // Wait lib Lazy load
    with TSwagerAPI.Create do
    begin
      Writeln('Config Swagger lib ..');
      MakeReposioty;
       Writeln('Config Swagger lib update, Swager.json ');
      free;
    end;

    StartServer(LServer);
    while True do
    begin
      Readln(LResponse);
      try
        if LResponse <> '' then
        begin
          sleep(100);
          LResponse := LowerCase(LResponse);
          if LResponse.StartsWith(cCommandSetPort) then
            SetPort(LServer, LResponse)
          else if sametext(LResponse, cCommandStart) then
            StartServer(LServer)
          else if sametext(LResponse, cCommandStatus) then
            WriteStatus(LServer)
          else if sametext(LResponse, cCommandStop) then
            StopServer(LServer)
          else if sametext(LResponse, cCommandHelp) then
            WriteCommands
          else if sametext(LResponse, cCommandExit) then
            if LServer.Active then
            begin
              StopServer(LServer);
              break
            end
            else
              break
          else
          begin
            Writeln(LResponse + ' is invalid command');
            Write(cArrow);
          end;
        end;
      except
        on e: exception do
          Writeln(' Excess�o ocorrida ' + e.Message);
      end;
    end;
    TerminateThreads();
  finally
    LServer.Free;
  end;
end;

initialization

globalServer := TServerConsole.Create;

end.
