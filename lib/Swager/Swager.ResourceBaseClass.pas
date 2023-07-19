unit Swager.ResourceBaseClass;

interface

uses
  Swager.Json.DTO, System.Generics.Collections, REST.Json.Types,classes;

{$M+}

type

  T_200 = class;
  T_204 = class;
  T_500 = class;
  TDelete = class;
  TGet = class;
  TParameters = class;
  TPost = class;
  TPut = class;
  TResponses = class;
  TSchema = class;

  T_204 = class
  private
    FDescription: string;
  published
    property Description: string read FDescription write FDescription;
  end;

  TResponses = class
  private
    [JSONName('200')]
    F_200: T_200;
    [JSONName('204')]
    F_204: T_204;
    [JSONName('500')]
    F_500: T_500;
  published
    property _200: T_200 read F_200;
    property _204: T_204 read F_204;
    property _500: T_500 read F_500;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TParameters = class
  private
    FDescription: string;
    FExample: string;
    FIn: string;
    FName: string;
    FRequired: Boolean;
    FSchema: TSchema;
    FType: string;
  published
    property Description: string read FDescription write FDescription;
    property Example: string read FExample write FExample;
    property &In: string read FIn write FIn;
    property Name: string read FName write FName;
    property Required: Boolean read FRequired write FRequired;
    property Schema: TSchema read FSchema;
    property &Type: string read FType write FType;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDelete = class(TJsonDTO)
  private
    FDescription: string;
    FOperationId: string;
    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;
    [JSONName('tags')]
    FTagsArray: TArray<string>;
    [JSONMarshalled(False)]
    FTags: TList<string>;
    function GetParameters: TObjectList<TParameters>;
    function GetTags: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;
    property Tags: TList<string> read GetTags;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  T_500 = class
  private
    [JSONName('$ref')]
    FRef: string;
  published
    property Ref: string read FRef write FRef;
  end;

  T_200 = class
  private
    [JSONName('$ref')]
    FRef: string;
  published
    property Ref: string read FRef write FRef;
  end;

  TSchema = class
  private
    [JSONName('$ref')]
    FRef: string;
  published
    property Ref: string read FRef write FRef;
  end;

  TPut = class(TJsonDTO)
  private
    FDescription: string;
    FOperationId: string;
    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;
    [JSONName('tags')]
    FTagsArray: TArray<string>;
    [JSONMarshalled(False)]
    FTags: TList<string>;
    function GetParameters: TObjectList<TParameters>;
    function GetTags: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;
    property Tags: TList<string> read GetTags;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TGet = class(TJsonDTO)
  private
    FDescription: string;
    FOperationId: string;
    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;
    [JSONName('tags')]
    FTagsArray: TArray<string>;
    [JSONMarshalled(False)]
    FTags: TList<string>;
    function GetParameters: TObjectList<TParameters>;
    function GetTags: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;
    property Tags: TList<string> read GetTags;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TResourceBaseId = class
  private
    FDelete: TDelete;
    FGet: TGet;
    FPut: TPut;
  published
    property Delete: TDelete read FDelete;
    property Get: TGet read FGet;
    property Put: TPut read FPut;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TPost = class(TJsonDTO)
  private
    FDescription: string;
    FOperationId: string;
    [JSONName('parameters'), JSONMarshalled(False)]
    FParametersArray: TArray<TParameters>;
    [GenericListReflect]
    FParameters: TObjectList<TParameters>;
    FResponses: TResponses;
    [JSONName('tags')]
    FTagsArray: TArray<string>;
    [JSONMarshalled(False)]
    FTags: TList<string>;
    function GetParameters: TObjectList<TParameters>;
    function GetTags: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Description: string read FDescription write FDescription;
    property OperationId: string read FOperationId write FOperationId;
    property Parameters: TObjectList<TParameters> read GetParameters;
    property Responses: TResponses read FResponses;
    property Tags: TList<string> read GetTags;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TResourceBase = class
  private
    FGet: TGet;
    FPost: TPost;
  published
    property Get: TGet read FGet;
    property Post: TPost read FPost;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TRoot = class(TJsonDTO)
  private
    [JSONName('/cargos')]
    FResourceBase: TResourceBase;
    [JSONName('/cargos/{id}')]
    FResourceBaseId: TResourceBaseId;
  published
    property ResourceBase: TResourceBase read FResourceBase;
    property ResourceBaseId: TResourceBaseId read FResourceBaseId;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TResponses }

constructor TResponses.Create;
begin
  inherited;
  F_200 := T_200.Create;
  F_500 := T_500.Create;
  F_204 := T_204.Create;
end;

destructor TResponses.Destroy;
begin
  F_200.Free;
  F_500.Free;
  F_204.Free;
  inherited;
end;

{ TParameters }

constructor TParameters.Create;
begin
  inherited;
  FSchema := TSchema.Create;
end;

destructor TParameters.Destroy;
begin
  FSchema.Free;
  inherited;
end;

{ TDelete }

constructor TDelete.Create;
begin
  inherited;
  FResponses := TResponses.Create;
end;

destructor TDelete.Destroy;
begin
  FResponses.Free;
  GetTags.Free;
  GetParameters.Free;
  inherited;
end;

function TDelete.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TDelete.GetTags: TList<string>;
begin
  Result := List<string>(FTags, FTagsArray);
end;

function TDelete.GetAsJson: string;
begin
  RefreshArray<TParameters>(FParameters, FParametersArray);
  RefreshArray<string>(FTags, FTagsArray);
  Result := inherited;
end;

{ TPut }

constructor TPut.Create;
begin
  inherited;
  FResponses := TResponses.Create;
end;

destructor TPut.Destroy;
begin
  FResponses.Free;
  GetTags.Free;
  GetParameters.Free;
  inherited;
end;

function TPut.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TPut.GetTags: TList<string>;
begin
  Result := List<string>(FTags, FTagsArray);
end;

function TPut.GetAsJson: string;
begin
  RefreshArray<TParameters>(FParameters, FParametersArray);
  RefreshArray<string>(FTags, FTagsArray);
  Result := inherited;
end;

{ TGet }

constructor TGet.Create;
begin
  inherited;
  FResponses := TResponses.Create;
end;

destructor TGet.Destroy;
begin
  FResponses.Free;
  GetTags.Free;
  GetParameters.Free;
  inherited;
end;

function TGet.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TGet.GetTags: TList<string>;
begin
  Result := List<string>(FTags, FTagsArray);
end;

function TGet.GetAsJson: string;
begin
  RefreshArray<TParameters>(FParameters, FParametersArray);
  RefreshArray<string>(FTags, FTagsArray);
  Result := inherited;
end;

{ TResourceBaseId }

constructor TResourceBaseId.Create;
begin
  inherited;
  FGet := TGet.Create;
  FPut := TPut.Create;
  FDelete := TDelete.Create;
end;

destructor TResourceBaseId.Destroy;
begin
  FGet.Free;
  FPut.Free;
  FDelete.Free;
  inherited;
end;

{ TPost }

constructor TPost.Create;
begin
  inherited;
  FResponses := TResponses.Create;
end;

destructor TPost.Destroy;
begin
  FResponses.Free;
  GetTags.Free;
  GetParameters.Free;
  inherited;
end;

function TPost.GetParameters: TObjectList<TParameters>;
begin
  Result := ObjectList<TParameters>(FParameters, FParametersArray);
end;

function TPost.GetTags: TList<string>;
begin
  Result := List<string>(FTags, FTagsArray);
end;

function TPost.GetAsJson: string;
begin
  RefreshArray<TParameters>(FParameters, FParametersArray);
  RefreshArray<string>(FTags, FTagsArray);
  Result := inherited;
end;

{ TResourceBase }

constructor TResourceBase.Create;
begin
  inherited;
  FGet := TGet.Create;
  FPost := TPost.Create;
end;

destructor TResourceBase.Destroy;
begin
  FGet.Free;
  FPost.Free;
  inherited;
end;

{ TRoot }

constructor TRoot.Create;
begin
  inherited;
  FResourceBase := TResourceBase.Create;
  FResourceBaseId := TResourceBaseId.Create;
end;

destructor TRoot.Destroy;
begin
  FResourceBase.Free;
  FResourceBaseId.Free;
  inherited;
end;

end.
