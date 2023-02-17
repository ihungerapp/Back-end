unit Resources.subgrupos;

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
  Controller.subgrupos;

type

  [Resource('subgrupos')]
  [Table('"Cadastros clientes".subgrupos')]
  [AutoInc('subgrupos_cp_subgrupos_seq')]
  [Controllers(TControllersubgrupos)]
  Tsubgrupos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDSUBGRUPO', True, True, False, NotNull)]
    idsubgrupo: String;

    [DBField('CP_GRUPOS', True, True, False, NotNull)]
    cp_grupos: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('CP_SUBGRUPOS', True, True, False, PrimaryKey)]
    cp_subgrupos: Integer;


  end;

implementation

{ Tsubgrupos }

initialization

RegisterClass(Tsubgrupos);

end.

