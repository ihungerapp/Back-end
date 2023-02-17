unit Resources.bancodados;

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
  Controller.bancodados;

type

  [Resource('bancodados')]
  [Table('"Cadastros WMS".bancodados')]
  [AutoInc('bancodados_idbd_seq')]
  [Controllers(TControllerbancodados)]
  Tbancodados = class(TResourceBaseClass)
  protected
  public
    [DBField('IDBD', True, True, False, PrimaryKey)]
    idbd: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Tbancodados }

initialization

RegisterClass(Tbancodados);

end.

