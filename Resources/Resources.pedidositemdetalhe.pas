unit Resources.pedidositemdetalhe;

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
  Controller.pedidositemdetalhe;

type

  [Resource('pedidositemdetalhe')]
  [Table('"Expedicao".pedidositemdetalhe')]
  [AutoInc('pedidositemdetalhe_idpedidoitemdetalhe_seq')]
  [Controllers(TControllerpedidositemdetalhe)]
  Tpedidositemdetalhe = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPEDIDOITEMDETALHE', True, True, False, PrimaryKey)]
    idpedidoitemdetalhe: Integer;

    [DBField('IDPEDIDOITEM', True, True, False, NotNull)]
    idpedidoitem: Integer;

    [DBField('CP_PRODUTOS', True, True, False, NotNull)]
    cp_produtos: Integer;

    [DBField('QUANTIDADE', True, True, False, NotNull)]
    quantidade: Integer;

    [DBField('DTVALIDADE', True, True, False, Null)]
    dtvalidade: TDateTime;

    [DBField('DTFABRICACAO', True, True, False, Null)]
    dtfabricacao: TDateTime;


  end;

implementation

{ Tpedidositemdetalhe }

initialization

RegisterClass(Tpedidositemdetalhe);

end.

