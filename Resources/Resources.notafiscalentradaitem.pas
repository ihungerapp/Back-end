unit Resources.notafiscalentradaitem;

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
  Controller.notafiscalentradaitem;

type

  [Resource('notafiscalentradaitem')]
  [Table('"Recebimento".notafiscalentradaitem')]
  [AutoInc('notafiscalentradaitem_idnotafiscalentradaitem_seq')]
  [Controllers(TControllernotafiscalentradaitem)]
  Tnotafiscalentradaitem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDNOTAFISCALENTRADAITEM', True, True, False, PrimaryKey)]
    idnotafiscalentradaitem: Integer;

    [DBField('CP_NOTAFISCALENTRADA', True, True, False, NotNull)]
    cp_notafiscalentrada: Integer;

    [DBField('CP_PRODUTOS', True, True, False, NotNull)]
    cp_produtos: Integer;

    [DBField('IDTIPOENTRADA', True, True, False, NotNull)]
    idtipoentrada: Integer;

    [DBField('CP_FORNECEDORES', True, True, False, NotNull)]
    cp_fornecedores: Integer;

    [DBField('QUANTIDADE', True, True, False, Null)]
    quantidade: Integer;

    [DBField('VALUNITARIO', True, True, False, Null)]
    valunitario: Currency;

    [DBField('ITEM', True, True, False, Null)]
    item: String;

    [DBField('VALIDADE', True, True, False, Null)]
    validade: TDateTime;

    [DBField('FABRICACAO', True, True, False, Null)]
    fabricacao: TDateTime;

    [DBField('LOTE', True, True, False, Null)]
    lote: String;

    [DBField('NUMERO_SERIE', True, True, False, Null)]
    numero_serie: String;


  end;

implementation

{ Tnotafiscalentradaitem }

initialization

RegisterClass(Tnotafiscalentradaitem);

end.

