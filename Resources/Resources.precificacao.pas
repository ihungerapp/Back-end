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
  [Table('"Cadastros".precificacao')]
  [AutoInc('precificacao_id_precificacao_seq')]
  [Controllers(TControllerprecificacao)]
  Tprecificacao = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_PRECIFICACAO', True, True, False, PrimaryKey)]
    id_precificacao: Integer;

    [DBField('TIPO', True, True, False, NotNull)]
    tipo: String;
  end;

implementation

{ Tprecificacao }

initialization

RegisterClass(Tprecificacao);

end.

