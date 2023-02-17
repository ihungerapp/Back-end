unit Resources.enderecosdeposito;

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
  Controller.enderecosdeposito;

type

  [Resource('enderecosdeposito')]
  [Table('"Cadastros WMS".enderecosdeposito')]
  [AutoInc('enderecosdeposito_iddeposito_seq')]
  [Controllers(TControllerenderecosdeposito)]
  Tenderecosdeposito = class(TResourceBaseClass)
  protected
  public
    [DBField('IDDEPOSITO', True, True, False, PrimaryKey)]
    iddeposito: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('IDTIPODEPOSITO', True, True, False, NotNull)]
    idtipodeposito: Integer;

    [DBField('IDDEPOSITOERP', True, True, False, Null)]
    iddepositoerp: Integer;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;


  end;

implementation

{ Tenderecosdeposito }

initialization

RegisterClass(Tenderecosdeposito);

end.

