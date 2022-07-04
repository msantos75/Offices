unit UnitFormOffice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitTableClasses, Vcl.StdCtrls;

type
  TFormOffice = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditName: TEdit;
    Label2: TLabel;
    EditCountry: TEdit;
    Label3: TLabel;
    EditGMT: TEdit;
    Label4: TLabel;
    EditStartDate: TEdit;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    procedure EditGMTExit(Sender: TObject);
    procedure EditStartDateExit(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditStartDateKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function EditOffice(const OfficeTable: TOfficesTable; const Including: Boolean): Boolean;

implementation

{$R *.dfm}

uses System.UITypes;

function EditOffice(const OfficeTable: TOfficesTable; const Including: Boolean): Boolean;
var Form : TFormOffice;
begin
  Result := False;
  Form := TFormOffice.Create(nil);
  With Form do
  try
    If not Including then
    begin
      With OfficeTable do
      begin
        EditName.Text := Name;
        EditCountry.Text := Country;
        EditGMT.Text := IntToStr(GMT);
        EditStartDate.Text := DateToStr(StartDate);
      end;
    end;

    If ShowModal = mrOk then
    begin
      With OfficeTable do
      begin
        Name := Trim(EditName.Text);
        Country := Trim(EditCountry.Text);
        GMT := StrToIntDef(EditGMT.Text, 0);
        StartDate := StrToDateDef(EditStartDate.Text, 0);
      end;
      Result := True;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFormOffice.ButtonOkClick(Sender: TObject);
begin
  // validates

  If Trim(EditName.Text) = '' then
  begin
    MessageDlg('Invalid office name', mtWarning, [mbOk], 0);
    EditName.SelectAll;
    EditName.SetFocus;
    Exit;
  end;

  ModalResult := mrOk;
end;

procedure TFormOffice.EditGMTExit(Sender: TObject);
var GMT : Integer;
begin
  // check if is a valid GMT value
  If not TryStrToInt(EditGMT.Text, GMT) then
    raise Exception.Create('Not a valid integer value.');

  If (GMT < -12) or (GMT > 12) then
  begin
    MessageDlg('Invalid GMT', mtWarning, [mbOk], 0);
    EditGMT.SelectAll;
    EditGMT.SetFocus;
    Exit;
  end;
end;

procedure TFormOffice.EditStartDateExit(Sender: TObject);
var Start : TDateTime;
begin
  // check if is a valid date
  If not TryStrToDate(Trim(EditStartDate.Text), Start) then
    raise Exception.Create('Invalid date.');
end;

procedure TFormOffice.EditStartDateKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = Char(VK_SPACE) then
  begin
    EditStartDate.Text := DateToStr(Now);
    Key := #0;
  end;
end;

procedure TFormOffice.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If ActiveControl is TEdit then
  begin
    If Key = Char(VK_RETURN) then
    begin
      Key := #0;
      Perform (WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

end.
