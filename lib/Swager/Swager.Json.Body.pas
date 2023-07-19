unit Swager.Json.Body;

interface

uses
  Swager.Json.DTO,
  sysutils,
  classes, System.Generics.Collections;
  const
    _ctServer ='rmti.tec.br:8081';
{$M+}

type

  TcontactDTO = class
  private
    Femail: string;
  published
    property email: string read Femail write Femail;
  public
    constructor Create;
  end;

  TlicenseDTO = class
  private
    Fname: string;
    Furl: string;
  published
    property name: string read Fname write Fname;
    property url: string read Furl write Furl;
  public
    constructor Create;
  end;

  TinfoDTO = class
  private
    Fversion: string;
    Ftitle: string;
    Fdescription: string;
    FtermsOfService: string;
    Fcontact: TcontactDTO;
    Flicense: TlicenseDTO;
  published
    property version: string read Fversion write Fversion;
    property title: string read Ftitle write Ftitle;
    property description: string read Fdescription write Fdescription;
    property termsOfService: string read FtermsOfService write FtermsOfService;
    property contact: TcontactDTO read Fcontact write Fcontact;
    property license: TlicenseDTO read Flicense write Flicense;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TBearerAuthDTO = class
  private
    Ftype: string;
    Fin: string;
    Fname: string;
  published
    property &type: string read Ftype write Ftype;
    property &in: string read Fin write Fin;
    property name: string read Fname write Fname;
  public
    constructor Create;
  end;

  TsecurityDefinitionsDTO = class
  private
    FBearerAuth: TBearerAuthDTO;
  published
    property BearerAuth: TBearerAuthDTO read FBearerAuth write FBearerAuth;
  public
    constructor Create;
  end;

  TsecurityDTO = class
  private
    FBearerAuth: TArray<string>;
  published
    property BearerAuth: TArray<string> read FBearerAuth write FBearerAuth;
  end;

  TcomponentsDTO = class
    FsecuritySchemes: TsecurityDefinitionsDTO;
  published
    property securitySchemes: TsecurityDefinitionsDTO read FsecuritySchemes write FsecuritySchemes;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  Tpaths = class
  private

  end;

  Tdefinitions = class

  end;

  TServer = class
  private
   Furl: String;
  published
    property url: String read Furl write Furl;
  end;

  TRootDTO = class(TJsonDTO)
  private
    Fopenapi: string;
    Finfo: TinfoDTO;
    [JSONName('servers'), JSONMarshalled(False)]
    FServersArray: TArray<TServer>;
    [GenericListReflect]
    FServers: TObjectList<TServer>;
    Fcomponents: TcomponentsDTO;
    Fsecurity: TsecurityDTO;
    Fpaths: Tpaths;
    Fdefinitions: Tdefinitions;
    function GetServers: TObjectList<TServer>;
  protected
    function GetAsJson: string; override;
  published
    property openapi: string read Fopenapi write Fopenapi;
    property info: TinfoDTO read Finfo write Finfo;
    property servers: TObjectList<TServer> read GetServers;
    property components: TcomponentsDTO read Fcomponents write Fcomponents;
    property security: TsecurityDTO read Fsecurity write Fsecurity;
    property paths: Tpaths read Fpaths write Fpaths;
    property definitions: Tdefinitions read Fdefinitions write Fdefinitions;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TRootDTO }
constructor TRootDTO.Create;
begin
  inherited;
  Fopenapi := '3.0.3';
  Finfo := TinfoDTO.Create;
  Fcomponents := TcomponentsDTO.Create;
  Fsecurity := TsecurityDTO.Create;
  Fpaths := Tpaths.Create;
  Fdefinitions := Tdefinitions.Create;
end;

destructor TRootDTO.Destroy;
begin

  inherited;
end;

function TRootDTO.GetAsJson: string;
begin
  RefreshArray<TServer>(FServers, FServersArray);
  Result := inherited;
end;

function TRootDTO.GetServers: TObjectList<TServer>;
begin
  Result := ObjectList<TServer>(FServers, FServersArray);
end;

{ TcomponentsDTO }

constructor TcomponentsDTO.Create;
begin
  inherited;
  FsecuritySchemes := TsecurityDefinitionsDTO.Create;
end;

destructor TcomponentsDTO.Destroy;
begin
  FreeAndNil(FsecuritySchemes);
  inherited;
end;

{ TinfoDTO }

constructor TinfoDTO.Create;
begin
  inherited;
  Fversion := '1.0.0';
  Ftitle := 'HungerApp API v1.0.0';
  Fdescription := 'Documentaçao do projeto';
  FtermsOfService := 'http://www.apache.org/licenses/LICENSE-2.0.txt';
  Fcontact := TcontactDTO.Create;
  Flicense := TlicenseDTO.Create;

end;

destructor TinfoDTO.Destroy;
begin
  FreeAndNil(Fcontact);
  FreeAndNil(Flicense);
  inherited;
end;

{ TcontactDTO }

constructor TcontactDTO.Create;
begin
  Femail := 'matheus@rmti.tec.br';
end;

{ TlicenseDTO }

constructor TlicenseDTO.Create;
begin
  Fname := 'Apache License - Version 2.0, January 2004';
  Furl := 'http://www.apache.org/licenses/LICENSE-2.0';
end;

{ TsecurityDefinitionsDTO }

constructor TsecurityDefinitionsDTO.Create;
begin
  FBearerAuth := TBearerAuthDTO.Create;
end;

{ TBearerAuthDTO }

constructor TBearerAuthDTO.Create;
begin
  Ftype := 'apiKey';
  Fin := 'header';
  Fname := 'x-api-key';
end;

end.
