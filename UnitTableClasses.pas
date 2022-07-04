unit UnitTableClasses;

interface

type
  TOfficesTable = class(TObject)
  private
    FId: Integer;
    FName: String;
    FGMT: Integer;
    FCountry: String;
    FStartDate: TDate;
    procedure SetFId(const Value: Integer);
    procedure SetCountry(const Value: String);
    procedure SetGMT(const Value: Integer);
    procedure SetName(const Value: String);
    procedure SetStartDate(const Value: TDate);
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write SetFId;
    property Name: String read FName write SetName;
    property Country: String read FCountry write SetCountry;
    property GMT: Integer read FGMT write SetGMT;
    property StartDate: TDate read FStartDate write SetStartDate;
  end;

implementation

{ TOfficesTable }

procedure TOfficesTable.SetCountry(const Value: String);
begin
  FCountry := Value;
end;

procedure TOfficesTable.SetFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TOfficesTable.SetGMT(const Value: Integer);
begin
  FGMT := Value;
end;

procedure TOfficesTable.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TOfficesTable.SetStartDate(const Value: TDate);
begin
  FStartDate := Value;
end;

constructor TOfficesTable.Create;
begin
  inherited Create;
  FId := 0;
  FName := '';
  FGMT := 0;
  FCountry := '';
  FStartDate := 0;
end;

destructor TOfficesTable.Destroy;
begin
  inherited Destroy;
end;

end.
