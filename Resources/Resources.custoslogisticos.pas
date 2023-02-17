unit Resources.custoslogisticos;

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
  Controller.custoslogisticos;

type

  [Resource('custoslogisticos')]
  [Table('"Cadastros WMS".custoslogisticos')]
  [AutoInc('custoslogisticos_idcusto_seq')]
  [Controllers(TControllercustoslogisticos)]
  Tcustoslogisticos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDCUSTO', True, True, False, PrimaryKey)]
    idcusto: Integer;

    [DBField('NOME', True, True, False, Null)]
    nome: String;

    [DBField('UNIDADE', True, True, False, Null)]
    unidade: String;

    [DBField('PESO', True, True, False, Null)]
    peso: Currency;

    [DBField('CUSTO', True, True, False, Null)]
    custo: Currency;


  end;

implementation

{ Tcustoslogisticos }

initialization

RegisterClass(Tcustoslogisticos);

end.

