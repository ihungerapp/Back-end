unit Resources.pedido;

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
  Controller.pedido;

type

  [Resource('pedido')]
  [Table('"Pedidos".pedido')]
  [AutoInc('pedido_id_pedido_seq')]
  [Controllers(TControllerpedido)]
  Tpedido = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_PEDIDO', True, True, False, PrimaryKey)]
    id_pedido: Integer;

    [DBField('ID_PESSOA', True, True, False, NotNull)]
    id_pessoa: Integer;

    [DBField('VALOR_TOTAL', True, True, False, NotNull)]
    valor_total: Currency;

    [DBField('NOME_CLIENTE', True, True, False, Null)]
    nome_cliente: String;

    [DBField('NUMERO_CELULAR', True, True, False, Null)]
    numero_celular: String;

    [DBField('E_MAIL', True, True, False, Null)]
    e_mail: String;

    [DBField('ID_MESA', True, True, False, NotNull)]
    id_mesa: Integer;

    [DBField('NUMERO_COMANDA', True, True, False, NotNull)]
    numero_comanda: Integer;

    [DBField('DATA_HORA_ABERTURA', True, True, False, NotNull)]
    data_hora_abertura: TDateTime;

    [DBField('DATA_HORA_FINALIZACAO', True, True, False, NotNull)]
    data_hora_finalizacao: TDateTime;

    [DBField('PEDIDO_STATUS', True, True, False, NotNull)]
    pedido_status: String;

    [DBField('FECHAR_CONTA', True, True, False, Null)]
    fechar_conta: Boolean;


  end;

implementation

{ Tpedido }

initialization

RegisterClass(Tpedido);

end.

