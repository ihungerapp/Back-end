unit Resources.notafiscalentrada;

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
  Controller.notafiscalentrada;

type

  [Resource('notafiscalentrada')]
  [Table('"Recebimento".notafiscalentrada')]
  [AutoInc('notafiscalentrada_cp_notafiscalentrada_seq')]
  [Controllers(TControllernotafiscalentrada)]
  Tnotafiscalentrada = class(TResourceBaseClass)
  protected
  public
    [DBField('IDNOTAFISCAL', True, True, False, NotNull)]
    idnotafiscal: String;

    [DBField('CP_FILIAIS', True, True, False, NotNull)]
    cp_filiais: Integer;

    [DBField('CP_FORNECEDORES', True, True, False, NotNull)]
    cp_fornecedores: Integer;

    [DBField('IDTIPOENTRADA', True, True, False, NotNull)]
    idtipoentrada: Integer;

    [DBField('IDCARGA', True, True, False, NotNull)]
    idcarga: Integer;

    [DBField('DATAEMISSAO', True, True, False, Null)]
    dataemissao: TDateTime;

    [DBField('QUANTIDADE', True, True, False, Null)]
    quantidade: Integer;

    [DBField('NUMERONOTAFISCAL', True, True, False, Null)]
    numeronotafiscal: String;

    [DBField('SERIE', True, True, False, Null)]
    serie: String;

    [DBField('QUANTIDADEVOLUME', True, True, False, Null)]
    quantidadevolume: Integer;

    [DBField('VALTOTALPRODUTO', True, True, False, Null)]
    valtotalproduto: Currency;

    [DBField('VALTOTALNOTA', True, True, False, Null)]
    valtotalnota: Currency;

    [DBField('PESOBRUTO', True, True, False, Null)]
    pesobruto: Currency;

    [DBField('PESOLIQUIDO', True, True, False, Null)]
    pesoliquido: Currency;

    [DBField('CP_NOTAFISCALENTRADA', True, True, False, PrimaryKey)]
    cp_notafiscalentrada: Integer;

    [DBField('SITUACAO', True, True, False, Null)]
    situacao: String;

    [DBField('QTDVOLUMECONF', True, True, False, Null)]
    qtdvolumeconf: Integer;

  end;

implementation

{ Tnotafiscalentrada }

initialization

RegisterClass(Tnotafiscalentrada);

end.

