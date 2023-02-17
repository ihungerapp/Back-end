unit Resources.acessofilial;

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
  Controller.acessofilial;

type

  [Resource('acessofilial')]
  [Table('"Rotinas e Acessos".acessofilial')]
  [AutoInc('acessofilial_idacessofilial_seq')]
  [Controllers(TControlleracessofilial)]
  Tacessofilial = class(TResourceBaseClass)
  protected
  public
    [DBField('IDACESSOFILIAL', True, True, False, PrimaryKey)]
    idacessofilial: Integer;

    [DBField('CP_FILIAIS', True, True, False, NotNull)]
    cp_filiais: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('IDUSUARIOLIBERACAO', True, True, False, NotNull)]
    idusuarioliberacao: Integer;

    [DBField('SOMENTEVISUALIZACAO', True, True, False, Null)]
    somentevisualizacao: String;

    [DBField('DATALIBERACAO', True, True, False, Null)]
    dataliberacao: TDateTime;


  end;

implementation

{ Tacessofilial }

initialization

RegisterClass(Tacessofilial);

end.

