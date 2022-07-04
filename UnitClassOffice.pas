unit UnitClassOffice;

interface

uses
  UnitInterfaces, UnitTableClasses;

type
  TOffice = class(TInterfacedObject, IOffice)
  private
    function LoadOffice(const Id: Integer): TOfficesTable;
    function InsertOffice(const ATable: TOfficesTable; const Including: Boolean): Boolean;
    function DeleteOffice(const Id: Integer): Boolean;
    function OfficeGetNextId: Integer;
  public
    class function New: IOffice;
  end;

implementation

uses
  UnitDataModule, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  System.SysUtils, Vcl.Dialogs, System.UITypes;

{ TOfficesTable }

function TOffice.InsertOffice(const ATable: TOfficesTable; const Including: Boolean): Boolean;
var Query : TFDQuery;
begin
  Result := False;
  DataModule1.FDConnection.StartTransaction;
  try
    Query := TFDQuery.Create(nil);
    try
      With Query, ATable do
      begin
        Connection := DataModule1.FDConnection;
        Close;
        SQL.Clear;
        SQL.Add('UPDATE OR INSERT INTO OFFICES(ID, NAME, COUNTRY, GMT, STARTDATE)');
        SQL.Add('VALUES(:ID, :NAME, :COUNTRY, :GMT, :STARTDATE)');
        SQL.Add('MATCHING (ID)');
        If Including then
          ParamByName('ID').AsInteger := OfficeGetNextId else
          ParamByName('ID').AsInteger := Id;
        ParamByName('NAME').AsString := Name;
        ParamByName('COUNTRY').AsString := Country;
        ParamByName('GMT').AsInteger := GMT;
        ParamByName('STARTDATE').AsDate := StartDate;
        ExecSQL;

        Result := RowsAffected > 0;
      end;
    finally
      Query.Free;
    end;

    If Result then DataModule1.FDConnection.Commit;
  except
    On E : Exception do
    begin
      DataModule1.FDConnection.Rollback;
      MessageDlg('Error adding/updating office. ' + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

function TOffice.LoadOffice(const Id: Integer): TOfficesTable;
var Query : TFDQuery;
begin
  Result := nil;
  Query := TFDQuery.Create(nil);
  try
    With Query do
    begin
      Connection := UnitDataModule.DataModule1.FDConnection;
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM OFFICES');
      SQL.Add('WHERE ID=:ID');
      ParamByName('ID').AsInteger := Id;
      Open;
      If IsEmpty then Exit;

      Result := TOfficesTable.Create;
      With Result do
      begin
        Id := FieldByName('ID').AsInteger;
        Name := FieldByName('NAME').AsString;
        Country := FieldByName('COUNTRY').AsString;
        GMT := FieldByName('GMT').AsInteger;
        StartDate := FieldByName('STARTDATE').AsDateTime;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function TOffice.DeleteOffice(const Id: Integer): Boolean;
var Query : TFDQuery;
begin
  Result := False;
  DataModule1.FDConnection.StartTransaction;
  try
    Query := TFDQuery.Create(nil);
    try
      With Query do
      begin
        Connection := DataModule1.FDConnection;
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM OFFICES');
        SQL.Add('WHERE ID=:ID');
        ParamByName('ID').AsInteger := Id;
        ExecSQL;

        Result := RowsAffected > 0;
      end;
    finally
      Query.Free;
    end;

    If Result then DataModule1.FDConnection.Commit;
  except
    On E : Exception do
    begin
      DataModule1.FDConnection.Rollback;
      MessageDlg('Error deleting office. ' + E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

class function TOffice.New: IOffice;
begin
  Result := Self.Create;
end;

function TOffice.OfficeGetNextId: Integer;
var Query : TFDQuery;
begin
  Result := 1;
  Query := TFDQuery.Create(nil);
  try
    With Query do
    begin
      Connection := DataModule1.FDConnection;
      Close;
      SQL.Clear;
      SQL.Add('SELECT MAX(ID) FROM OFFICES');
      Open;
      If IsEmpty then Exit;
      Result := Fields[0].AsInteger + 1;
    end;
  finally
    Query.Free;
  end;
end;

end.
