unit Resources.tipoendereco;

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
  Controller.tipoendereco;

type

  [Resource('tipoendereco')]
  [Table('"Cadastros WMS".tipoendereco')]
  [AutoInc('tipoendereco_idtipoendereco_seq')]
  [Controllers(TControllertipoendereco)]
  Ttipoendereco = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOENDERECO', True, True, False, PrimaryKey)]
    idtipoendereco: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipoendereco }

initialization

RegisterClass(Ttipoendereco);

end.

