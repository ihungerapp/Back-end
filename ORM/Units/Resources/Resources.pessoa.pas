unit Resources.pessoa;

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
  Controller.pessoa;

type

  [Resource('pessoa')]
  [Table('"Cadastros".pessoa')]
  [AutoInc('pessoa_id_pessoa_seq')]
  [Controllers(TControllerpessoa)]
  Tpessoa = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_PESSOA', True, True, False, NotNull)]
    id_pessoa: Integer;

    [DBField('NOME', True, True, False, NotNull)]
    nome: String;

    [DBField('CPF_CNPJ', True, True, False, NotNull)]
    cpf_cnpj: String;

    [DBField('LOGRADOURO', True, True, False, NotNull)]
    logradouro: String;

    [DBField('NUMERO', True, True, False, NotNull)]
    numero: String;

    [DBField('COMPLEMENTO', True, True, False, Null)]
    complemento: String;

    [DBField('BAIRRO', True, True, False, NotNull)]
    bairro: String;

    [DBField('CEP', True, True, False, NotNull)]
    cep: String;

    [DBField('ID_CIDADE', True, True, False, NotNull)]
    id_cidade: Integer;

    [DBField('ID_USUARIO', True, True, False, PrimaryKey)]
    id_usuario: Integer;


  end;

implementation

{ Tpessoa }

initialization

RegisterClass(Tpessoa);

end.

