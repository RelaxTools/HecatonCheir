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
