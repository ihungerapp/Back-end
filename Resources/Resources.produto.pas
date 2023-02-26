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
  [Table('"Cadastros".produto')]
  [AutoInc('produto_id_produto_seq')]
  [Controllers(TControllerproduto)]
  Tproduto = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_PRODUTO', True, True, False, PrimaryKey)]
    id_produto: Integer;

    [DBField('DESCRICAO', True, True, False, NotNull)]
    descricao: String;

    [DBField('COMPLEMENTO', True, True, False, Null)]
    complemento: String;

    [DBField('VALOR_INICIAL', True, True, False, NotNull)]
    valor_inicial: Currency;

    [DBField('VALOR_PROMOCAO', True, True, False, NotNull)]
    valor_promocao: Currency;

    [DBField('ID_GRUPO', True, True, False, NotNull)]
    id_grupo: Integer;


  end;

implementation

{ Tproduto }

initialization

RegisterClass(Tproduto);

end.

