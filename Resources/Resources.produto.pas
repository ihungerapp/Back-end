unit Resources.produto;

interface

uses
  System.Classes, 
  System.Generics.Collections, 
  System.SysUtils,
  Web.HTTPApp,
  Server.Attributes, 
  Server.ResourceBaseClass, 
  Server.Message,
  Server.MessageList, 
  Server.Connection,
  Controller.produto;

type

  [Resource('produto')]
  [Table('"CADPROD"')]
  [AutoInc('cadprod_sequence')]
  [Controllers(TControllerproduto)]
  Tproduto = class(TResourceBaseClass)
  protected
  public
    [DBField('"CODPROD"', True, True, False, PrimaryKey)]
    id_produto: Integer;

    [DBField('"DESCRICAO"', True, True, False, NotNull)]
    descricao: String;

    [DBField('"COMPLEMENTO"', True, True, False, Null)]
    complemento: String;

    [DBField('"VALORF"', True, True, False, NotNull)]
    valor_inicial: Currency;

    [DBField('"VALOR_PROMOCAO"', True, True, False, NotNull)]
    valor_promocao: Currency;

    [DBField('"PROMOCAO_DO_DIA"', True, True, False, NotNull)]
    promocao_do_dia: Boolean;

    [DBField('"CODGRUPO"', True, True, False, NotNull)]
    id_grupo: Integer;

    [DBField('"IMAGEM"', True, True, False, Null)]
    imagem: TBytea;

    [DBField('"EXIBIR_HUNGER_APP"', True, True, False, NotNull)]
    exibir_app: Boolean;
  end;

implementation

{ Tproduto }

initialization

RegisterClass(Tproduto);

end.

