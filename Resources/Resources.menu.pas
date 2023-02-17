unit Resources.menu;

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
  Controller.menu;

type

  [Resource('menu')]
  [Table('"Rotinas e Acessos".menu')]
  [AutoInc('menu_idmenu_seq')]
  [Controllers(TControllermenu)]
  Tmenu = class(TResourceBaseClass)
  protected
  public
    [DBField('IDMENU', True, True, False, PrimaryKey)]
    idmenu: Integer;

    [DBField('NOMEMENU', True, True, False, Null)]
    nomemenu: String;

    [DBField('ORDEM', True, True, False, Null)]
    ordem: Integer;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;


  end;

implementation

{ Tmenu }

initialization

RegisterClass(Tmenu);

end.

