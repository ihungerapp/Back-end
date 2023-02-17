unit Resources.transportadorasveiculos;

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
  Controller.transportadorasveiculos;

type

  [Resource('transportadorasveiculos')]
  [Table('"Cadastros clientes".transportadorasveiculos')]
  [AutoInc('transportadorasveiculos_cp_transportadorasveiculos_seq')]
  [Controllers(TControllertransportadorasveiculos)]
  Ttransportadorasveiculos = class(TResourceBaseClass)
  protected
  public
    [DBField('IDVEICULO', True, True, False, NotNull)]
    idveiculo: String;

    [DBField('NOMEVEICULO', True, True, False, Null)]
    nomeveiculo: String;

    [DBField('NOMEFANTASIA', True, True, False, Null)]
    nomefantasia: String;

    [DBField('CHASSI', True, True, False, Null)]
    chassi: String;

    [DBField('PLACA', True, True, False, Null)]
    placa: String;

    [DBField('CP_TRANSPORTADORAS', True, True, False, NotNull)]
    cp_transportadoras: Integer;

    [DBField('TARAVEICULO', True, True, False, Null)]
    taraveiculo: String;

    [DBField('PESOMINIMO', True, True, False, Null)]
    pesominimo: String;

    [DBField('PESOMAXIMO', True, True, False, Null)]
    pesomaximo: String;

    [DBField('LASTRO', True, True, False, Null)]
    lastro: String;

    [DBField('ALTURA', True, True, False, Null)]
    altura: String;

    [DBField('PROFUNDIDADE', True, True, False, Null)]
    profundidade: String;

    [DBField('M3', True, True, False, Null)]
    m3: String;

    [DBField('ATIVO', True, True, False, Null)]
    ativo: Integer;

    [DBField('CP_TRANSPORTADORASVEICULOS', True, True, False, PrimaryKey)]
    cp_transportadorasveiculos: Integer;


  end;

implementation

{ Ttransportadorasveiculos }

initialization

RegisterClass(Ttransportadorasveiculos);

end.

