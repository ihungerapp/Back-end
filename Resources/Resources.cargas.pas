unit Resources.cargas;

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
  Controller.cargas;

type

  [Resource('cargas')]
  [Table('"Recebimento".cargas')]
  [AutoInc('cargas_idcarga_seq')]
  [Controllers(TControllercargas)]
  Tcargas = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCARGA', True, True, False, PrimaryKey)]
    idcarga: Integer;

    [DBField('IDDEPOSITO', True, True, False, NotNull)]
    iddeposito: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('DATAGERACAO', True, True, False, Null)]
    datageracao: TDateTime;

    [DBField('DATAINICIOCONF', True, True, False, Null)]
    datainicioconf: TDateTime;

    [DBField('DATAEXPORTACAOERP', True, True, False, Null)]
    dataexportacaoerp: TDateTime;

    [DBField('QTDVOLUMES', True, True, False, Null)]
    qtdvolumes: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Tcargas }

initialization

RegisterClass(Tcargas);

end.

