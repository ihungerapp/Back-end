unit Resources.embarque;

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
  Controller.embarque;

type

  [Resource('embarque')]
  [Table('"Expedicao".embarque')]
  [AutoInc('embarque_idembarque_seq')]
  [Controllers(TControllerembarque)]
  Tembarque = class(TResourceBaseClass)
  protected
  public
    [DBField('IDEMBARQUE', True, True, False, PrimaryKey)]
    idembarque: Integer;

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

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('STATUS', True, True, False, Null)]
    status: String;


  end;

implementation

{ Tembarque }

initialization

RegisterClass(Tembarque);

end.

