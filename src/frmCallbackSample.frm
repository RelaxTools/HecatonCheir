VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCallbackSample 
   Caption         =   "Callback�T���v��"
   ClientHeight    =   2505
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3990
   OleObjectBlob   =   "frmCallbackSample.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmCallbackSample"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Callback�N���X�T���v��

Private WithEvents CB As Callback
Attribute CB.VB_VarHelpID = -1

'���j�[�N�Ȕԍ����`
Private Enum ActionConstants
    ActionMessageInfo = 0
    ActionMessageExcl
    DeleyExec
End Enum

Private Sub UserForm_Initialize()
    Set CB = New Callback
End Sub
Private Sub UserForm_Terminate()
    Set CB = Nothing
End Sub
' �E�N���b�N���j���[�\��
Private Sub UserForm_MouseDown(ByVal Button As Integer, ByVal Shift As Integer, ByVal x As Single, ByVal y As Single)
    
    '�E�N���b�N
    If Button <> 2 Then
        Exit Sub
    End If
    
    'OnAction ��CreateOnAction���\�b�h�Ɣԍ���ݒ�
    With CommandBars.Add(Position:=msoBarPopup, Temporary:=True)

        With .Controls.Add
            .BeginGroup = True
            .Caption = "��񃁃b�Z�[�W"
            .OnAction = CB.CreateOnAction(ActionMessageInfo)
            .FaceId = 535
        End With
        With .Controls.Add
            .Caption = "�x�����b�Z�[�W"
            .OnAction = CB.CreateOnAction(ActionMessageExcl)
            .FaceId = 534
        End With
        
        .ShowPopup
    
    End With
    
End Sub
'OnTime�ɂ��g����
Private Sub CommandButton1_Click()
    '�R�b��Ɏ��s
    Process.UnsyncRun CB.CreateOnAction(DeleyExec), 3
End Sub

'���ۂ̏������L�q����C�x���g
Private Sub CB_OnAction(ByVal Action As Long, ByVal opt As String)

    '���s���ꂽ�ԍ����߂��Ă���
    Select Case Action
        Case ActionMessageInfo
            MsgBox "��񃁃b�Z�[�W", vbInformation
        Case ActionMessageExcl
            MsgBox "�x�����b�Z�[�W", vbExclamation
        Case DeleyExec
            MsgBox "�R�b�o���܂���", vbInformation
    End Select

End Sub

