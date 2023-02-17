unit Server.Message;

interface

uses
  System.JSON, Web.HTTPApp;

type
  TMessageType = record
    StatusCode: Integer;
    Sucesso: Boolean;
    Mensagem: String;
    Content: TJSONObject;
  end;

  TMessage = class
  private
    FMessage: TMessageType;
  public
    function ToJson: TJSONObject;
    procedure SendMessage(Response: TWebResponse);
    constructor Create(Mensagem: TMessageType; pMessage: String = '');
  end;

implementation

uses
  Datasnap.DSHTTPWebBroker, System.SysUtils, Server.WebModule;

{ TMessage }

procedure TMessage.SendMessage(Response: TWebResponse);
var
  Content: TJSONObject;
begin
  Content := ToJson;
  try
    Response.StatusCode := FMessage.StatusCode;
    Response.Content := Content.ToString;
    Response.SendResponse;
  finally
    Content.Free;
  end;
  Free;
end;

constructor TMessage.Create(Mensagem: TMessageType; pMessage: String = '');
begin
  FMessage := Mensagem;
  if pMessage <> EmptyStr then
    FMessage.Mensagem := FMessage.Mensagem + ' <BR> ' + pMessage;
end;

function TMessage.ToJson: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('sucesso', TJSONBool.Create(FMessage.Sucesso));
  Result.AddPair('mensagem', FMessage.Mensagem);
  if FMessage.Content <> nil then
    Result.AddPair('content', FMessage.Content);
end;

end.

