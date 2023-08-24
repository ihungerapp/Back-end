unit Resources.mesa;

interface

uses
  System.Classes, 
  System.Generics.Collections, 
  System.SysUtils,
  Web.HTTPApp,
  Server.Attributes, 
  Server.ResourceBaseClass, 
  Server.Message,
  Server.MessageList, 
  Server.Connection,
  Controller.mesa,
  Resources.pedido;

type

  [Resource('mesa')]
  [Table('"CADAP"')]
  [AutoInc('cadap_sequence')]
  [Controllers(TControllermesa)]
  Tmesa = class(TResourceBaseClass)
  protected
  public
    [DBField('"CODAP"', True, True, False, PrimaryKey)]
    id_mesa: Integer;

    [DBField('"DESCRICAO"', True, True, False, NotNull)]
    descricao: String;

    [DBField('"CADAP_UUID"', True, True, False, NotNull)]
    mesa_uuid: String;

    [DBRelationship('PEDIDO')]
    pedido: TObjectList<Tpedido>;
  end;

implementation

{ Tmesa }

initialization

RegisterClass(Tmesa);

end.

