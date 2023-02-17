unit Resources.tipotransportadora;

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
  Controller.tipotransportadora;

type

  [Resource('tipotransportadora')]
  [Table('"Cadastros WMS".tipotransportadora')]
  [AutoInc('tipotransportadora_idtipotransportadora_seq')]
  [Controllers(TControllertipotransportadora)]
  Ttipotransportadora = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOTRANSPORTADORA', True, True, False, PrimaryKey)]
    idtipotransportadora: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipotransportadora }

initialization

RegisterClass(Ttipotransportadora);

end.

