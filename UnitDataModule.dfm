object DataModule1: TDataModule1
  Height = 231
  Width = 390
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=C:\Sistemas\Offices\OFFICES.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    Left = 72
    Top = 48
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 72
    Top = 120
  end
end
