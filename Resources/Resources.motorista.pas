unit Resources.motorista;

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
  Controller.motorista;

type

  [Resource('motorista')]
  [Table('"Cadastros clientes".motorista')]
  [AutoInc('motorista_cp_motorista_seq')]
  [Controllers(TControllermotorista)]
  Tmotorista = class(TResourceBaseClass)
  protected
  public
    [DBField('IDMOTORISTA', True, True, False, NotNull)]
    idmotorista: String;

    [DBField('CODMOTORISTA', True, True, False, Null)]
    codmotorista: String;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('CP_MOTORISTA', True, True, False, PrimaryKey)]
    cp_motorista: Integer;


  end;

implementation

{ Tmotorista }

initialization

RegisterClass(Tmotorista);

end.

