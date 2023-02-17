unit Resources.tiporotina;

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
  Controller.tiporotina;

type

  [Resource('tiporotina')]
  [Table('"Rotinas e Acessos".tiporotina')]
  [AutoInc('tiporotina_idtiporotina_seq')]
  [Controllers(TControllertiporotina)]
  Ttiporotina = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOROTINA', True, True, False, PrimaryKey)]
    idtiporotina: Integer;

    [DBField('NOMETIPOROTINA', True, True, False, Null)]
    nometiporotina: String;


  end;

implementation

{ Ttiporotina }

initialization

RegisterClass(Ttiporotina);

end.

