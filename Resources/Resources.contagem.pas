unit Resources.contagem;

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
  Controller.contagem;

type

  [Resource('contagem')]
  [Table('"Inventario".contagem')]
  [AutoInc('contagem_idcontagem_seq')]
  [Controllers(TControllercontagem)]
  Tcontagem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCONTAGEM', True, True, False, PrimaryKey)]
    idcontagem: Integer;

    [DBField('DESCRICAO', True, True, False, Null)]
    descricao: String;


  end;

implementation

{ Tcontagem }

initialization

RegisterClass(Tcontagem);

end.

