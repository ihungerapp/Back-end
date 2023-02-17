unit Resources.perfil;

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
  Controller.perfil;

type

  [Resource('perfil')]
  [Table('"Rotinas e Acessos".perfil')]
  [AutoInc('perfil_idperfil_seq')]
  [Controllers(TControllerperfil)]
  Tperfil = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPERFIL', True, True, False, PrimaryKey)]
    idperfil: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('DESCRICAO', True, True, False, Null)]
    descricao: String;

    [DBField('CODIGO', True, True, False, Null)]
    codigo: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;


  end;

implementation

{ Tperfil }

initialization

RegisterClass(Tperfil);

end.

