unit Resources.pedido;

interface

uses
  System.Classes,
  System.SysUtils,
  Web.HTTPApp,
  Server.Attributes, 
  Server.ResourceBaseClass, 
  Server.Message,
  Server.MessageList, 
  Server.Connection,
  System.Generics.Collections,
  Controller.pedido,
  Resources.pedidoItem;

type

  [Resource('pedido')]
  [Table('"RECEPCAO"')]
  [AutoInc('recepcao_sequence')]
  [Controllers(TControllerpedido)]
  Tpedido = class(TResourceBaseClass)
  protected
  public
    [DBField('"CODRECEPCAO"', True, True, False, PrimaryKey)]
    codrecepcao: Integer;

    [DBField('"CODCLI"', True, True, False, NotNull)]
    codcli: Integer;

    [DBField('"VLRTOTAL"', True, True, False, NotNull)]
    vlrtotal: Currency;

    [DBField('"NOME_CLIENTE"', True, True, False, Null)]
    nome_cliente: String;

    [DBField('"NUMERO_CELULAR"', True, True, False, Null)]
    numero_celular: String;

    [DBField('"E_MAIL"', True, True, False, Null)]
    e_mail: String;

    [DBField('"CODAP"', True, True, False, NotNull)]
    codap: Integer;

    [DBField('"QTDEPAGANTE"', True, True, False, NotNull)]
    qtdepagante: Integer;

    [DBField('"N_COMANDA"', True, True, False, NotNull)]
    n_comanda: Integer;

    [DBField('"DATA_ENTRADA"', True, True, False, NotNull)]
    data_entrada: TDateTime;

    [DBField('"DATA_SAIDA"', True, True, False, NotNull)]
    data_saida: TDateTime;

    [DBField('"SITUACAO"', True, True, False, NotNull)]
    situacao: String;

    [DBField('"FECHAR_CONTA"', True, True, False, Null)]
    fechar_conta: Boolean;

    [DBRelationship('PEDIDOITEM')]
    pedidoItem: TObjectList<TpedidoItem>;
  end;

implementation

{ Tpedido }

initialization

RegisterClass(Tpedido);

end.

