unit Resources.tipodeposito;

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
  Controller.tipodeposito;

type

  [Resource('tipodeposito')]
  [Table('"Cadastros WMS".tipodeposito')]
  [AutoInc('tipodeposito_idtipodeposito_seq')]
  [Controllers(TControllertipodeposito)]
  Ttipodeposito = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPODEPOSITO', True, True, False, PrimaryKey)]
    idtipodeposito: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipodeposito }

initialization

RegisterClass(Ttipodeposito);

end.

