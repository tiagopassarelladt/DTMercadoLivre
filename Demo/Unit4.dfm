object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Demo - Mercado Livre'
  ClientHeight = 394
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 88
    Width = 589
    Height = 306
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 35
    Width = 121
    Height = 25
    Caption = 'Publicar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '7892509117012'
  end
  object edtDescricao: TEdit
    Left = 135
    Top = 8
    Width = 298
    Height = 21
    TabOrder = 3
    Text = 'A71 CELULAR SANSUNG'
  end
  object MercadoLivre1: TMercadoLivre
    Left = 536
    Top = 8
  end
end
