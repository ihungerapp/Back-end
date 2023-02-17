unit Resources.tipoestacao;

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
  Controller.tipoestacao;

type

  [Resource('tipoestacao')]
  [Table('"Cadastros WMS".tipoestacao')]
  [AutoInc('tipoestacao_idtipoestacao_seq')]
  [Controllers(TControllertipoestacao)]
  Ttipoestacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOESTACAO', True, True, False, PrimaryKey)]
    idtipoestacao: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipoestacao }

initialization

RegisterClass(Ttipoestacao);

end.

