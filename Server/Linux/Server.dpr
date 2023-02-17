program Server;
{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Types,
  IPPeerServer,
  IPPeerAPI,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  Datasnap.DSSession,
  Server.Attributes in '..\..\lib\Server\Server.Attributes.pas',
  Server.Config in '..\..\Lib\Server\Server.Config.pas',
  Server.Connection in '..\..\Lib\Server\Server.Connection.pas',
  Server.DAO in '..\..\Lib\Server\Server.DAO.pas',
  Server.Message in '..\..\Lib\Server\Server.Message.pas',
  Server.MessageList in '..\..\Lib\Server\Server.MessageList.pas',
  Server.ResourceBaseClass in '..\..\Lib\Server\Server.ResourceBaseClass.pas',
  Server.Token in '..\..\Lib\Server\Server.Token.pas',
  JOSE.Builder in '..\..\Lib\JWT\JOSE.Builder.pas',
  JOSE.Consumer in '..\..\Lib\JWT\JOSE.Consumer.pas',
  JOSE.Consumer.Validators in '..\..\Lib\JWT\JOSE.Consumer.Validators.pas',
  JOSE.Context in '..\..\Lib\JWT\JOSE.Context.pas',
  JOSE.Core.Base in '..\..\Lib\JWT\JOSE.Core.Base.pas',
  JOSE.Core.Builder in '..\..\Lib\JWT\JOSE.Core.Builder.pas',
  JOSE.Core.JWA.Compression in '..\..\Lib\JWT\JOSE.Core.JWA.Compression.pas',
  JOSE.Core.JWA.Encryption in '..\..\Lib\JWT\JOSE.Core.JWA.Encryption.pas',
  JOSE.Core.JWA.Factory in '..\..\Lib\JWT\JOSE.Core.JWA.Factory.pas',
  JOSE.Core.JWA in '..\..\Lib\JWT\JOSE.Core.JWA.pas',
  JOSE.Core.JWA.Signing in '..\..\Lib\JWT\JOSE.Core.JWA.Signing.pas',
  JOSE.Core.JWE in '..\..\Lib\JWT\JOSE.Core.JWE.pas',
  JOSE.Core.JWK in '..\..\Lib\JWT\JOSE.Core.JWK.pas',
  JOSE.Core.JWS in '..\..\Lib\JWT\JOSE.Core.JWS.pas',
  JOSE.Core.JWT in '..\..\Lib\JWT\JOSE.Core.JWT.pas',
  JOSE.Core.Parts in '..\..\Lib\JWT\JOSE.Core.Parts.pas',
  JOSE.Encoding.Base64 in '..\..\Lib\JWT\JOSE.Encoding.Base64.pas',
  JOSE.Hashing.HMAC in '..\..\Lib\JWT\JOSE.Hashing.HMAC.pas',
  JOSE.OpenSSL.Headers in '..\..\Lib\JWT\JOSE.OpenSSL.Headers.pas',
  JOSE.Signing.Base in '..\..\Lib\JWT\JOSE.Signing.Base.pas',
  JOSE.Signing.ECDSA in '..\..\Lib\JWT\JOSE.Signing.ECDSA.pas',
  JOSE.Signing.RSA in '..\..\Lib\JWT\JOSE.Signing.RSA.pas',
  JOSE.Types.Arrays in '..\..\Lib\JWT\JOSE.Types.Arrays.pas',
  JOSE.Types.Bytes in '..\..\Lib\JWT\JOSE.Types.Bytes.pas',
  JOSE.Types.JSON in '..\..\Lib\JWT\JOSE.Types.JSON.pas',
  JOSE.Types.Utils in '..\..\Lib\JWT\JOSE.Types.Utils.pas',
  Utils.Criptografia in '..\..\Lib\Utils\Utils.Criptografia.pas',
  Server.WebModule in '..\..\lib\Server\Server.WebModule.pas' {WebModuleApi: TWebModule},
  Server.Interfaces.Authentication in '..\..\lib\Server\Interfaces\Server.Interfaces.Authentication.pas',
  Server.Authentication in '..\..\lib\Server\Server.Authentication.pas',
  Server.Constants in '..\..\lib\Server\Server.Constants.pas',
  System.Classes,
  Server.Controller.Interfaces in '..\..\lib\Server\Interfaces\Server.Controller.Interfaces.pas',
  Server.Controller in '..\..\lib\Server\Server.Controller.pas',
  Server.ServerConsole in '..\..\lib\Server\Server.ServerConsole.pas';

begin
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    Writeln('################################################################');
    Writeln(' / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \   ' + #13#10 +
      '( H | U | N | G | E | R | A | P | P ) ( S | E | R | V | E | R )  ' + #13#10 +
      ' \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/   ' + #13#10);
    Writeln('################################################################');
    Writeln('V-1.0.0');
    Writeln('Iniciando na porta 8081');
    StartClassGroup(TComponent);
    ActivateClassGroup(TComponent);
    globalServer.RunServer(8081);

  except
    on e: exception do
      Writeln(e.ClassName, ': ', e.Message);
  end;

end.

end.

