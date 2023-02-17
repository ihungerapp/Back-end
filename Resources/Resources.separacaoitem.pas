unit Resources.separacaoitem;

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
  Controller.separacaoitem;

type

  [Resource('separacaoitem')]
  [Table('"Expedicao".separacaoitem')]
  [AutoInc('separacaoitem_idseparacaoitem_seq')]
  [Controllers(TControllerseparacaoitem)]
  Tseparacaoitem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDSEPARACAOITEM', True, True, False, PrimaryKey)]
    idseparacaoitem: Integer;

    [DBField('IDSEPARACAO', True, True, False, NotNull)]
    idseparacao: Integer;

    [DBField('CP_PRODUTOS', True, True, False, NotNull)]
    cp_produtos: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('DATAINICIO', True, True, False, Null)]
    datainicio: TDateTime;

    [DBField('DATATERMINO', True, True, False, Null)]
    datatermino: TDateTime;

    [DBField('DATAVALIDADE', True, True, False, Null)]
    datavalidade: TDateTime;

    [DBField('QUANTIDADE', True, True, False, NotNull)]
    quantidade: Integer;

    [DBField('QTDCORTE', True, True, False, Null)]
    qtdcorte: Integer;

    [DBField('LOTE', True, True, False, Null)]
    lote: String;

    [DBField('NUMSERIE', True, True, False, Null)]
    numserie: String;

    [DBField('ITEM', True, True, False, Null)]
    item: String;

    [DBField('IDMOTIVO', True, True, False, Null)]
    idmotivo: Integer;

    [DBField('IDENDERECO', True, True, False, NotNull)]
    idendereco: Integer;

    [DBField('IDVOLUME', True, True, False, Null)]
    idvolume: Integer;


  end;

implementation

{ Tseparacaoitem }

initialization

RegisterClass(Tseparacaoitem);

end.

