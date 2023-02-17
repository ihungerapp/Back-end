unit Resources.usuariossetor;

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
  Controller.usuariossetor;

type

  [Resource('usuariossetor')]
  [Table('"Cadastros WMS".usuariossetor')]
  [AutoInc('usuariossetor_idsetor_seq')]
  [Controllers(TControllerusuariossetor)]
  Tusuariossetor = class(TResourceBaseClass)
  protected
  public
    [DBField('IDSETOR', True, True, False, PrimaryKey)]
    idsetor: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;


  end;

implementation

{ Tusuariossetor }

initialization

RegisterClass(Tusuariossetor);

end.

