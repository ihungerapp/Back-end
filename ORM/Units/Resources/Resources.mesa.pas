unit Resources.mesa;

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
  Controller.mesa;

type

  [Resource('mesa')]
  [Table('"Cadastros".mesa')]
  [AutoInc('mesa_id_mesa_seq')]
  [Controllers(TControllermesa)]
  Tmesa = class(TResourceBaseClass)
  protected
  public
    [DBField('ID_MESA', True, True, False, PrimaryKey)]
    id_mesa: Integer;

    [DBField('ID_MESA_RMCOMANDA', True, True, False, NotNull)]
    id_mesa_rmcomanda: Integer;

    [DBField('DESCRICAO', True, True, False, NotNull)]
    descricao: String;

    [DBField('MESA_UUID', True, True, False, NotNull)]
    mesa_uuid: TGUID;


  end;

implementation

{ Tmesa }

initialization

RegisterClass(Tmesa);

end.

