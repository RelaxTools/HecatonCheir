VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmFormManagerSample 
   Caption         =   "UserForm1"
   ClientHeight    =   3705
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8445.001
   OleObjectBlob   =   "frmFormManagerSample.frx":0000
   StartUpPosition =   1  '�I�[�i�[ �t�H�[���̒���
End
Attribute VB_Name = "frmFormManagerSample"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim FM As IFormManager

'FormManager�T���v��

Private Sub UserForm_Initialize()

'--------------------------------------------------------------------
    '�킩��₷���R�[�h�ŏ����Ă��܂����A�v���p�e�B��
    '�ݒ肵�Ă��܂��Ă��܂��܂���B
    
    '���b�Z�[�W�y�уv���O���X�o�[�̔w�i��\�����郉�x����Tag��"m"��ݒ肷��B
    lblBack.Tag = "m"
    
    '�v���O���X�o�[��\�����郉�x����Tag��"g"��ݒ肷��B
    lblGauge.Tag = "g"
    
    '�L�����Z���{�^����Tag��"c"��ݒ肷��B
    cmdOk.Tag = "c"
    
    '���s���ł��񊈐��ɂ��Ȃ��R���g���[����Tag��"e"��ݒ肷��B
    lblEnabled.Tag = "e"
    
'--------------------------------------------------------------------

    Set FM = FormManager.NewInstance(Me)

    FM.DispGuidance "�J�n���܂����B"

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
    
    '��������\���B�ȉ����\�b�h���ĂԂ�Using�N���X���g�p����B
    'FM.StartRunning
    With Using.NewInstance(FM, New OneTimeSpeedBooster)
        
        lngMax = 10000
    
        '�Q�[�W�̍ő��ݒ�
        FM.StartGauge lngMax
        
        For i = 1 To lngMax
        
            '�L�����Z�����H
            If FM.IsCancel Then
                '�����𒆒f
                Exit For
            End If
        
        
            '�������L�q
        
        
            '�Q�[�W�̌��ݒl��ݒ�
            FM.DisplayGauge i
        Next
    
    End With
    '�����I����\��
    'FM.StopRunning
    
    '�L�����Z�����H
    If FM.IsCancel Then
        Message.Error "�����͒��f����܂����B"
    Else
        Message.Information "�������܂����B"
    End If

End Sub
Private Sub cmdCancel_Click()
    Unload Me
End Sub

