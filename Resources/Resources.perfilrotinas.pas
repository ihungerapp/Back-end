unit Resources.perfilrotinas;

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
  Controller.perfilrotinas;

type

  [Resource('perfilrotinas')]
  [Table('"Rotinas e Acessos".perfilrotinas')]
  [AutoInc('perfilrotinas_idperfilrotinas_seq')]
  [Controllers(TControllerperfilrotinas)]
  Tperfilrotinas = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPERFILROTINAS', True, True, False, PrimaryKey)]
    idperfilrotinas: Integer;

    [DBField('IDPERFIL', True, True, False, NotNull)]
    idperfil: Integer;

    [DBField('IDPERMISSAO', True, True, False, NotNull)]
    idpermissao: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;


  end;

implementation

{ Tperfilrotinas }

initialization

RegisterClass(Tperfilrotinas);

end.

