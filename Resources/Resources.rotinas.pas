unit Resources.rotinas;

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
  Controller.rotinas;

type

  [Resource('rotinas')]
  [Table('"Rotinas e Acessos".rotinas')]
  [AutoInc('rotinas_idrotina_seq')]
  [Controllers(TControllerrotinas)]
  Trotinas = class(TResourceBaseClass)
  protected
  public
    [DBField('IDROTINA', True, True, False, PrimaryKey)]
    idrotina: Integer;

    [DBField('IDMENU', True, True, False, NotNull)]
    idmenu: Integer;

    [DBField('NOMEROTINA', True, True, False, Null)]
    nomerotina: String;

    [DBField('ORDEM', True, True, False, Null)]
    ordem: Integer;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('IDTIPOROTINA', True, True, False, NotNull)]
    idtiporotina: Integer;

    [DBField('IDAPLICACAO', True, True, False, Null)]
    idaplicacao: Integer;


  end;

implementation

{ Trotinas }

initialization

RegisterClass(Trotinas);

end.

