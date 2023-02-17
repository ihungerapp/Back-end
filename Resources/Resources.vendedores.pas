unit Resources.vendedores;

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
  Controller.vendedores;

type

  [Resource('vendedores')]
  [Table('"Cadastros clientes".vendedores')]
  [AutoInc('vendedores_idvendedor_seq')]
  [Controllers(TControllervendedores)]
  Tvendedores = class(TResourceBaseClass)
  protected
  public
    [DBField('IDVENDEDOR', True, True, False, PrimaryKey)]
    idvendedor: Integer;

    [DBField('CODVENDEDOR', True, True, False, Null)]
    codvendedor: String;

    [DBField('NOMEVENDEDOR', True, True, False, Null)]
    nomevendedor: String;


  end;

implementation

{ Tvendedores }

initialization

RegisterClass(Tvendedores);

end.

