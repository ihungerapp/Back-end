unit Resources.usuariosmeta;

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
  Controller.usuariosmeta;

type

  [Resource('usuariosmeta')]
  [Table('"Cadastros WMS".usuariosmeta')]
  [AutoInc('usuariosmeta_idmeta_seq')]
  [Controllers(TControllerusuariosmeta)]
  Tusuariosmeta = class(TResourceBaseClass)
  protected
  public
    [DBField('IDMETA', True, True, False, PrimaryKey)]
    idmeta: Integer;

    [DBField('IDATIVIDADE', True, True, False, NotNull)]
    idatividade: Integer;

    [DBField('META', True, True, False, Null)]
    meta: String;

    [DBField('IDUSUARIO', True, True, False, Null)]
    idusuario: Integer;


  end;

implementation

{ Tusuariosmeta }

initialization

RegisterClass(Tusuariosmeta);

end.

