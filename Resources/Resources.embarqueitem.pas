unit Resources.embarqueitem;

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
  Controller.embarqueitem;

type

  [Resource('embarqueitem')]
  [Table('"Expedicao".embarqueitem')]
  [AutoInc('embarqueitem_idembarqueitem_seq')]
  [Controllers(TControllerembarqueitem)]
  Tembarqueitem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDEMBARQUEITEM', True, True, False, PrimaryKey)]
    idembarqueitem: Integer;

    [DBField('IDEMBARQUE', True, True, False, NotNull)]
    idembarque: Integer;

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

    [DBField('IDVOLUME', True, True, False, Null)]
    idvolume: Integer;


  end;

implementation

{ Tembarqueitem }

initialization

RegisterClass(Tembarqueitem);

end.

