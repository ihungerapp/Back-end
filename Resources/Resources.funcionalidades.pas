unit Resources.funcionalidades;

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
  Controller.funcionalidades;

type

  [Resource('funcionalidades')]
  [Table('"Rotinas e Acessos".funcionalidades')]
  [AutoInc('funcionalidades_idfuncionalidade_seq')]
  [Controllers(TControllerfuncionalidades)]
  Tfuncionalidades = class(TResourceBaseClass)
  protected
  public
    [DBField('IDFUNCIONALIDADE', True, True, False, PrimaryKey)]
    idfuncionalidade: Integer;

    [DBField('IDROTINA', True, True, False, NotNull)]
    idrotina: Integer;

    [DBField('DESCRICAO', True, True, False, Null)]
    descricao: String;

    [DBField('ORDEM', True, True, False, Null)]
    ordem: Integer;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: String;


  end;

implementation

{ Tfuncionalidades }

initialization

RegisterClass(Tfuncionalidades);

end.

