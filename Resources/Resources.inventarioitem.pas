unit Resources.inventarioitem;

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
  Controller.inventarioitem;

type

  [Resource('inventarioitem')]
  [Table('"Inventario".inventarioitem')]
  [AutoInc('inventarioitem_idinventarioitem_seq')]
  [Controllers(TControllerinventarioitem)]
  Tinventarioitem = class(TResourceBaseClass)
  protected
  public
    [DBField('IDINVENTARIOITEM', True, True, False, PrimaryKey)]
    idinventarioitem: Integer;

    [DBField('IDINVENTARIO', True, True, False, NotNull)]
    idinventario: Integer;

    [DBField('CP_PRODUTOS', True, True, False, NotNull)]
    cp_produtos: Integer;

    [DBField('IDENDERECO', True, True, False, NotNull)]
    idendereco: Integer;

    [DBField('IDUSUARIO', True, True, False, NotNull)]
    idusuario: Integer;

    [DBField('IDCONTAGEM', True, True, False, NotNull)]
    idcontagem: Integer;

    [DBField('QTDESTOQUE', True, True, False, Null)]
    qtdestoque: Integer;

    [DBField('QTDCONTAGEM', True, True, False, Null)]
    qtdcontagem: Integer;

    [DBField('DATAVALIDADE', True, True, False, Null)]
    datavalidade: TDateTime;

    [DBField('LOTE', True, True, False, Null)]
    lote: String;

    [DBField('NUMSERIE', True, True, False, Null)]
    numserie: String;

    [DBField('ITEM', True, True, False, Null)]
    item: String;


  end;

implementation

{ Tinventarioitem }

initialization

RegisterClass(Tinventarioitem);

end.

