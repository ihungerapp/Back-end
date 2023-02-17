unit Resources.grupos;

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
  Controller.grupos;

type

  [Resource('grupos')]
  [Table('"Cadastros clientes".grupos')]
  [AutoInc('grupos_cp_grupos_seq')]
  [Controllers(TControllergrupos)]
  Tgrupos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDGRUPO', True, True, False, NotNull)]
    idgrupo: String;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('CP_GRUPOS', True, True, False, PrimaryKey)]
    cp_grupos: Integer;


  end;

implementation

{ Tgrupos }

initialization

RegisterClass(Tgrupos);

end.

