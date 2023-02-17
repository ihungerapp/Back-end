unit Server.Log;

interface

uses
  Vcl.AppEvnts, System.SysUtils, Winapi.Windows, Vcl.Forms;

type
  TLog = class
  private
    EventsApplication: TApplicationEvents;
    FFileLog: TextFile;
    constructor Create;
  public
    class function GetInstance: TLog;
    destructor Destroy;
    procedure OnException(Sender: TObject; E: Exception);
    procedure CreateFileLog;
    property FileLog: TextFile read FFileLog write FFileLog;

  end;

implementation

{ TLog }

constructor TLog.Create;
begin
  CreateFileLog;
end;

procedure TLog.CreateFileLog;
begin
  if not(FileExists(ExtractFilePath(Application.ExeName + 'Server.log'))) then
    Rewrite(FileLog,ExtractFilePath(Application.ExeName + 'Server.log'));
  AssignFile(FileLog, ExtractFilePath(Application.ExeName + 'Server.log'));
end;

destructor TLog.Destroy;
begin
  CloseFile(FileLog);
end;

class function TLog.GetInstance: TLog;
begin
  Result := Self.Create;
end;

procedure TLog.OnException(Sender: TObject; E: Exception);
begin
  Writeln(TObject(Sender).ClassName);



end;

end.
