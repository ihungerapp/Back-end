unit Resources.ordenacaoestacao;

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
  Controller.ordenacaoestacao;

type

  [Resource('ordenacaoestacao')]
  [Table('"Cadastros WMS".ordenacaoestacao')]
  [AutoInc('ordenacaoestacao_idordenacao_seq')]
  [Controllers(TControllerordenacaoestacao)]
  Tordenacaoestacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDORDENACAO', True, True, False, PrimaryKey)]
    idordenacao: Integer;

    [DBField('IDESTACAO', True, True, False, NotNull)]
    idestacao: Integer;

    [DBField('RUA', True, True, False, Null)]
    rua: String;

    [DBField('ORDEM', True, True, False, Null)]
    ordem: Integer;


  end;

implementation

{ Tordenacaoestacao }

initialization

RegisterClass(Tordenacaoestacao);

end.

