unit Resources.separacao;

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
  Controller.separacao;

type

  [Resource('separacao')]
  [Table('"Expedicao".separacao')]
  [AutoInc('separacao_idseparacao_seq')]
  [Controllers(TControllerseparacao)]
  Tseparacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDSEPARACAO', True, True, False, PrimaryKey)]
    idseparacao: Integer;

    [DBField('CP_PEDIDOS', True, True, False, NotNull)]
    cp_pedidos: Integer;

    [DBField('CP_CARREGAMENTO', True, True, False, NotNull)]
    cp_carregamento: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('DATAINICIO', True, True, False, Null)]
    datainicio: TDateTime;

    [DBField('DATATERMINO', True, True, False, Null)]
    datatermino: TDateTime;

    [DBField('STATUS', True, True, False, Null)]
    status: String;


  end;

implementation

{ Tseparacao }

initialization

RegisterClass(Tseparacao);

end.

