unit Resources.transportadoras;

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
  Controller.transportadoras;

type

  [Resource('transportadoras')]
  [Table('"Cadastros clientes".transportadoras')]
  [AutoInc('transportadoras_cp_transportadoras_seq')]
  [Controllers(TControllertransportadoras)]
  Ttransportadoras = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTRANSPORTADORA', True, True, False, NotNull)]
    idtransportadora: String;

    [DBField('IDTIPOTRANSPORTADORA', True, True, False, Null)]
    idtipotransportadora: Integer;

    [DBField('NOMETRANSPORTADORA', True, True, False, Null)]
    nometransportadora: String;

    [DBField('NOMEFANTASIA', True, True, False, Null)]
    nomefantasia: String;

    [DBField('CPFCNPJ', True, True, False, Null)]
    cpfcnpj: String;

    [DBField('IE', True, True, False, Null)]
    ie: String;

    [DBField('ESTADO', True, True, False, Null)]
    estado: String;

    [DBField('CODCIDADE', True, True, False, NotNull)]
    codcidade: Integer;

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

    [DBField('CONTATO', True, True, False, Null)]
    contato: String;

    [DBField('DATACADASTRO', True, True, False, Null)]
    datacadastro: TDateTime;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('OBS', True, True, False, Null)]
    obs: String;

    [DBField('EMAIL', True, True, False, Null)]
    email: String;

    [DBField('CP_TRANSPORTADORAS', True, True, False, PrimaryKey)]
    cp_transportadoras: Integer;


  end;

implementation

{ Ttransportadoras }

initialization

RegisterClass(Ttransportadoras);

end.

