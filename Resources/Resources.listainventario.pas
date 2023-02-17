unit Resources.listainventario;

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
  Controller.listainventario;

type

  [Resource('listainventario')]
  [Table('"Inventario".listainventario')]
  [AutoInc('listainventario_idlistainventario_seq')]
  [Controllers(TControllerlistainventario)]
  Tlistainventario = class(TResourceBaseClass)
  protected
  public
    [DBField('IDLISTAINVENTARIO', True, True, False, PrimaryKey)]
    idlistainventario: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('STATUS', True, True, False, Null)]
    status: String;


  end;

implementation

{ Tlistainventario }

initialization

RegisterClass(Tlistainventario);

end.

