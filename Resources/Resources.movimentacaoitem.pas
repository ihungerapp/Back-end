unit Resources.movimentacaoitem;

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
  Controller.movimentacaoitem;

type

  [Resource('movimentacaoitem')]
  [Table('"Movimentacao".movimentacaoitem')]
  [AutoInc('movimentacaoitem_idmovimentacaoitem_seq')]
  [Controllers(TControllermovimentacaoitem)]
  Tmovimentacaoitem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDMOVIMENTACAOITEM', True, True, False, PrimaryKey)]
    idmovimentacaoitem: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('IDMOVIMENTACAO', True, True, False, NotNull)]
    idmovimentacao: Integer;

    [DBField('IDVOLUME', True, True, False, NotNull)]
    idvolume: Integer;

    [DBField('IDENDERECOORIGEM', True, True, False, NotNull)]
    idenderecoorigem: Integer;

    [DBField('IDENDERECODESTINO', True, True, False, NotNull)]
    idenderecodestino: Integer;

    [DBField('DATAINICIO', True, True, False, Null)]
    datainicio: TDateTime;

    [DBField('DATAFIM', True, True, False, Null)]
    datafim: TDateTime;

    [DBField('DATAVALIDADE', True, True, False, Null)]
    datavalidade: TDateTime;

    [DBField('QUANTIDADE', True, True, False, Null)]
    quantidade: Integer;

    [DBField('LOTE', True, True, False, Null)]
    lote: String;

    [DBField('NUMSERIE', True, True, False, Null)]
    numserie: String;

    [DBField('CP_PRODUTOS', True, True, False, NotNull)]
    cp_produtos: Integer;


  end;

implementation

{ Tmovimentacaoitem }

initialization

RegisterClass(Tmovimentacaoitem);

end.

