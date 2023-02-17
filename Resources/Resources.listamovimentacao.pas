unit Resources.listamovimentacao;

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
  Controller.listamovimentacao;

type

  [Resource('listamovimentacao')]
  [Table('"Movimentacao".listamovimentacao')]
  [AutoInc('listamovimentacao_idlistamovimentacao_seq')]
  [Controllers(TControllerlistamovimentacao)]
  Tlistamovimentacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDLISTAMOVIMENTACAO', True, True, False, PrimaryKey)]
    idlistamovimentacao: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('STATUS', True, True, False, Null)]
    status: String;


  end;

implementation

{ Tlistamovimentacao }

initialization

RegisterClass(Tlistamovimentacao);

end.

