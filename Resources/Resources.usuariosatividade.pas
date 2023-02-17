unit Resources.usuariosatividade;

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
  Controller.usuariosatividade;

type

  [Resource('usuariosatividade')]
  [Table('"Cadastros WMS".usuariosatividade')]
  [AutoInc('usuariosatividade_idatividade_seq')]
  [Controllers(TControllerusuariosatividade)]
  Tusuariosatividade = class(TResourceBaseClass)
  protected
  public
    [DBField('IDATIVIDADE', True, True, False, PrimaryKey)]
    idatividade: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('DATAINICIO', True, True, False, Null)]
    datainicio: TDateTime;

    [DBField('DATATERMINO', True, True, False, Null)]
    datatermino: TDateTime;


  end;

implementation

{ Tusuariosatividade }

initialization

RegisterClass(Tusuariosatividade);

end.

