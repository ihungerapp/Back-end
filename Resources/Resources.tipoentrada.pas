unit Resources.tipoentrada;

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
  Controller.tipoentrada;

type

  [Resource('tipoentrada')]
  [Table('"Cadastros WMS".tipoentrada')]
  [AutoInc('tipoentrada_idtipoentrada_seq')]
  [Controllers(TControllertipoentrada)]
  Ttipoentrada = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOENTRADA', True, True, False, PrimaryKey)]
    idtipoentrada: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipoentrada }

initialization

RegisterClass(Ttipoentrada);

end.

