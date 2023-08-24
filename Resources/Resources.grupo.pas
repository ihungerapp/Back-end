unit Resources.grupo;

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
  Controller.grupo;

type

  [Resource('grupo')]
  [Table('"CADGRUPO"')]
  [AutoInc('grupo_id_grupo_seq')]
  [Controllers(TControllergrupo)]
  Tgrupo = class(TResourceBaseClass)
  protected
  public
    [DBField('"CODGRUPO"', True, True, False, PrimaryKey)]
    id_grupo: Integer;

    [DBField('"DESCRICAO"', True, True, False, NotNull)]
    descricao: String;


  end;

implementation

{ Tgrupo }

initialization

RegisterClass(Tgrupo);

end.

