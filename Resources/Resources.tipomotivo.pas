unit Resources.tipomotivo;

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
  Controller.tipomotivo;

type

  [Resource('tipomotivo')]
  [Table('"Cadastros WMS".tipomotivo')]
  [AutoInc('tipomotivo_idtipomotivo_seq')]
  [Controllers(TControllertipomotivo)]
  Ttipomotivo = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOMOTIVO', True, True, False, PrimaryKey)]
    idtipomotivo: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipomotivo }

initialization

RegisterClass(Ttipomotivo);

end.

