program Server;
//{$APPTYPE CONSOLE}

uses
  Vcl.SvcMgr,
  Web.WebReq,
  System.SysUtils,
  uService in 'uService.pas' {HungerServer: TService},
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
  Server.ServerConsole in '..\..\lib\Server\Server.ServerConsole.pas',
  Resources.usuario in '..\..\Resources\Resources.usuario.pas',
  DAO.Usuario in '..\..\DAO\DAO.Usuario.pas',
  Controller.Usuario in '..\..\Controllers\Controller.Usuario.pas',
  Controller.Cidade in '..\..\Controllers\Controller.Cidade.pas',
  Controller.Grupo in '..\..\Controllers\Controller.Grupo.pas',
  Controller.Pessoa in '..\..\Controllers\Controller.Pessoa.pas',
  Controller.Precificacao in '..\..\Controllers\Controller.Precificacao.pas',
  Controller.Produto in '..\..\Controllers\Controller.Produto.pas',
  Controller.Produto_precificacao in '..\..\Controllers\Controller.Produto_precificacao.pas',
  DAO.Cidade in '..\..\DAO\DAO.Cidade.pas',
  DAO.Grupo in '..\..\DAO\DAO.Grupo.pas',
  DAO.Pessoa in '..\..\DAO\DAO.Pessoa.pas',
  DAO.Precificacao in '..\..\DAO\DAO.Precificacao.pas',
  DAO.Produto in '..\..\DAO\DAO.Produto.pas',
  DAO.Produto_precificacao in '..\..\DAO\DAO.Produto_precificacao.pas',
  Resources.cidade in '..\..\Resources\Resources.cidade.pas',
  Resources.grupo in '..\..\Resources\Resources.grupo.pas',
  Resources.pessoa in '..\..\Resources\Resources.pessoa.pas',
  Resources.precificacao in '..\..\Resources\Resources.precificacao.pas',
  Resources.produto in '..\..\Resources\Resources.produto.pas',
  Resources.produto_precificacao in '..\..\Resources\Resources.produto_precificacao.pas',
  Controller.Pedido in '..\..\Controllers\Controller.Pedido.pas',
  Controller.Pedido_item in '..\..\Controllers\Controller.Pedido_item.pas',
  DAO.Pedido in '..\..\DAO\DAO.Pedido.pas',
  DAO.Pedido_item in '..\..\DAO\DAO.Pedido_item.pas',
  Resources.pedido in '..\..\Resources\Resources.pedido.pas',
  Resources.pedidoItem in '..\..\Resources\Resources.pedidoItem.pas',
  Resources.mesa in '..\..\Resources\Resources.mesa.pas',
  Controller.Mesa in '..\..\Controllers\Controller.Mesa.pas',
  DAO.Mesa in '..\..\DAO\DAO.Mesa.pas',
  Swager.Json.Body in '..\..\lib\Swager\Swager.Json.Body.pas',
  Swager.Json.Definitions in '..\..\lib\Swager\Swager.Json.Definitions.pas',
  Swager.Json.DTO in '..\..\lib\Swager\Swager.Json.DTO.pas',
  Swager.Json.Paths in '..\..\lib\Swager\Swager.Json.Paths.pas',
  Swager.ResourceBaseClass in '..\..\lib\Swager\Swager.ResourceBaseClass.pas',
  Server.Swagger in '..\..\lib\Server\Server.Swagger.pas',
  Server.AngularModel in '..\..\lib\Server\Server.AngularModel.pas',
  Utils.Strings in '..\..\lib\Utils\Utils.Strings.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //

//  Application.Initialize;
//  if WebRequestHandler <> nil then
//    WebRequestHandler.WebModuleClass := WebModuleClass;
//  Application.CreateForm(THungerServer, HungerServer);
//  Application.Run;
//  try
//    if WebRequestHandler <> nil then
//      WebRequestHandler.WebModuleClass := WebModuleClass;
//    Writeln('################################################################');
//    Writeln(' / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \   ' + #13#10 +
//      '( H | U | N | G | E | R | A | P | P ) ( S | E | R | V | E | R )  ' + #13#10 +
//      ' \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/   ' + #13#10);
//    Writeln('################################################################');
//    Writeln('V-1.0.0');
//    Writeln('Iniciando na porta 8081');
//    StartClassGroup(TComponent);
//    ActivateClassGroup(TComponent);
//    globalServer.RunServer(8081);
//
//  except
//    on e: exception do
//      Writeln(e.ClassName, ': ', e.Message);
//  end;


  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(THungerServer, HungerServer);
  Application.Run;
end.
