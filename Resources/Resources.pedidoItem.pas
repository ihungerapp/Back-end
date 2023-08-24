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
  [Table('"CONSUMO_AP"')]
  [AutoInc('consumoap_sequence')]
  [Controllers(TControllerpedido_item)]
  TpedidoItem = class(TResourceBaseClass)
  protected
  public
    [DBField('"ID_CONSUMO_AP"', True, True, False, PrimaryKey)]
    id_consumo_ap: Integer;

    [DBField('"CODRECEPCAO"', True, True, False, NotNull)]
    codrecepcao: Integer;

    [DBField('"CODPROD"', True, True, False, NotNull)]
    codprod: Integer;

    [DBField('"N_COMANDA_RECEPCAO"', True, True, False, NotNull)]
    n_comanda_recepcao: Integer;

    [DBField('"QTDE"', True, True, False, NotNull)]
    qtde: Currency;

    [DBField('"VLRUNITARIO"', True, True, False, NotNull)]
    vlrunitario: Currency;

    [DBField('"VLRTOTALITEM"', True, True, False, NotNull)]
    vlrtotalitem: Currency;

    [DBField('"DATA_CONSUMO"', True, True, False, NotNull)]
    data_consumo: TDateTime;

    [DBField('"PEDIDO_ITEM_STATUS"', True, True, False, NotNull)]
    pedido_item_status: String;

    [DBField('"ID_PRODUTO_PRECIFICACAO"', True, True, False, NotNull)]
    id_produto_precificacao: String;

    [DBField('"COMPLEMENTO"', True, True, False, Null)]
    complemento: String;
  end;

implementation

{ Tpedido_item }

initialization

RegisterClass(TpedidoItem);

end.

