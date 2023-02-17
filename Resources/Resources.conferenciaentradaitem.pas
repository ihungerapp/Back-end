unit Resources.conferenciaentradaitem;

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
  Controller.conferenciaentradaitem;

type

  [Resource('conferenciaentradaitem')]
  [Table('"Recebimento".conferenciaentradaitem')]
  [AutoInc('conferenciaentradaitem_idcargaitem_seq')]
  [Controllers(TControllerconferenciaentradaitem)]
  Tconferenciaentradaitem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCARGA', True, True, False, Null)]
    idcarga: Integer;

    [DBField('CP_NOTAFISCALENTRADA', True, True, False, Null)]
    cp_notafiscalentrada: Integer;

    [DBField('CP_PRODUTOS', True, True, False, Null)]
    cp_produtos: Integer;

    [DBField('ITEM', True, True, False, Null)]
    item: String;

    [DBField('IDCONFERENTE', True, True, False, Null)]
    idconferente: String;

    [DBField('DATAINICIOCONF', True, True, False, Null)]
    datainicioconf: TDateTime;

    [DBField('DATAFINALCONF', True, True, False, Null)]
    datafinalconf: TDateTime;

    [DBField('QTDCONFERIDA', True, True, False, Null)]
    qtdconferida: Currency;

    [DBField('LOTE', True, True, False, Null)]
    lote: String;

    [DBField('DATAVALIDADE', True, True, False, Null)]
    datavalidade: TDateTime;

    [DBField('NUMSERIE', True, True, False, Null)]
    numserie: String;

    [DBField('IDVOLUME', True, True, False, Null)]
    idvolume: Integer;

    [DBField('IDCARGAITEM', True, True, False, PrimaryKey)]
    idcargaitem: Integer;


  end;

implementation

{ Tconferenciaentradaitem }

initialization

RegisterClass(Tconferenciaentradaitem);

end.

