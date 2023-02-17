unit Resources.enderecos;

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
  Controller.enderecos;

type

  [Resource('enderecos')]
  [Table('"Cadastros WMS".enderecos')]
  [AutoInc('enderecos_idendereco_seq')]
  [Controllers(TControllerenderecos)]
  Tenderecos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDENDERECO', True, True, False, PrimaryKey)]
    idendereco: Integer;

    [DBField('IDTIPOENDERECO', True, True, False, NotNull)]
    idtipoendereco: Integer;

    [DBField('IDESTACAO', True, True, False, NotNull)]
    idestacao: Integer;

    [DBField('IDDEPOSITO', True, True, False, NotNull)]
    iddeposito: Integer;

    [DBField('RUA', True, True, False, NotNull)]
    rua: String;

    [DBField('PREDIO', True, True, False, NotNull)]
    predio: String;

    [DBField('ANDAR', True, True, False, NotNull)]
    andar: Integer;

    [DBField('APTO', True, True, False, NotNull)]
    apto: Integer;

    [DBField('DIRECAO', True, True, False, Null)]
    direcao: String;

    [DBField('ALTURA', True, True, False, Null)]
    altura: Currency;

    [DBField('LARGURA', True, True, False, Null)]
    largura: Currency;

    [DBField('PROFUNDIDADE', True, True, False, Null)]
    profundidade: Currency;

    [DBField('M3', True, True, False, Null)]
    m3: Currency;

    [DBField('QTDPALETE', True, True, False, Null)]
    qtdpalete: Integer;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;


  end;

implementation

{ Tenderecos }

initialization

RegisterClass(Tenderecos);

end.

