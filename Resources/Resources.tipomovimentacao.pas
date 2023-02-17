unit Resources.tipomovimentacao;

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
  Controller.tipomovimentacao;

type

  [Resource('tipomovimentacao')]
  [Table('"Cadastros WMS".tipomovimentacao')]
  [AutoInc('tipomovimentacao_idtipomovimentacao_seq')]
  [Controllers(TControllertipomovimentacao)]
  Ttipomovimentacao = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOMOVIMENTACAO', True, True, False, PrimaryKey)]
    idtipomovimentacao: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Ttipomovimentacao }

initialization

RegisterClass(Ttipomovimentacao);

end.

