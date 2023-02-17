unit Resources.parametro;

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
  Controller.parametro;

type

  [Resource('parametro')]
  [Table('"Parametrizacao".parametro')]
  [AutoInc('parametro_idparametro_seq')]
  [Controllers(TControllerparametro)]
  Tparametro = class(TResourceBaseClass)
  protected
  public
    [DBField('IDPARAMETRO', True, True, False, PrimaryKey)]
    idparametro: Integer;

    [DBField('CP_FILIAIS', True, True, False, NotNull)]
    cp_filiais: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('DESCRICAO', True, True, False, Null)]
    descricao: String;

    [DBField('OBS', True, True, False, Null)]
    obs: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: Integer;


  end;

implementation

{ Tparametro }

initialization

RegisterClass(Tparametro);

end.

