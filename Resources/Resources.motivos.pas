unit Resources.motivos;

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
  Controller.motivos;

type

  [Resource('motivos')]
  [Table('"Cadastros WMS".motivos')]
  [AutoInc('motivos_idmotivo_seq')]
  [Controllers(TControllermotivos)]
  Tmotivos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDMOTIVO', True, True, False, PrimaryKey)]
    idmotivo: Integer;

    [DBField('IDTIPOMOTIVO', True, True, False, NotNull)]
    idtipomotivo: Integer;

    [DBField('STATUS', True, True, False, Null)]
    status: String;

    [DBField('BLOQESTOQUE', True, True, False, Null)]
    bloqestoque: String;


  end;

implementation

{ Tmotivos }

initialization

RegisterClass(Tmotivos);

end.

