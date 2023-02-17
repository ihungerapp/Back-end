unit Resources.volumes;

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
  Controller.volumes;

type

  [Resource('volumes')]
  [Table('"Movimentacao".volumes')]
  [AutoInc('volumes_idvolume_seq')]
  [Controllers(TControllervolumes)]
  Tvolumes = class(TResourceBaseClass)
  protected
  public
    [DBField('IDUSUARIOGEROU', True, True, False, NotNull)]
    idusuariogerou: Integer;

    [DBField('DATAHORAGERACAO', True, True, False, Null)]
    datahorageracao: TDateTime;

    [DBField('SITUACAO', True, True, False, NotNull)]
    situacao: String;

    [DBField('IMPRESSO', True, True, False, NotNull)]
    impresso: Integer;

    [DBField('IDVOLUME', True, True, False, PrimaryKey)]
    idvolume: Integer;

    [DBField('CODVOLUME', True, True, False, Null)]
    codvolume: String;

    [DBField('IDTIPOVOLUMES', True, True, False, NotNull)]
    idtipovolumes: Integer;


  end;

implementation

{ Tvolumes }

initialization

RegisterClass(Tvolumes);

end.

