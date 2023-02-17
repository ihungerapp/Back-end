unit Server.Constants;

interface
 const
   SQLPermisao =
   'SELECT                       '+#13#10+
   '  A.T002IDOPER as id ,       '+#13#10+
   '  A.T002DESCRICAO as nome,   '+#13#10+
   '  A.T002CODSIS as codsis,    '+#13#10+
   '  A.T002NIVEL as nivel ,     '+#13#10+
   '  A.T002VALIDADE as validade '+#13#10+
   'FROM                  '+#13#10+
   '   T002OPERSIS A      '+#13#10+
   'INNER JOIN T004DIREITOS D         '+#13#10+
   '   ON D.T004IDOPER  =A.T002IDOPER '+#13#10+
   'WHERE                             '+#13#10+
  '   D.T004IDUSER = %s' ;

  CamposUser =
    '  T003GRUPO  as grupo , T003SETOR  as setor, T003NOME   as nome , ';



resourcestring
  sPortInUse = '- Error: Port %s already in use';
  sPortSet = '- Port set to %s';
  sServerRunning = '- The Server is already running';
  sStartingServer = '- Starting HTTP Server on port %d';
  sStoppingServer = '- Stopping Server';
  sServerStopped = '- Server Stopped';
  sServerNotRunning = '- The Server is not running';
  sInvalidCommand = '- Error: Invalid Command';
  sIndyVersion = '- Indy Version: ';
  sActive = '- Active: ';
  sPort = '- Port: ';
  sSessionID = '- Session ID CookieName: ';
  sCommands = 'Enter a Command: ' + slineBreak +
    '   - "start" to start the server'+ slineBreak +
    '   - "stop" to stop the server'+ slineBreak +
    '   - "set port" to change the default port'+ slineBreak +
    '   - "status" for Server status'+ slineBreak +
    '   - "help" to show commands'+ slineBreak +
    '   - "exit" to close the application';

const
  cArrow = '->';
  cCommandStart = 'start';
  cCommandStop = 'stop';
  cCommandStatus = 'status';
  cCommandHelp = 'help';
  cCommandSetPort = 'set port';
  cCommandExit = 'exit';

implementation

end.
implementation

end.
