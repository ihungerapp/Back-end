unit Resources.produtosembalagem;

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
  Controller.produtosembalagem;

type

  [Resource('produtosembalagem')]
  [Table('"Cadastros clientes".produtosembalagem')]
  [AutoInc('produtosembalagem_cp_produtosembalagem_seq')]
  [Controllers(TControllerprodutosembalagem)]
  Tprodutosembalagem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDEMBALAGEM', True, True, False, NotNull)]
    idembalagem: String;

    [DBField('CP_PRODUTOS', True, True, False, Null)]
    cp_produtos: Integer;

    [DBField('CODBARRA', True, True, False, Null)]
    codbarra: String;

    [DBField('EMBALAGEM', True, True, False, Null)]
    embalagem: String;

    [DBField('QUANTIDADE', True, True, False, Null)]
    quantidade: Currency;

    [DBField('SITUACAO', True, True, False, Null)]
    situacao: Integer;

    [DBField('IDTIPOEMBALAGEM', True, True, False, Null)]
    idtipoembalagem: String;

    [DBField('CP_PRODUTOSEMBALAGEM', True, True, False, PrimaryKey)]
    cp_produtosembalagem: Integer;

    [DBField('CP_TIPOEMBALAGEM', True, True, False, Null)]
    cp_tipoembalagem: Integer;

    [DBField('LARGURA', True, True, False, Null)]
    largura: Currency;

    [DBField('ALTURA', True, True, False, Null)]
    altura: Currency;

    [DBField('PROFUNDIDADE', True, True, False, Null)]
    profundidade: Currency;

    [DBField('M3', True, True, False, Null)]
    m3: Currency;


  end;

implementation

{ Tprodutosembalagem }

initialization

RegisterClass(Tprodutosembalagem);

end.

