unit u_GeraResource;

interface

uses
  System.SysUtils,
  System.Classes;

type
  IResource = interface
    ['{F3C2DE2D-0A16-4B61-A7D9-ECEDC8FD2594}']
    function Execute(ANomeResource, ANomeTabela, ANomeClasse, ANomeCampos: string): string;
  end;

type
  TResourceClasse = class(TInterfacedObject, IResource)
  private
    const
      NOVALINHA: string = #13#10;
    function MontaResource(ANomeResource, ANomeTabela, ANomeClasse, ANomeCampos: string): string;
    function Execute(ANomeResource, ANomeTabela, ANomeClasse, ANomeCampos: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function Ref: IResource;
  end;

var
  ResourceClasse: TResourceClasse;

implementation

{ TResource }

constructor TResourceClasse.Create;
begin
  inherited Create;
end;

destructor TResourceClasse.Destroy;
begin
  inherited Destroy;
end;

function TResourceClasse.Ref: IResource;
begin
  result := Self;
end;

function TResourceClasse.Execute(ANomeResource, ANomeTabela, ANomeClasse, ANomeCampos: string): string;
begin
  result := MontaResource(ANomeResource, ANomeTabela, ANomeClasse, ANomeCampos);
end;

function TResourceClasse.MontaResource(ANomeResource, ANomeTabela, ANomeClasse, ANomeCampos: string): string;
begin
  result := 'unit Resources.@classe; ' + NOVALINHA
          + NOVALINHA
          + 'interface ' + NOVALINHA
          + NOVALINHA
          + 'uses ' + NOVALINHA
          + '  //Web.HTTPApp, ' + NOVALINHA
          + '  //System.Generics.Collections, ' + NOVALINHA
          + '  //System.SysUtils, ' + NOVALINHA
          + '  System.Classes, ' + NOVALINHA
          + '  //Server.Message, ' + NOVALINHA
          + '  //Server.MessageList, ' + NOVALINHA
          + '  //Server.Connection, ' + NOVALINHA
          + '  Server.Attributes, ' + NOVALINHA
          + '  Server.ResourceBaseClass; ' + NOVALINHA
          + 'type ' + NOVALINHA
          + '  [Resource(@classe_resource)] ' + NOVALINHA
          + '  [Table(@tabela)] ' + NOVALINHA
          + '  T@classe = class(TResourceBaseClass) ' + NOVALINHA
          + '  protected ' + NOVALINHA
          + '    //procedure ValidateBusiness(List: TObjectList<TObject>); override; ' + NOVALINHA
          + '  public ' + NOVALINHA
          + '    @DBField ' + NOVALINHA
          + '  end; ' + NOVALINHA
          + NOVALINHA
          + 'implementation ' + NOVALINHA
          + NOVALINHA
          + '{ T@classe } ' + NOVALINHA
          + NOVALINHA
          + '//procedure T@classe.ValidateBusiness(List: TObjectList<TObject>); ' + NOVALINHA
          + '//begin ' + NOVALINHA
          + '//  inherited; ' + NOVALINHA
          + '//Exemplo ' + NOVALINHA
          + '//  if TGrupo(List.First).STR_DESCRICAO = EmptyStr then ' + NOVALINHA
          + '//  begin ' + NOVALINHA
          + '//    AResult:= False; ' + NOVALINHA
          + '//    TMessage.Create(ECampoNotNullNaoPreenchido, ''Descricao é obrigatório'').ViewMessage; ' + NOVALINHA
          + '//  end; ' + NOVALINHA
          + '//end; ' + NOVALINHA
          + NOVALINHA
          + 'initialization ' + NOVALINHA
          + '  RegisterClass(T@classe); ' + NOVALINHA
          + NOVALINHA
          + 'end. ' + NOVALINHA;

  result := result.Replace('@tabela', QuotedStr(ANomeTabela), [rfReplaceAll]);
  result := result.Replace('@classe_resource', QuotedStr(ANomeResource), [rfReplaceAll]);
  result := result.Replace('@classe', ANomeClasse, [rfReplaceAll]);
  result := result.Replace('@DBField', ANomeCampos, [rfReplaceAll]);
end;

end.

