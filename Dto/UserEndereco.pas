unit UserEndereco;

interface

uses
  Pkg1.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TCity = class;
  TCountry = class;
  TFriday = class;
  THours = class;
  TMonday = class;
  TMunicipality = class;
  TNeighborhood = class;
  TOnHolidays = class;
  TOpenHours = class;
  TSearchLocation = class;
  TState = class;
  TThursday = class;
  TTuesday = class;
  TWednesday = class;

  THours = class
  end;
  
  TOnHolidays = class(TJsonDTO)
  private
    [JSONName('hours'), JSONMarshalled(False)]
    FHoursArray: TArray<THours>;
    [GenericListReflect]
    FHours: TObjectList<THours>;
    FStatus: string;
    function GetHours: TObjectList<THours>;
  protected
    function GetAsJson: string; override;
  published
    property Hours: TObjectList<THours> read GetHours;
    property Status: string read FStatus write FStatus;
  public
    destructor Destroy; override;
  end;
  
  TFriday = class
  private
    FFrom: string;
    FTo: string;
  published
    property From: string read FFrom write FFrom;
    property &To: string read FTo write FTo;
  end;
  
  TThursday = class
  private
    FFrom: string;
    FTo: string;
  published
    property From: string read FFrom write FFrom;
    property &To: string read FTo write FTo;
  end;
  
  TWednesday = class
  private
    FFrom: string;
    FTo: string;
  published
    property From: string read FFrom write FFrom;
    property &To: string read FTo write FTo;
  end;
  
  TTuesday = class
  private
    FFrom: string;
    FTo: string;
  published
    property From: string read FFrom write FFrom;
    property &To: string read FTo write FTo;
  end;
  
  TMonday = class
  private
    FFrom: string;
    FTo: string;
  published
    property From: string read FFrom write FFrom;
    property &To: string read FTo write FTo;
  end;
  
  TOpenHours = class(TJsonDTO)
  private
    [JSONName('friday'), JSONMarshalled(False)]
    FFridayArray: TArray<TFriday>;
    [GenericListReflect]
    FFriday: TObjectList<TFriday>;
    [JSONName('monday'), JSONMarshalled(False)]
    FMondayArray: TArray<TMonday>;
    [GenericListReflect]
    FMonday: TObjectList<TMonday>;
    [JSONName('on_holidays')]
    FOnHolidays: TOnHolidays;
    [JSONName('thursday'), JSONMarshalled(False)]
    FThursdayArray: TArray<TThursday>;
    [GenericListReflect]
    FThursday: TObjectList<TThursday>;
    [JSONName('tuesday'), JSONMarshalled(False)]
    FTuesdayArray: TArray<TTuesday>;
    [GenericListReflect]
    FTuesday: TObjectList<TTuesday>;
    [JSONName('wednesday'), JSONMarshalled(False)]
    FWednesdayArray: TArray<TWednesday>;
    [GenericListReflect]
    FWednesday: TObjectList<TWednesday>;
    function GetFriday: TObjectList<TFriday>;
    function GetMonday: TObjectList<TMonday>;
    function GetThursday: TObjectList<TThursday>;
    function GetTuesday: TObjectList<TTuesday>;
    function GetWednesday: TObjectList<TWednesday>;
  protected
    function GetAsJson: string; override;
  published
    property Friday: TObjectList<TFriday> read GetFriday;
    property Monday: TObjectList<TMonday> read GetMonday;
    property OnHolidays: TOnHolidays read FOnHolidays;
    property Thursday: TObjectList<TThursday> read GetThursday;
    property Tuesday: TObjectList<TTuesday> read GetTuesday;
    property Wednesday: TObjectList<TWednesday> read GetWednesday;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
  TNeighborhood = class
  private
    FName: string;
  published
    property Name: string read FName write FName;
  end;
  
  TCity = class
  private
    FId: string;
    FName: string;
  published
    property Id: string read FId write FId;
    property Name: string read FName write FName;
  end;
  
  TState = class
  private
    FId: string;
    FName: string;
  published
    property Id: string read FId write FId;
    property Name: string read FName write FName;
  end;
  
  TSearchLocation = class
  private
    FCity: TCity;
    FNeighborhood: TNeighborhood;
    FState: TState;
  published
    property City: TCity read FCity;
    property Neighborhood: TNeighborhood read FNeighborhood;
    property State: TState read FState;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TMunicipality = class
  end;
  
  TCountry = class
  private
    FId: string;
    FName: string;
  published
    property Id: string read FId write FId;
    property Name: string read FName write FName;
  end;
  
  TEndereco = class(TJsonDTO)
  private
    [JSONName('address_line')]
    FAddressLine: string;
    [JSONName('address_type')]
    FAddressType: string;
    FCity: TCity;
    FContact: string;
    FCountry: TCountry;
    [SuppressZero, JSONName('date_created')]
    FDateCreated: TDateTime;
    [SuppressZero, JSONName('geolocation_last_updated')]
    FGeolocationLastUpdated: TDateTime;
    [JSONName('geolocation_source')]
    FGeolocationSource: string;
    [JSONName('geolocation_type')]
    FGeolocationType: string;
    FId: Integer;
    FLatitude: Double;
    FLongitude: Double;
    FMunicipality: TMunicipality;
    FNeighborhood: TNeighborhood;
    FNormalized: Boolean;
    [JSONName('open_hours')]
    FOpenHours: TOpenHours;
    FPhone: string;
    [JSONName('search_location')]
    FSearchLocation: TSearchLocation;
    FState: TState;
    FStatus: string;
    [JSONName('street_name')]
    FStreetName: string;
    [JSONName('street_number')]
    FStreetNumber: string;
    [JSONName('types')]
    FTypesArray: TArray<string>;
    [JSONMarshalled(False)]
    FTypes: TList<string>;
    [JSONName('user_id')]
    FUserId: Integer;
    [JSONName('zip_code')]
    FZipCode: string;
    function GetTypes: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property AddressLine: string read FAddressLine write FAddressLine;
    property AddressType: string read FAddressType write FAddressType;
    property City: TCity read FCity;
    property Contact: string read FContact write FContact;
    property Country: TCountry read FCountry;
    property DateCreated: TDateTime read FDateCreated write FDateCreated;
    property GeolocationLastUpdated: TDateTime read FGeolocationLastUpdated write FGeolocationLastUpdated;
    property GeolocationSource: string read FGeolocationSource write FGeolocationSource;
    property GeolocationType: string read FGeolocationType write FGeolocationType;
    property Id: Integer read FId write FId;
    property Latitude: Double read FLatitude write FLatitude;
    property Longitude: Double read FLongitude write FLongitude;
    property Municipality: TMunicipality read FMunicipality;
    property Neighborhood: TNeighborhood read FNeighborhood;
    property Normalized: Boolean read FNormalized write FNormalized;
    property OpenHours: TOpenHours read FOpenHours;
    property Phone: string read FPhone write FPhone;
    property SearchLocation: TSearchLocation read FSearchLocation;
    property State: TState read FState;
    property Status: string read FStatus write FStatus;
    property StreetName: string read FStreetName write FStreetName;
    property StreetNumber: string read FStreetNumber write FStreetNumber;
    property Types: TList<string> read GetTypes;
    property UserId: Integer read FUserId write FUserId;
    property ZipCode: string read FZipCode write FZipCode;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TUserEndereco = class(TJsonDTO)
  private
    [JSONName('Items'), JSONMarshalled(False)]
    FItemsArray: TArray<TEndereco>;
    [GenericListReflect]
    FItems: TObjectList<TEndereco>;
    function GetItems: TObjectList<TEndereco>;
  protected
    function GetAsJson: string; override;
  published
    property Items: TObjectList<TEndereco> read GetItems;
  public
    destructor Destroy; override;
  end;
  
implementation

{ TOnHolidays }

destructor TOnHolidays.Destroy;
begin
  GetHours.Free;
  inherited;
end;

function TOnHolidays.GetHours: TObjectList<THours>;
begin
  Result := ObjectList<THours>(FHours, FHoursArray);
end;

function TOnHolidays.GetAsJson: string;
begin
  RefreshArray<THours>(FHours, FHoursArray);
  Result := inherited;
end;

{ TOpenHours }

constructor TOpenHours.Create;
begin
  inherited;
  FOnHolidays := TOnHolidays.Create;
end;

destructor TOpenHours.Destroy;
begin
  FOnHolidays.Free;
  GetMonday.Free;
  GetTuesday.Free;
  GetWednesday.Free;
  GetThursday.Free;
  GetFriday.Free;
  inherited;
end;

function TOpenHours.GetFriday: TObjectList<TFriday>;
begin
  Result := ObjectList<TFriday>(FFriday, FFridayArray);
end;

function TOpenHours.GetMonday: TObjectList<TMonday>;
begin
  Result := ObjectList<TMonday>(FMonday, FMondayArray);
end;

function TOpenHours.GetThursday: TObjectList<TThursday>;
begin
  Result := ObjectList<TThursday>(FThursday, FThursdayArray);
end;

function TOpenHours.GetTuesday: TObjectList<TTuesday>;
begin
  Result := ObjectList<TTuesday>(FTuesday, FTuesdayArray);
end;

function TOpenHours.GetWednesday: TObjectList<TWednesday>;
begin
  Result := ObjectList<TWednesday>(FWednesday, FWednesdayArray);
end;

function TOpenHours.GetAsJson: string;
begin
  RefreshArray<TFriday>(FFriday, FFridayArray);
  RefreshArray<TMonday>(FMonday, FMondayArray);
  RefreshArray<TThursday>(FThursday, FThursdayArray);
  RefreshArray<TTuesday>(FTuesday, FTuesdayArray);
  RefreshArray<TWednesday>(FWednesday, FWednesdayArray);
  Result := inherited;
end;

{ TSearchLocation }

constructor TSearchLocation.Create;
begin
  inherited;
  FState := TState.Create;
  FCity := TCity.Create;
  FNeighborhood := TNeighborhood.Create;
end;

destructor TSearchLocation.Destroy;
begin
  FState.Free;
  FCity.Free;
  FNeighborhood.Free;
  inherited;
end;

{ TItems }

constructor TEndereco.Create;
begin
  inherited;
  FCity := TCity.Create;
  FState := TState.Create;
  FCountry := TCountry.Create;
  FNeighborhood := TNeighborhood.Create;
  FMunicipality := TMunicipality.Create;
  FSearchLocation := TSearchLocation.Create;
  FOpenHours := TOpenHours.Create;
end;

destructor TEndereco.Destroy;
begin
  FCity.Free;
  FState.Free;
  FCountry.Free;
  FNeighborhood.Free;
  FMunicipality.Free;
  FSearchLocation.Free;
  FOpenHours.Free;
  GetTypes.Free;
  inherited;
end;

function TEndereco.GetTypes: TList<string>;
begin
  Result := List<string>(FTypes, FTypesArray);
end;

function TEndereco.GetAsJson: string;
begin
  RefreshArray<string>(FTypes, FTypesArray);
  Result := inherited;
end;

{ TRoot }

destructor TUserEndereco.Destroy;
begin
  GetItems.Free;
  inherited;
end;

function TUserEndereco.GetItems: TObjectList<TEndereco>;
begin
  Result := ObjectList<TEndereco>(FItems, FItemsArray);
end;

function TUserEndereco.GetAsJson: string;
begin
  RefreshArray<TEndereco>(FItems, FItemsArray);
  Result := inherited;
end;

end.
