unit Resources.enderecosestacao;

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
  Controller.enderecosestacao;

type

  [Resource('enderecosestacao')]
  [Table('"Cadastros WMS".enderecosestacao')]
  [AutoInc('enderecosestacao_idestacao_seq')]
  [Controllers(TControllerenderecosestacao)]
  Tenderecosestacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDESTACAO', True, True, False, PrimaryKey)]
    idestacao: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;

    [DBField('IDDEPOSITO', True, True, False, NotNull)]
    iddeposito: Integer;

    [DBField('TIPOSEPARACAO', True, True, False, Null)]
    tiposeparacao: String;

    [DBField('IDTIPOESTACAO', True, True, False, Null)]
    idtipoestacao: Integer;


  end;

implementation

{ Tenderecosestacao }

initialization

RegisterClass(Tenderecosestacao);

end.

