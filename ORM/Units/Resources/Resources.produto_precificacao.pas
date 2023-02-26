unit Resources.produto_precificacao;

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
  Controller.produto_precificacao;

type

  [Resource('produto_precificacao')]
  [Table('"Cadastros".produto_precificacao')]
  [AutoInc('produto_precificacao_id_produto_precificacao_seq')]
  [Controllers(TControllerproduto_precificacao)]
  Tproduto_precificacao = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_PRODUTO_PRECIFICACAO', True, True, False, PrimaryKey)]
    id_produto_precificacao: Integer;

    [DBField('ID_PRECIFICACAO', True, True, False, NotNull)]
    id_precificacao: Integer;

    [DBField('ID_PRODUTO', True, True, False, NotNull)]
    id_produto: Integer;


  end;

implementation

{ Tproduto_precificacao }

initialization

RegisterClass(Tproduto_precificacao);

end.

