unit Resources.inventario;

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
  Controller.inventario;

type

  [Resource('inventario')]
  [Table('"Inventario".inventario')]
  [AutoInc('inventario_idinventario_seq')]
  [Controllers(TControllerinventario)]
  Tinventario = class(TResourceBaseClass)
  protected
  public
    [DBField('IDINVENTARIO', True, True, False, PrimaryKey)]
    idinventario: Integer;

    [DBField('IDTIPOINVENTARIO', True, True, False, NotNull)]
    idtipoinventario: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('IDLISTAINVENTARIO', True, True, False, NotNull)]
    idlistainventario: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('STATUS', True, True, False, Null)]
    status: String;

    [DBField('CP_FILIAL', True, True, False, NotNull)]
    cp_filial: Integer;


  end;

implementation

{ Tinventario }

initialization

RegisterClass(Tinventario);

end.

