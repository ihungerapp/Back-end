unit Resources.precificacao;

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
  Controller.precificacao;

type

  [Resource('precificacao')]
  [Table('precificacao')]
  [AutoInc('precificacao_id_precificacao_seq')]
  [Controllers(TControllerprecificacao)]
  Tprecificacao = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_PRECIFICACAO', True, True, False, PrimaryKey)]
    id_precificacao: Integer;

    [DBField('TIPO', True, True, False, NotNull)]
    tipo: String;

    [DBField('GRUPO', True, True, False, NotNull)]
    grupo: String;

    [DBField('QTDE_MAX_SELECAO', True, True, False, NotNull)]
    qtde_max_selecao: Integer;
  end;

implementation

{ Tprecificacao }

initialization

RegisterClass(Tprecificacao);

end.

