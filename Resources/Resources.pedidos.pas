unit Resources.pedidos;

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
  Controller.pedidos;

type

  [Resource('pedidos')]
  [Table('"Expedicao".pedidos')]
  [AutoInc('pedidos_cp_pedidos_seq')]
  [Controllers(TControllerpedidos)]
  Tpedidos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPEDIDO', True, True, False, NotNull)]
    idpedido: String;

    [DBField('CP_CLIENTES', True, True, False, NotNull)]
    cp_clientes: Integer;

    [DBField('IDVENDEDOR', True, True, False, NotNull)]
    idvendedor: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('CP_CARREGAMENTO', True, True, False, NotNull)]
    cp_carregamento: Integer;

    [DBField('IDTIPOPEDIDO', True, True, False, NotNull)]
    idtipopedido: Integer;

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('DATAIMPORTACAO', True, True, False, Null)]
    dataimportacao: TDateTime;

    [DBField('TOTALPEDIDO', True, True, False, NotNull)]
    totalpedido: Integer;

    [DBField('QTDITENS', True, True, False, Null)]
    qtditens: Integer;

    [DBField('ORDEMPEDIDO', True, True, False, Null)]
    ordempedido: Integer;

    [DBField('STATUS', True, True, False, Null)]
    status: String;

    [DBField('CP_PEDIDOS', True, True, False, PrimaryKey)]
    cp_pedidos: Integer;


  end;

implementation

{ Tpedidos }

initialization

RegisterClass(Tpedidos);

end.

