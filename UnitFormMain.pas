unit UnitFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Grids, Vcl.DBGrids, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormMain = class(TForm)
    GroupBox1: TGroupBox;
    ListOffices: TListView;
    ButtonInsert: TButton;
    ButtonEdit: TButton;
    ButtonDelete: TButton;
    Query: TFDQuery;
    LabelCountOffices: TLabel;
    procedure ButtonInsertClick(Sender: TObject);
    procedure RefreshList;
    procedure FormShow(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ListOfficesCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  UnitDataModule, UnitClassOffice, UnitTableClasses, UnitInterfaces, UnitFormOffice,
  Vcl.Dialogs, System.UITypes;

{$R *.dfm}

procedure TFormMain.ButtonDeleteClick(Sender: TObject);
begin
  If not Assigned(ListOffices.Selected) then Exit;

  If MessageDlg('Confirm delete item with Id nº ' + ListOffices.Selected.Caption + '?', mtWarning, [mbYes, mbNo], 0) <> ID_YES then Exit;

  ListOffices.Items.BeginUpdate;
  try
    If TOffice.New.DeleteOffice(StrToIntDef(ListOffices.Selected.Caption, 0)) then
      RefreshList;
  finally
    ListOffices.Items.EndUpdate;
  end;
end;

procedure TFormMain.ButtonEditClick(Sender: TObject);
var OfficeTable : TOfficesTable;
    Id : Integer;
begin
  If not Assigned(ListOffices.Selected) then
  begin
    MessageDlg('Select an item to edit.', TMsgDlgType.mtInformation, [mbOk], 0);
    Exit;
  end;

  Id := StrToIntDef(ListOffices.Selected.Caption ,0);

  OfficeTable := TOffice.New.LoadOffice(Id);
  If Assigned(OfficeTable) then
  try
    If EditOffice(OfficeTable, False) then
      If TOffice.New.InsertOffice(OfficeTable, False) then
      begin
        MessageDlg('Office updated sucessfully.', TMsgDlgType.mtInformation, [mbOk], 0);
        RefreshList;
      end;
  finally
    OfficeTable.Free;
  end;
end;

procedure TFormMain.ButtonInsertClick(Sender: TObject);
var OfficeTable : TOfficesTable;
begin
  OfficeTable := TOfficesTable.Create;
  try
    If EditOffice(OfficeTable, True) then
      If TOffice.New.InsertOffice(OfficeTable, True) then
      begin
        MessageDlg('New office added sucessfully.', TMsgDlgType.mtInformation, [mbOk], 0);
        RefreshList;
      end;
  finally
    OfficeTable.Free;
  end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  RefreshList;
end;

procedure TFormMain.ListOfficesCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  If Odd(Item.Index) then
    Sender.Canvas.Brush.Color := clBtnFace
  else
    Sender.Canvas.Brush.Color := clWindow;
end;

procedure TFormMain.RefreshList;
begin
  With Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM OFFICES');
    SQL.Add('ORDER BY ID');
    Open;

    ListOffices.Items.Clear;

    While not Eof do
    begin
      ListOffices.Items.BeginUpdate;
      try
        With ListOffices.Items.Add do
        begin
          Caption := FieldByName('ID').AsString;
          SubItems.Add(FieldByName('NAME').AsString);
          SubItems.Add(FieldByName('COUNTRY').AsString);
          SubItems.Add(FieldByName('GMT').AsString);
          SubItems.Add(FieldByName('STARTDATE').AsString);
        end;
      finally
        ListOffices.Items.EndUpdate;
        ListOffices.Selected := ListOffices.TopItem;
      end;
      Next;
    end;

    LabelCountOffices.Caption := IntToStr(RecordCount) + ' offices in the list';
  end;
end;

end.
