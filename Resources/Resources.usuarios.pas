unit Resources.usuarios;

interface

uses
  System.Classes, 
  System.Generics.Collections, 
  System.SysUtils,
  Web.HTTPApp,
  WK.Server.Attributes, 
  WK.Server.ResourceBaseClass, 
  WK.Server.Message,
  WK.Server.MessageList, 
  WK.Server.Connection,
  Controller.usuarios;

type

  [Resource('usuarios')]
  [Table('"Cadastros WMS".usuarios')]
  [AutoInc('usuarios_idusuario_seq')]
  [Controllers(TControllerusuarios)]
  Tusuarios = class(TResourceBaseClass)
  protected
  public
    [DBField('IDUSUARIO', True, True, False, PrimaryKey)]
    idusuario: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('LOGIN', True, True, False, Null)]
    login: String;

    [DBField('SENHA', True, True, False, Null)]
    senha: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('DATACADASTRO', True, True, False, Null)]
    datacadastro: TDateTime;

    [DBField('IDSETOR', True, True, False, Null)]
    idsetor: Integer;

    [DBField('IDTURNO', True, True, False, Null)]
    idturno: Integer;

    [DBField('EMAIL', True, True, False, NotNull)]
    email: String;

    [DBField('TELEFONE', True, True, False, NotNull)]
    telefone: String;


  end;

implementation

{ Tusuarios }

initialization

RegisterClass(Tusuarios);

end.

