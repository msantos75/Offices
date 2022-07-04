object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Offices'
  ClientHeight = 293
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 593
    Height = 273
    Caption = 'List of Offices'
    TabOrder = 0
    object LabelCountOffices: TLabel
      Left = 20
      Top = 231
      Width = 95
      Height = 15
      Caption = '0 offices in the list'
    end
    object ListOffices: TListView
      Left = 20
      Top = 26
      Width = 554
      Height = 199
      Columns = <
        item
          Caption = 'Id'
        end
        item
          Caption = 'Name'
          Width = 225
        end
        item
          Caption = 'Country'
          Width = 125
        end
        item
          Caption = 'GMT'
        end
        item
          Caption = 'Start Date'
          Width = 80
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnCustomDrawItem = ListOfficesCustomDrawItem
    end
    object ButtonInsert: TButton
      Left = 337
      Top = 231
      Width = 75
      Height = 25
      Caption = '&Insert'
      TabOrder = 1
      OnClick = ButtonInsertClick
    end
    object ButtonEdit: TButton
      Left = 418
      Top = 231
      Width = 75
      Height = 25
      Caption = '&Edit'
      TabOrder = 2
      OnClick = ButtonEditClick
    end
    object ButtonDelete: TButton
      Left = 499
      Top = 231
      Width = 75
      Height = 25
      Caption = '&Delete'
      TabOrder = 3
      OnClick = ButtonDeleteClick
    end
  end
  object Query: TFDQuery
    Connection = DataModule1.FDConnection
    Left = 520
    Top = 160
  end
end
