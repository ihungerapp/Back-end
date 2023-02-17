unit Resources.acessotoken;

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
  Controller.acessotoken;

type

  [Resource('acessotoken')]
  [Table('"Rotinas e Acessos".acessotoken')]
  [AutoInc('acessotoken_idtoken_seq')]
  [Controllers(TControlleracessotoken)]
  Tacessotoken = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTOKEN', True, True, False, PrimaryKey)]
    idtoken: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('TOKEN', True, True, False, Null)]
    token: String;

    [DBField('DATAHORA', True, True, False, Null)]
    datahora: TDateTime;


  end;

implementation

{ Tacessotoken }

initialization

RegisterClass(Tacessotoken);

end.

