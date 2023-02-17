unit Server.Controller.Interfaces;

interface

uses
  System.JSON, System.Rtti;

type

  iController = interface
    ['{F70F3280-D473-4CDD-B1A7-0F807B5314A2}']
    function Execute(pMethod: String) : TJSONObject;
    procedure SetParams(const Value: TValue; Index: Integer);
    procedure SetLengthParams(Size: Integer);
  end;

implementation

end.
