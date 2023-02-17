unit Resources.usuariosturno;

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
  Controller.usuariosturno;

type

  [Resource('usuariosturno')]
  [Table('"Cadastros WMS".usuariosturno')]
  [AutoInc('usuariosturno_idturno_seq')]
  [Controllers(TControllerusuariosturno)]
  Tusuariosturno = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTURNO', True, True, False, PrimaryKey)]
    idturno: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('HORAINICIO', True, True, False, Null)]
    horainicio: TDateTime;

    [DBField('HORAFINAL', True, True, False, Null)]
    horafinal: TDateTime;

    [DBField('TEMPOINTERVALO', True, True, False, Null)]
    tempointervalo: TDateTime;


  end;

implementation

{ Tusuariosturno }

initialization

RegisterClass(Tusuariosturno);

end.

