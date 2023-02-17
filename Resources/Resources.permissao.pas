unit Resources.permissao;

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
  Controller.permissao;

type

  [Resource('permissao')]
  [Table('"Rotinas e Acessos".permissao')]
  [AutoInc('permissao_idpermissao_seq')]
  [Controllers(TControllerpermissao)]
  Tpermissao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPERMISSAO', True, True, False, PrimaryKey)]
    idpermissao: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('IDFUNCIONALIDADE', True, True, False, NotNull)]
    idfuncionalidade: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('DATALIBERACAO', True, True, False, Null)]
    dataliberacao: TDateTime;

    [DBField('IDUSUARIOLIBERACAO', True, True, False, NotNull)]
    idusuarioliberacao: Integer;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;


  end;

implementation

{ Tpermissao }

initialization

RegisterClass(Tpermissao);

end.

