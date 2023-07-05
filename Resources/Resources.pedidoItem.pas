unit Resources.pedidoItem;

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
  Controller.pedido_item;

type

  [Resource('pedidoItem')]
  [Table('"Pedidos".pedido_item')]
  [AutoInc('pedido_item_id_pedido_item_seq')]
  [Controllers(TControllerpedido_item)]
  TpedidoItem = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_PEDIDO_ITEM', True, True, False, PrimaryKey)]
    id_pedido_item: Integer;

    [DBField('ID_PEDIDO', True, True, False, NotNull)]
    id_pedido: Integer;

    [DBField('ID_PRODUTO', True, True, False, NotNull)]
    id_produto: Integer;

    [DBField('QTDE', True, True, False, NotNull)]
    qtde: Currency;

    [DBField('VALOR_UNITARIO', True, True, False, NotNull)]
    valor_unitario: Currency;

    [DBField('VALOR_TOTAL', True, True, False, NotNull)]
    valor_total: Currency;

    [DBField('DATA_HORA_EMISSAO', True, True, False, NotNull)]
    data_hora_emissao: TDateTime;

    [DBField('DATA_HORA_STATUS', True, True, False, NotNull)]
    data_hora_status: TDateTime;

    [DBField('PEDIDO_ITEM_STATUS', True, True, False, NotNull)]
    pedido_item_status: String;

    [DBField('ID_PRODUTO_PRECIFICACAO', True, True, False, NotNull)]
    id_produto_precificacao: String;

    [DBField('OBS', True, True, False, Null)]
    obs: String;
  end;

implementation

{ Tpedido_item }

initialization

RegisterClass(TpedidoItem);

end.

