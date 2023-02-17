unit Resources.conferenciaitem;

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
  Controller.conferenciaitem;

type

  [Resource('conferenciaitem')]
  [Table('"Expedicao".conferenciaitem')]
  [AutoInc('conferenciaitem_idconferenciaitem_seq')]
  [Controllers(TControllerconferenciaitem)]
  Tconferenciaitem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCONFERENCIAITEM', True, True, False, PrimaryKey)]
    idconferenciaitem: Integer;

    [DBField('IDCONFERENCIA', True, True, False, NotNull)]
    idconferencia: Integer;

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

{ Tconferenciaitem }

initialization

RegisterClass(Tconferenciaitem);

end.

