program Server;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FrmServer in 'FrmServer.pas' {Form1},
  WK.Server.Config in '..\..\Lib\WKServer\WK.Server.Config.pas',
  WK.Server.Connection in '..\..\Lib\WKServer\WK.Server.Connection.pas',
  WK.Server.Message in '..\..\Lib\WKServer\WK.Server.Message.pas',
  WK.Server.MessageList in '..\..\Lib\WKServer\WK.Server.MessageList.pas',
  WK.Server.TokenWK in '..\..\Lib\WKServer\WK.Server.TokenWK.pas',
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
  WK.Utils.Criptografia in '..\..\Lib\Utils\WK.Utils.Criptografia.pas',
  WK.Server.WebModule in '..\..\lib\WKServer\WK.Server.WebModule.pas' {WebModuleApi: TWebModule},
  WK.Server.Controller in '..\..\lib\WKServer\WK.Server.Controller.pas',
  WK.Server.DAO in '..\..\lib\WKServer\WK.Server.DAO.pas',
  WK.Server.ResourceBaseClass in '..\..\lib\WKServer\WK.Server.ResourceBaseClass.pas',
  WK.Server.Interfaces.Authentication in '..\..\lib\WKServer\Interfaces\WK.Server.Interfaces.Authentication.pas',
  WK.Server.Controller.Interfaces in '..\..\lib\WKServer\Interfaces\WK.Server.Controller.Interfaces.pas',
  WK.Server.Attributes in '..\..\lib\WKServer\WK.Server.Attributes.pas',
  WK.Server.Authentication in '..\..\lib\WKServer\WK.Server.Authentication.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
