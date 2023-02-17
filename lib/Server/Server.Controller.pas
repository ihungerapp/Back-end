unit Server.Controller;

interface

uses
  Server.Controller.Interfaces, System.Generics.Collections, System.JSON,
  System.Rtti;

type
  TController = class(TInterfacedObject, iController)
    private

    public
      constructor Create;
      destructor Destroy; override;
      class function GetInstance: iController;
      function Execute(pMethod: String) : TJSONObject; virtual;
      procedure SetParams(const Value: TValue; Index: Integer); virtual;
      procedure SetLengthParams(Size: Integer); virtual;
  end;

implementation

{ TController }

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin
  inherited;
end;

class function TController.GetInstance: iController;
begin
  Result := Self.Create;
end;

procedure TController.SetLengthParams(Size: Integer);
begin

end;

procedure TController.SetParams(const Value: TValue; Index: Integer);
begin

end;

function TController.Execute(pMethod: String) : TJSONObject;
begin

end;

end.
