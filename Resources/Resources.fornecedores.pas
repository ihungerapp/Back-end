unit Resources.fornecedores;

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
  Controller.fornecedores;

type

  [Resource('fornecedores')]
  [Table('"Cadastros clientes".fornecedores')]
  [AutoInc('fornecedores_cp_fornecedores_seq')]
  [Controllers(TControllerfornecedores)]
  Tfornecedores = class(TResourceBaseClass)
  protected
  public
    [DBField('IDFORNECEDOR', True, True, False, NotNull)]
    idfornecedor: String;

    [DBField('IDATIVIDADE', True, True, False, Null)]
    idatividade: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('NOMEFANTASIA', True, True, False, Null)]
    nomefantasia: String;

    [DBField('CPF', True, True, False, Null)]
    cpf: String;

    [DBField('IE', True, True, False, Null)]
    ie: String;

    [DBField('ESTADO', True, True, False, Null)]
    estado: String;

    [DBField('CODCIDADE', True, True, False, Null)]
    codcidade: String;

    [DBField('BAIRRO', True, True, False, Null)]
    bairro: String;

    [DBField('ENDERECO', True, True, False, Null)]
    endereco: String;

    [DBField('NUMERO', True, True, False, Null)]
    numero: Integer;

    [DBField('TELEFONE', True, True, False, Null)]
    telefone: String;

    [DBField('CP_FORNECEDORES', True, True, False, PrimaryKey)]
    cp_fornecedores: Integer;


  end;

implementation

{ Tfornecedores }

initialization

RegisterClass(Tfornecedores);

end.

