unit Resources.filiais;

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
  Controller.filiais;

type

  [Resource('filiais')]
  [Table('"Cadastros clientes".filiais')]
  [AutoInc('filiais_cp_filiais_seq')]
  [Controllers(TControllerfiliais)]
  Tfiliais = class(TResourceBaseClass)
  protected
  public
    [DBField('IDFILIAL', True, True, False, NotNull)]
    idfilial: String;

    [DBField('NOMFANTASIA', True, True, False, Null)]
    nomfantasia: String;

    [DBField('CNPJ', True, True, False, Null)]
    cnpj: String;

    [DBField('IE', True, True, False, Null)]
    ie: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('TELEFONE', True, True, False, Null)]
    telefone: String;

    [DBField('ESTADO', True, True, False, Null)]
    estado: String;

    [DBField('CODCIDADE', True, True, False, NotNull)]
    codcidade: Integer;

    [DBField('NOMECIDADE', True, True, False, Null)]
    nomecidade: String;

    [DBField('BAIRRO', True, True, False, Null)]
    bairro: String;

    [DBField('ENDERECO', True, True, False, Null)]
    endereco: String;

    [DBField('NUMERO', True, True, False, Null)]
    numero: Integer;

    [DBField('CEP', True, True, False, Null)]
    cep: String;

    [DBField('CP_FILIAIS', True, True, False, PrimaryKey)]
    cp_filiais: Integer;


  end;

implementation

{ Tfiliais }

initialization

RegisterClass(Tfiliais);

end.

