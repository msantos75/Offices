unit UnitInterfaces;

interface

uses
  UnitTableClasses;

type
  IOffice = interface
    ['{F22A4783-0BF1-49DD-AB67-48765FB867BC}']
    function LoadOffice(const Id: Integer): TOfficesTable;
    function InsertOffice(const ATable: TOfficesTable; const Including: Boolean): Boolean;
    function DeleteOffice(const Id: Integer): Boolean;
    function OfficeGetNextId: Integer;
  end;

implementation

end.
