unit Resources.licenca;

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
  Controller.licenca;

type

  [Resource('licenca')]
  [Table('"Parametrizacao".licenca')]
  [AutoInc('licenca_idlicenca_seq')]
  [Controllers(TControllerlicenca)]
  Tlicenca = class(TResourceBaseClass)
  protected
  public
    [DBField('IDLICENCA', True, True, False, NotNull)]
    idlicenca: Integer;

    [DBField('CLIENTE', True, True, False, Null)]
    cliente: String;

    [DBField('QTD_USUARIOS', True, True, False, Null)]
    qtd_usuarios: Integer;

    [DBField('DATALIBERACAO', True, True, False, Null)]
    dataliberacao: TDateTime;

    [DBField('CHAVE', True, True, False, Null)]
    chave: String;


  end;

implementation

{ Tlicenca }

initialization

RegisterClass(Tlicenca);

end.

