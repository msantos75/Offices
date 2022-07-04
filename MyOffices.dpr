program MyOffices;

uses
  Vcl.Forms,
  UnitFormMain in 'UnitFormMain.pas' {FormMain},
  UnitTableClasses in 'UnitTableClasses.pas',
  UnitInterfaces in 'UnitInterfaces.pas',
  UnitClassOffice in 'UnitClassOffice.pas',
  UnitDataModule in 'UnitDataModule.pas' {DataModule1: TDataModule},
  UnitFormOffice in 'UnitFormOffice.pas' {FormOffice};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
