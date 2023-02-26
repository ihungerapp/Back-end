unit Resources.cidade;

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
  Controller.cidade;

type

  [Resource('cidade')]
  [Table('"Cadastros".cidade')]
  [AutoInc('cidade_id_cidade_seq')]
  [Controllers(TControllercidade)]
  Tcidade = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_CIDADE', True, True, False, PrimaryKey)]
    id_cidade: Integer;

    [DBField('CODIGO_IBGE', True, True, False, NotNull)]
    codigo_ibge: String;

    [DBField('NOME', True, True, False, NotNull)]
    nome: String;

    [DBField('UF', True, True, False, NotNull)]
    uf: String;


  end;

implementation

{ Tcidade }

initialization

RegisterClass(Tcidade);

end.

