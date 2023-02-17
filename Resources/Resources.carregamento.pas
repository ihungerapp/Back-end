unit Resources.carregamento;

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
  Controller.carregamento;

type

  [Resource('carregamento')]
  [Table('"Expedicao".carregamento')]
  [AutoInc('carregamento_cp_carregamento_seq')]
  [Controllers(TControllercarregamento)]
  Tcarregamento = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCARREGAMENTO', True, True, False, NotNull)]
    idcarregamento: String;

    [DBField('CP_FILIAIS', True, True, False, NotNull)]
    cp_filiais: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('CP_CLIENTESROTAS', True, True, False, NotNull)]
    cp_clientesrotas: Integer;

    [DBField('CP_MOTORISTA', True, True, False, NotNull)]
    cp_motorista: Integer;

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('DATASAIDA', True, True, False, Null)]
    datasaida: TDateTime;

    [DBField('DATACHEGADA', True, True, False, Null)]
    datachegada: TDateTime;

    [DBField('DESTINO', True, True, False, Null)]
    destino: String;

    [DBField('KMINICIAL', True, True, False, Null)]
    kminicial: String;

    [DBField('KMFINAL', True, True, False, Null)]
    kmfinal: String;

    [DBField('STATUS', True, True, False, Null)]
    status: String;

    [DBField('CP_TRANSPORTADORASVEICULOS', True, True, False, Null)]
    cp_transportadorasveiculos: Integer;

    [DBField('CP_CARREGAMENTO', True, True, False, PrimaryKey)]
    cp_carregamento: Integer;


  end;

implementation

{ Tcarregamento }

initialization

RegisterClass(Tcarregamento);

end.

