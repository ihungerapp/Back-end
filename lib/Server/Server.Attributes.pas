unit Server.Attributes;

interface

uses
  System.Classes, System.SysUtils,
  Server.Controller.Interfaces,
  Server.Controller, System.Generics.Collections;

type
  Get = class(TCustomAttribute)
  end;

  Post = class(TCustomAttribute)
  end;

  Put = class(TCustomAttribute)
  end;

  Patch = class(TCustomAttribute)
  end;

  Delete = class(TCustomAttribute)
  end;

  Resource = class(TCustomAttribute)
  private
    FResourceName: String;
  public
    property ResourceName: String read FResourceName write FResourceName;
    constructor Create(pResourceName: String);
  end;

  Controllers = class(TCustomAttribute)
  private
    FControllerClass: TClass;
  public
    constructor Create(pControllerClass: TClass);
    property ControllerClass: TClass read FControllerClass write FControllerClass;
  end;

  Table = class(TCustomAttribute)
  private
    FTableName: String;
  public
    property TableName: String read FTableName write FTableName;
    constructor Create(pTableName: String);
  end;

  TConstraints = (PrimaryKey, NotNull, Null);
  AutoInc = class(TCustomAttribute)
  private
    FSequenceName: String;
  public
    property SequenceName: String read FSequenceName write FSequenceName;
    constructor Create(pSequenceName: String);
  end;

  DBField = class(TCustomAttribute)
  private
    FFieldName: String;
    FConstraints: TConstraints;
    FAutoInc: AutoInc;
    FHeader: Boolean;
    FListSelect: Boolean;
    FSort: Boolean;
    FSize: Integer;
  public
    property FieldName: String read FFieldName write FFieldName;
    property Constraints: TConstraints read FConstraints write FConstraints;
    property AutoIncrement: AutoInc read FAutoInc write FAutoInc;
    property Header: Boolean read FHeader write FHeader;
    property ListSelect: Boolean read FListSelect write FListSelect;
    property Sort: Boolean read FSort write FSort;
    property Size: Integer read FSize write FSize;
    constructor Create(pFieldName: String; pHeader: Boolean; pListSelect: Boolean; pSort: Boolean; pConstraints: TConstraints); overload;
  end;

  DBRelationship = class(TCustomAttribute)
  private
    FNameRelationship: String;
    FListRelationship: TObjectList<TObject>;
    FRelationship: TObject;
    procedure SetNameRelationship(const Value: String);
    procedure SetListRelationship(const Value: TObjectList<TObject>);
    procedure SetRelationship(const Value: TObject);
  public
    property ListRelationship: TObjectList<TObject> read FListRelationship write SetListRelationship;
    property Relationship: TObject read FRelationship write SetRelationship;
    property NameRelationship: String read FNameRelationship write SetNameRelationship;
    constructor Create(pNameRelationship: String); overload;
  end;

  TMacAddress = class
  private
    FValue: String;
  public
    constructor Create(pValue: String); overload;
    property Value: String read FValue;
  end;

  TBytea = class
  private
    FValue: TStringList;
  public
    constructor Create(pValue: String); overload;
    destructor Destroy();override;
    property Value: TStringList read FValue;
  end;

  Detail = class(TCustomAttribute)
  private
    FSourceFields: String;
    FDestinyFields: String;
  public
    property SourceFields: String read FSourceFields write FSourceFields;
    property DestinyFields: String read FDestinyFields write FDestinyFields;
    constructor Create(pSourceFields: String; pDestinyFields: String);
  end;

  DBFieldTypeMemo = class(TCustomAttribute);
  Authorization = class(TCustomAttribute);
implementation

{ Resource }
constructor Resource.Create(pResourceName: String);
begin
  Self.ResourceName := pResourceName;
end;

{ Controller }
constructor Controllers.Create(pControllerClass: TClass);
begin
  Self.ControllerClass := pControllerClass;
end;

{ Table }
constructor Table.Create(pTableName: String);
begin
  Self.TableName := pTableName;
end;

{ Field }
constructor DBField.Create(pFieldName: String; pHeader: Boolean; pListSelect: Boolean; pSort: Boolean; pConstraints: TConstraints);
begin
  Self.FieldName := pFieldName;
  Self.Constraints := pConstraints;
  Self.Header := pHeader;
  Self.ListSelect := pListSelect;
  Self.Sort := pSort;
end;

{ TAutoInc }
constructor AutoInc.Create(pSequenceName: String);
begin
  Self.SequenceName := pSequenceName;
end;

{ Detail }
constructor Detail.Create(pSourceFields, pDestinyFields: String);
begin
  SourceFields := pSourceFields;
  DestinyFields := pDestinyFields;
end;

{ TMacAddress }
constructor TMacAddress.Create(pValue: String);
begin
  FValue := pValue;
end;

{ TBytea }
constructor TBytea.Create(pValue: String);
begin
  FValue := TStringList.Create();
  FValue.Text := pValue;
end;

destructor TBytea.Destroy;
begin
  FreeAndNil(Self.Value);
  inherited;
end;

{ DBRelationship }

constructor DBRelationship.Create(pNameRelationship: String);
begin
  Self.NameRelationship := pNameRelationship;
  Self.FListRelationship := TObjectList<TObject>.Create;
end;

procedure DBRelationship.SetListRelationship(const Value: TObjectList<TObject>);
begin
  Self.FListRelationship := Value;
end;

procedure DBRelationship.SetNameRelationship(const Value: String);
begin
  Self.FNameRelationship := Value;
end;

procedure DBRelationship.SetRelationship(const Value: TObject);
begin
  Self.FRelationship := Value;
  Self.FListRelationship.Add(Value);
end;

end.
