unit Resources.versaobd;

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
  Controller.versaobd;

type

  [Resource('versaobd')]
  [Table('"Parametrizacao".versaobd')]
  [AutoInc('versaobd_idversao_seq')]
  [Controllers(TControllerversaobd)]
  Tversaobd = class(TResourceBaseClass)
  protected
  public
    [DBField('IDVERSAO', True, True, False, PrimaryKey)]
    idversao: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('VERSAOSCRIPT', True, True, False, Null)]
    versaoscript: String;

    [DBField('VERSAOGESTAO', True, True, False, Null)]
    versaogestao: String;

    [DBField('VERSAOCOLETOR', True, True, False, Null)]
    versaocoletor: String;


  end;

implementation

{ Tversaobd }

initialization

RegisterClass(Tversaobd);

end.

