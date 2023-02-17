unit Resources.produtos;

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
  Controller.produtos;

type

  [Resource('produtos')]
  [Table('"Cadastros clientes".produtos')]
  [AutoInc('produtos_cp_produtos_seq')]
  [Controllers(TControllerprodutos)]
  Tprodutos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPRODUTO', True, True, False, NotNull)]
    idproduto: String;

    [DBField('CP_FORNECEDORES', True, True, False, NotNull)]
    cp_fornecedores: Integer;

    [DBField('CODREFERENCIA', True, True, False, NotNull)]
    codreferencia: Integer;

    [DBField('IDDEPOSITO', True, True, False, NotNull)]
    iddeposito: Integer;

    [DBField('CP_GRUPOS', True, True, False, NotNull)]
    cp_grupos: Integer;

    [DBField('CP_SUBGRUPOS', True, True, False, NotNull)]
    cp_subgrupos: Integer;

    [DBField('NOME', True, True, False, NotNull)]
    nome: String;

    [DBField('UNIDADEPADRAO', True, True, False, Null)]
    unidadepadrao: String;

    [DBField('ESTOQUEMINIMO', True, True, False, NotNull)]
    estoqueminimo: Currency;

    [DBField('ESTOQUEMAXIMO', True, True, False, NotNull)]
    estoquemaximo: Currency;

    [DBField('CONTROLAVALIDADE', True, True, False, Null)]
    controlavalidade: String;

    [DBField('CONTROLALOTE', True, True, False, Null)]
    controlalote: String;

    [DBField('CONTROLANUMSERIE', True, True, False, Null)]
    controlanumserie: String;

    [DBField('PESOBRUTO', True, True, False, Null)]
    pesobruto: Integer;

    [DBField('PESOLIQUIDO', True, True, False, Null)]
    pesoliquido: Integer;

    [DBField('SHELFLIFE', True, True, False, Null)]
    shelflife: String;

    [DBField('CP_PRODUTOS', True, True, False, PrimaryKey)]
    cp_produtos: Integer;

    [DBField('IDENDERECO', True, True, False, Null)]
    idendereco: Integer;


  end;

implementation

{ Tprodutos }

initialization

RegisterClass(Tprodutos);

end.

