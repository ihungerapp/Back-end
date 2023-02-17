unit Resources.conferencia;

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
  Controller.conferencia;

type

  [Resource('conferencia')]
  [Table('"Expedicao".conferencia')]
  [AutoInc('conferencia_idconferencia_seq')]
  [Controllers(TControllerconferencia)]
  Tconferencia = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCONFERENCIA', True, True, False, PrimaryKey)]
    idconferencia: Integer;

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

{ Tconferencia }

initialization

RegisterClass(Tconferencia);

end.

