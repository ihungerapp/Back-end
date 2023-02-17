unit Resources.clientes;

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
  Controller.clientes;

type

  [Resource('clientes')]
  [Table('"Cadastros clientes".clientes')]
  [AutoInc('clientes_cp_clientes_seq')]
  [Controllers(TControllerclientes)]
  Tclientes = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCLIENTE', True, True, False, NotNull)]
    idcliente: String;

    [DBField('CP_CLIENTESROTAS', True, True, False, NotNull)]
    cp_clientesrotas: Integer;

    [DBField('CPFCNPJ', True, True, False, Null)]
    cpfcnpj: String;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('IE', True, True, False, Null)]
    ie: String;

    [DBField('CODCIDADE', True, True, False, Null)]
    codcidade: Integer;

    [DBField('NOMECIDADE', True, True, False, Null)]
    nomecidade: String;

    [DBField('ENDERECO', True, True, False, Null)]
    endereco: String;

    [DBField('COMPLEMENTO', True, True, False, Null)]
    complemento: String;

    [DBField('NUMERO', True, True, False, Null)]
    numero: Integer;

    [DBField('BAIRRO', True, True, False, Null)]
    bairro: String;

    [DBField('CEP', True, True, False, Null)]
    cep: String;

    [DBField('TELEFONE', True, True, False, Null)]
    telefone: String;

    [DBField('EMAIL', True, True, False, Null)]
    email: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('LATITUDE', True, True, False, Null)]
    latitude: String;

    [DBField('LONGETUDE', True, True, False, Null)]
    longetude: String;

    [DBField('SHELFLIFE', True, True, False, Null)]
    shelflife: String;

    [DBField('CP_CLIENTES', True, True, False, PrimaryKey)]
    cp_clientes: Integer;


  end;

implementation

{ Tclientes }

initialization

RegisterClass(Tclientes);

end.

