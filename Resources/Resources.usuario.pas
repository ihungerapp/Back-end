unit Resources.usuario;

interface

uses
  System.Classes, 
  System.Generics.Collections, 
  System.SysUtils,
  Web.HTTPApp,
  Server.Attributes, 
  Server.ResourceBaseClass, 
  Server.Message,
  Server.MessageList, 
  Server.Connection,
  Controller.usuario;

type

  [Resource('usuario')]
  [Table('CADUSER')]
//  [AutoInc('usuario_id_usuario_seq')]
  [Controllers(TControllerusuario)]
  Tusuario = class(TResourceBaseClass)
  protected
  public
    [DBField('CODUSER', True, True, False, PrimaryKey)]
    coduser: Integer;

    [DBField('NOME_USUARIO', True, True, False, NotNull)]
    nome_usuario: String;

    [DBField('SENHA', True, True, False, NotNull)]
    senha: String;
  end;

implementation

{ Tusuario }

initialization

RegisterClass(Tusuario);

end.

