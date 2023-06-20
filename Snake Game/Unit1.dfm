object MainForm: TMainForm
  Left = 373
  Top = 166
  Width = 408
  Height = 429
  Caption = 'MainForm'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object LabelSnake: TLabel
    Left = 136
    Top = 96
    Width = 117
    Height = 48
    Caption = 'Snake'
    Color = clDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object LabelPlay: TLabel
    Left = 152
    Top = 168
    Width = 81
    Height = 48
    Caption = 'Play'
    Color = clDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = LabelPlayClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 8
    Top = 8
  end
end
