unit Resources.tipoinventario;

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
  Controller.tipoinventario;

type

  [Resource('tipoinventario')]
  [Table('"Cadastros WMS".tipoinventario')]
  [AutoInc('tipoinventario_idtipoinventario_seq')]
  [Controllers(TControllertipoinventario)]
  Ttipoinventario = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOINVENTARIO', True, True, False, PrimaryKey)]
    idtipoinventario: Integer;

    [DBField('DESCRICAO', True, True, False, Null)]
    descricao: String;


  end;

implementation

{ Ttipoinventario }

initialization

RegisterClass(Ttipoinventario);

end.

