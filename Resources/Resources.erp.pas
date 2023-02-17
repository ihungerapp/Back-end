unit Resources.erp;

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
  Controller.erp;

type

  [Resource('erp')]
  [Table('"Cadastros WMS".erp')]
  [AutoInc('erp_iderp_seq')]
  [Controllers(TControllererp)]
  Terp = class(TResourceBaseClass)
  protected
  public
    [DBField('IDERP', True, True, False, PrimaryKey)]
    iderp: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Terp }

initialization

RegisterClass(Terp);

end.

