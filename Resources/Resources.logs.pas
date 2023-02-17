unit Resources.logs;

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
  Controller.logs;

type

  [Resource('logs')]
  [Table('"Log".logs')]
  [AutoInc('logs_idlog_seq')]
  [Controllers(TControllerlogs)]
  Tlogs = class(TResourceBaseClass)
  protected
  public
    [DBField('IDLOG', True, True, False, PrimaryKey)]
    idlog: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('CP_PRODUTOS', True, True, False, Null)]
    cp_produtos: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('CODOS', True, True, False, Null)]
    codos: Integer;

    [DBField('DATAHORA', True, True, False, Null)]
    datahora: TDateTime;

    [DBField('QTD', True, True, False, Null)]
    qtd: Integer;

    [DBField('IDMOTIVO', True, True, False, Null)]
    idmotivo: Integer;

    [DBField('DTCHECKIN', True, True, False, Null)]
    dtcheckin: TDateTime;

    [DBField('DTCHECKOUT', True, True, False, Null)]
    dtcheckout: TDateTime;

    [DBField('TIPO', True, True, False, Null)]
    tipo: String;

  end;

implementation

{ Tlogs }

initialization

RegisterClass(Tlogs);

end.

