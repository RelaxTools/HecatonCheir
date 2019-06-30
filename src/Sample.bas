Attribute VB_Name = "Sample"
Option Explicit

Sub ICursor_Sample()

    'ICursor �C���^�[�t�F�[�X���g�p����
    Dim IC As ICursor

    '3�s�ڂ��火�Ɍ������ēǂށB
    'B�񂪋󕶎���("")�ɂȂ�����I���B
    Set IC = Constructor(New SheetCursor, Sheet1, 3, "B")

    Do Until IC.Eof

        '�����͗��\����������ԍ����w�肷��B
        'IC.Item("C").Value �ł� IC.Item(3).Value �ł��ǂ��BRange��ԋp�B
        Debug.Print IC("C")
        Debug.Print IC("D")
        Debug.Print IC("E")
        
        IC.MoveNext
    Loop

End Sub

Sub StringBuilder_Sample()

    Dim SB As StringBuilder
    
    Set SB = New StringBuilder
    
    SB.Append "A"
    SB.Append "B"
    SB.Append "C"
    SB.Append "D"
    SB.Append "E"

    '������̘A��
    Debug.Print SB.ToString

    
    Dim S2 As StringBuilder
    
    Set S2 = New StringBuilder
    
    'True������ƃ_�u���R�[�e�[�V�����ň͂�
    S2.Append "red", True
    S2.Append "green", True
    S2.Append "blue", True

    '������̘A���i�J���}��؂�j
    Debug.Print "[" & S2.ToJoin(",") & "]"


End Sub

Sub Message_Sample()


    'Information ���b�Z�[�W
    Message.Information "�T���v���ł��B"

    '���s����ꍇ
    Message.Information "�T���v���ł��B\n���s���ȒP�Ɏg���܂��B"

    '���v���[�X�z���_���g�p����ꍇ
    Message.Information "�T���v���ł��B{0}�̂����łȂ�{1}������", "��", "���_"
    
    '�X�e�[�^�X�o�[
    Message.StatusBar "�T���v���ł��B{0}�̂����łȂ�{1}������", "��", "���_"

    
    '���v���[�X�z���_�̕������ԋp
    Debug.Print Message.PlaceHolder("�T���v���ł��B{0}�̂����łȂ�{1}������", "��", "���_")


End Sub

Sub Using_Sample()

    'IUsing �ɑΉ������N���X�� Using�N���X�̃R���X�g���N�^��
    '�w�肷�邱�Ƃɂ��A�J�n�E�I�����}�l�W�����g����B
    
    'NewExcel           �E�E�ʃv���Z�X��Excel�N���E�I�����s���B
    'OneTimeSpeedBooster�E�E�Čv�Z�AScreenUpdating�y��PrintCommunication�Ȃǂ�
    '                       ��~�E�ĊJ���s���B
    
    'With�ŊJ�n�����AEnd With�ŏI���������s���BC#�ł�Using��̂悤�ȓ�����s���B
    With Constructor(New Using, New NewExcel, New OneTimeSpeedBooster)
    
        '���̊Ԃŏ������s���B
        Debug.Print "Application.ScreenUpdating:" & Application.ScreenUpdating
    
        'Using �N���X�̈����P�ڂ̃C���X�^���X��Ԃ��B
        Debug.Print .Args(1).GetInstance.Caption
        

    End With
    '�I��
    
    Debug.Print "Application.ScreenUpdating:" & Application.ScreenUpdating

End Sub
