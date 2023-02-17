unit Resources.estoquewms;

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
  Controller.estoquewms;

type

  [Resource('estoquewms')]
  [Table('"Estoque".estoquewms')]
  [AutoInc('estoquewms_idestoque_seq')]
  [Controllers(TControllerestoquewms)]
  Testoquewms = class(TResourceBaseClass)
  protected
  public
    [DBField('IDESTOQUE', True, True, False, PrimaryKey)]
    idestoque: Integer;

    [DBField('CP_FILIAIS', True, True, False, NotNull)]
    cp_filiais: Integer;

    [DBField('IDENDERECO', True, True, False, NotNull)]
    idendereco: Integer;

    [DBField('CP_PRODUTOS', True, True, False, NotNull)]
    cp_produtos: Integer;

    [DBField('QTDESTOQUE', True, True, False, NotNull)]
    qtdestoque: Integer;

    [DBField('LOTE', True, True, False, Null)]
    lote: String;

    [DBField('DATAFABRICACAO', True, True, False, Null)]
    datafabricacao: TDateTime;

    [DBField('DATAVALIDADE', True, True, False, Null)]
    datavalidade: TDateTime;

    [DBField('NUMSERIE', True, True, False, Null)]
    numserie: String;

    [DBField('IDVOLUME', True, True, False, Null)]
    idvolume: Integer;


  end;

implementation

{ Testoquewms }

initialization

RegisterClass(Testoquewms);

end.

