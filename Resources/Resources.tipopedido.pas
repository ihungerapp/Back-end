unit Resources.tipopedido;

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
  Controller.tipopedido;

type

  [Resource('tipopedido')]
  [Table('"Cadastros WMS".tipopedido')]
  [AutoInc('tipopedido_idtipopedido_seq')]
  [Controllers(TControllertipopedido)]
  Ttipopedido = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOPEDIDO', True, True, False, PrimaryKey)]
    idtipopedido: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipopedido }

initialization

RegisterClass(Ttipopedido);

end.

