unit Resources.conexaocliente;

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
  Controller.conexaocliente;

type

  [Resource('conexaocliente')]
  [Table('"Parametrizacao".conexaocliente')]
  [AutoInc('conexaocliente_idconexao_seq')]
  [Controllers(TControllerconexaocliente)]
  Tconexaocliente = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCONEXAO', True, True, False, PrimaryKey)]
    idconexao: Integer;

    [DBField('IDBD', True, True, False, Null)]
    idbd: Integer;

    [DBField('NOMEBD', True, True, False, Null)]
    nomebd: String;

    [DBField('SERVIDOR', True, True, False, Null)]
    servidor: String;

    [DBField('USUARIO', True, True, False, Null)]
    usuario: String;

    [DBField('SENHA', True, True, False, Null)]
    senha: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: Integer;

    [DBField('IDERP', True, True, False, Null)]
    iderp: Integer;

    [DBField('INT_FILIAIS', True, True, False, Null)]
    int_filiais: String;

    [DBField('INT_CLIENTES', True, True, False, Null)]
    int_clientes: String;

    [DBField('INT_CLIENTESREGIOES', True, True, False, Null)]
    int_clientesregioes: String;

    [DBField('INT_CLIENTESROTAS', True, True, False, Null)]
    int_clientesrotas: String;

    [DBField('INT_FORNECEDORES', True, True, False, Null)]
    int_fornecedores: String;

    [DBField('INT_GRUPOS', True, True, False, Null)]
    int_grupos: String;

    [DBField('INT_MOTORISTA', True, True, False, Null)]
    int_motorista: String;

    [DBField('INT_PRODUTOS', True, True, False, Null)]
    int_produtos: String;

    [DBField('INT_PRODUTOSEMBALAGEM', True, True, False, Null)]
    int_produtosembalagem: String;

    [DBField('INT_SUBGRUPOS', True, True, False, Null)]
    int_subgrupos: String;

    [DBField('INT_TRANSPORTADORAS', True, True, False, Null)]
    int_transportadoras: String;

    [DBField('INT_TRANSPORTADORASVEICULOS', True, True, False, Null)]
    int_transportadorasveiculos: String;

    [DBField('INT_VENDEDORES', True, True, False, Null)]
    int_vendedores: String;

    [DBField('INT_CARGA', True, True, False, Null)]
    int_carga: String;

    [DBField('INT_NFENTRADA', True, True, False, Null)]
    int_nfentrada: String;

    [DBField('INT_ITENSNFENTRADA', True, True, False, Null)]
    int_itensnfentrada: String;

    [DBField('INT_CARREGAMENTO', True, True, False, Null)]
    int_carregamento: String;

    [DBField('INT_PEDIDOS', True, True, False, Null)]
    int_pedidos: String;

    [DBField('INT_ITENSPEDIDOS', True, True, False, Null)]
    int_itenspedidos: String;


  end;

implementation

{ Tconexaocliente }

initialization

RegisterClass(Tconexaocliente);

end.

