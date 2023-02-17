unit Resources.clientesregioes;

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
  Controller.clientesregioes;

type

  [Resource('clientesregioes')]
  [Table('"Cadastros clientes".clientesregioes')]
  [AutoInc('clientesregioes_cp_clientesregioes_seq')]
  [Controllers(TControllerclientesregioes)]
  Tclientesregioes = class(TResourceBaseClass)
  protected
  public
    [DBField('IDREGIAO', True, True, False, NotNull)]
    idregiao: String;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('CP_CLIENTESREGIOES', True, True, False, PrimaryKey)]
    cp_clientesregioes: Integer;


  end;

implementation

{ Tclientesregioes }

initialization

RegisterClass(Tclientesregioes);

end.

