unit Resources.estoquedata;

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
  Controller.estoquedata;

type

  [Resource('estoquedata')]
  [Table('"Estoque".estoquedata')]
  [AutoInc('estoquedata_idestoquedata_seq')]
  [Controllers(TControllerestoquedata)]
  Testoquedata = class(TResourceBaseClass)
  protected
  public
    [DBField('IDESTOQUEDATA', True, True, False, PrimaryKey)]
    idestoquedata: Integer;

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


  end;

implementation

{ Testoquedata }

initialization

RegisterClass(Testoquedata);

end.

