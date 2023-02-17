unit Resources.movimentacao;

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
  Controller.movimentacao;

type

  [Resource('movimentacao')]
  [Table('"Movimentacao".movimentacao')]
  [AutoInc('movimentacao_idmovimentacao_seq')]
  [Controllers(TControllermovimentacao)]
  Tmovimentacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDMOVIMENTACAO', True, True, False, PrimaryKey)]
    idmovimentacao: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('IDTIPOMOVIMENTACAO', True, True, False, NotNull)]
    idtipomovimentacao: Integer;

    [DBField('IDLISTAMOVIMENTACAO', True, True, False, NotNull)]
    idlistamovimentacao: Integer;

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('DATAINICIO', True, True, False, Null)]
    datainicio: TDateTime;

    [DBField('DATAFIM', True, True, False, Null)]
    datafim: TDateTime;


  end;

implementation

{ Tmovimentacao }

initialization

RegisterClass(Tmovimentacao);

end.

