unit Resources.clientesrotas;

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
  Controller.clientesrotas;

type

  [Resource('clientesrotas')]
  [Table('"Cadastros clientes".clientesrotas')]
  [AutoInc('clientesrotas_cp_clientesrotas_seq')]
  [Controllers(TControllerclientesrotas)]
  Tclientesrotas = class(TResourceBaseClass)
  protected
  public
    [DBField('IDROTA', True, True, False, NotNull)]
    idrota: String;

    [DBField('CP_CLIENTESREGIOES', True, True, False, NotNull)]
    cp_clientesregioes: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('CP_CLIENTESROTAS', True, True, False, PrimaryKey)]
    cp_clientesrotas: Integer;


  end;

implementation

{ Tclientesrotas }

initialization

RegisterClass(Tclientesrotas);

end.

