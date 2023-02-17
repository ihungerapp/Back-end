unit Server.Interfaces.Authentication;

interface

uses
  Web.HTTPApp;

type

  iAuthentication = interface
    ['{305A7DE7-ECB5-41E6-A53C-F474E31C64DA}']
    function Authenticate(Request: TWebRequest; Response: TWebResponse) : Boolean;
  end;

implementation

end.
