unit Resources.tipoembalagem;

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
  Controller.tipoembalagem;

type

  [Resource('tipoembalagem')]
  [Table('"Cadastros WMS".tipoembalagem')]
  [AutoInc('tipoembalagem_cp_tipoembalagem_seq')]
  [Controllers(TControllertipoembalagem)]
  Ttipoembalagem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDTIPOEMBALAGEM', True, True, False, Null)]
    idtipoembalagem: String;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('CP_TIPOEMBALAGEM', True, True, False, PrimaryKey)]
    cp_tipoembalagem: Integer;


  end;

implementation

{ Ttipoembalagem }

initialization

RegisterClass(Ttipoembalagem);

end.

