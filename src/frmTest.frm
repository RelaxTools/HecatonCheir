VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmTest 
   Caption         =   "Hdennotare Test"
   ClientHeight    =   3705
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8310.001
   OleObjectBlob   =   "frmTest.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Dim FM As IFormManager

Private Sub IList_Add(obj As Variant)

End Sub

Private Sub IList_Clear()

End Sub

Private Sub UserForm_Initialize()

    lblBack.Tag = "m"
    lblGauge.Tag = "g"
    cmdOk.Tag = "c"

    Set FM = FormManager.NewInstance(Me)

    Dim i As Long
    Dim strBuf As String

    With lvTest
        
        .View = lvwReport           ''�\��
        .LabelEdit = lvwManual      ''���x���̕ҏW
        .HideSelection = False      ''�I���̎�������
        .AllowColumnReorder = False  ''�񕝂̕ύX������
        .FullRowSelect = True       ''�s�S�̂�I��
        .Gridlines = True           ''�O���b�h��
 
        .ColumnHeaders.Add , "_Name", "���\�b�h", .Width - 16
  
    End With
  
    With ThisWorkbook.VBProject.VBComponents("Test").CodeModule
            
        For i = 1 To .CountOfLines
            
            '�w��ʒu����P�s�擾
            strBuf = .Lines(i, 1)
            
            If RegExp.Test(strBuf, "^Sub Test.*\)$") Then
            
                With lvTest.ListItems.Add
                    .Text = Replace(Mid$(strBuf, 5), "()", "")
                End With
            
            End If
    
        Next
    End With

    FM.DispGuidance "�e�X�g��ǂݍ��݂܂����B"

End Sub

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
    '���s�����H
    If FM.IsRunning Then
        '�t�H�[���������Ȃ��悤�ɂ���
        Cancel = True
    End If
End Sub

Private Sub UserForm_Terminate()
    Set FM = Nothing
End Sub
Private Sub cmdOk_Click()

    '���s�����H���s���͒��f�{�^���ɂȂ�̂ŁA�L�����Z������B
    If FM.IsRunning Then
        '�L�����Z�������s����
        FM.doCancel
        Exit Sub
    End If

    If Message.Question("���s���܂��B��낵���ł����H") Then
        Exit Sub
    End If

    Dim lngMax As Long
    Dim i As Long
    
    With Using.NewInstance(FM, New OneTimeSpeedBooster)
        
        lngMax = lvTest.ListItems.Count
    
        '�Q�[�W�̍ő��ݒ�
        FM.StartGauge lngMax
        
        For i = 1 To lngMax
        
            '�L�����Z�����H
            If FM.IsCancel Then
                '�����𒆒f
                Exit For
            End If
        
            '���s
            lvTest.ListItems(i).Selected = True
            lvTest.ListItems(i).EnsureVisible
            
            Application.Run "Test." & lvTest.ListItems(i).Text
            
            Process.Sleep 50
            DoEvents
                    
            '�Q�[�W�̌��ݒl��ݒ�
            FM.DisplayGauge i
        Next
    
    End With
    
    '�L�����Z�����H
    If FM.IsCancel Then
        FM.DispGuidance "�e�X�g�͒��f����܂����B"
    Else
        FM.DispGuidance "�e�X�g���������܂����B"
    End If

End Sub
Private Sub cmdCancel_Click()
    Unload Me
End Sub

