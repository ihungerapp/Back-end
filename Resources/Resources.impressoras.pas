unit Resources.impressoras;

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
  Controller.impressoras;

type

  [Resource('impressoras')]
  [Table('"Cadastros WMS".impressoras')]
  [AutoInc('impressoras_idx_seq')]
  [Controllers(TControllerimpressoras)]
  Timpressoras = class(TResourceBaseClass)
  protected
  public
    [DBField('IDX', True, True, False, PrimaryKey)]
    idx: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('SETOR', True, True, False, NotNull)]
    setor: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: TDateTime;


  end;

implementation

{ Timpressoras }

initialization

RegisterClass(Timpressoras);

end.

