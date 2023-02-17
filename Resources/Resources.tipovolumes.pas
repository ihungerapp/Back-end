unit Resources.tipovolumes;

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
  Controller.tipovolumes;

type

  [Resource('tipovolumes')]
  [Table('"Cadastros WMS".tipovolumes')]
  [AutoInc('tipovolumes_idtipovolumes_seq')]
  [Controllers(TControllertipovolumes)]
  Ttipovolumes = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOVOLUMES', True, True, False, PrimaryKey)]
    idtipovolumes: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipovolumes }

initialization

RegisterClass(Ttipovolumes);

end.

