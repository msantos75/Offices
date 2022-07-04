object FormOffice: TFormOffice
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Offices'
  ClientHeight = 183
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 497
    Height = 129
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 68
      Height = 15
      Caption = 'Office name:'
    end
    object Label2: TLabel
      Left = 16
      Top = 53
      Width = 46
      Height = 15
      Caption = 'Country:'
    end
    object Label3: TLabel
      Left = 16
      Top = 82
      Width = 28
      Height = 15
      Caption = 'GMT:'
    end
    object Label4: TLabel
      Left = 288
      Top = 82
      Width = 54
      Height = 15
      Caption = 'Start Date:'
    end
    object EditName: TEdit
      Left = 104
      Top = 21
      Width = 369
      Height = 23
      MaxLength = 100
      TabOrder = 0
    end
    object EditCountry: TEdit
      Left = 104
      Top = 50
      Width = 369
      Height = 23
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
    end
    object EditGMT: TEdit
      Left = 104
      Top = 79
      Width = 57
      Height = 23
      MaxLength = 3
      TabOrder = 2
      OnExit = EditGMTExit
    end
    object EditStartDate: TEdit
      Left = 368
      Top = 79
      Width = 105
      Height = 23
      MaxLength = 10
      TabOrder = 3
      OnExit = EditStartDateExit
      OnKeyPress = EditStartDateKeyPress
    end
  end
  object ButtonOk: TButton
    Left = 336
    Top = 143
    Width = 81
    Height = 25
    Caption = 'O&k'
    TabOrder = 1
    OnClick = ButtonOkClick
  end
  object ButtonCancel: TButton
    Left = 423
    Top = 143
    Width = 82
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
