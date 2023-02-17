unit Resources.pedidositem;

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
  Controller.pedidositem;

type

  [Resource('pedidositem')]
  [Table('"Expedicao".pedidositem')]
  [AutoInc('pedidositem_idpedidoitem_seq')]
  [Controllers(TControllerpedidositem)]
  Tpedidositem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPEDIDOITEM', True, True, False, PrimaryKey)]
    idpedidoitem: Integer;

    [DBField('CP_PEDIDOS', True, True, False, NotNull)]
    cp_pedidos: Integer;

    [DBField('CP_PRODUTOS', True, True, False, NotNull)]
    cp_produtos: Integer;

    [DBField('QUANTIDADE', True, True, False, NotNull)]
    quantidade: Integer;

    [DBField('QTDSEPARADA', True, True, False, Null)]
    qtdseparada: Integer;

    [DBField('QTDCONFERIDA', True, True, False, Null)]
    qtdconferida: Integer;

    [DBField('QTDCORTADA', True, True, False, Null)]
    qtdcortada: Integer;


  end;

implementation

{ Tpedidositem }

initialization

RegisterClass(Tpedidositem);

end.

