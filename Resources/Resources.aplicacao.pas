unit Resources.aplicacao;

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
  Controller.aplicacao;

type

  [Resource('aplicacao')]
  [Table('"Rotinas e Acessos".aplicacao')]
  [AutoInc('aplicacao_idaplicacao_seq')]
  [Controllers(TControlleraplicacao)]
  Taplicacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDAPLICACAO', True, True, False, PrimaryKey)]
    idaplicacao: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('WEB', True, True, False, NotNull)]
    web: String;

    [DBField('MOBILE', True, True, False, NotNull)]
    mobile: String;


  end;

implementation

{ Taplicacao }

initialization

RegisterClass(Taplicacao);

end.

