Attribute VB_Name = "Sample"
Option Private Module
Option Explicit


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
    Debug.Print Core.PlaceHolder("�T���v���ł��B{0}�̂����łȂ�{1}������", "��", "���_")


End Sub

Sub Using_Sample()

    'IUsing �ɑΉ������N���X�� Using�N���X�̃R���X�g���N�^��
    '�w�肷�邱�Ƃɂ��A�J�n�E�I�����}�l�W�����g����B
    
    'NewExcel           �E�E�ʃv���Z�X��Excel�N���E�I�����s���B
    'OneTimeSpeedBooster�E�E�Čv�Z�AScreenUpdating�y��PrintCommunication�Ȃǂ�
    '                       ��~�E�ĊJ���s���B
    
    'With�ŊJ�n�����AEnd With�ŏI���������s���BC#�ł�Using��̂悤�ȓ�����s���B
    With Using.CreateObject(New NewExcel, New OneTimeSpeedBooster)
    
        '���̊Ԃŏ������s���B
        Debug.Print "Application.ScreenUpdating:" & Application.ScreenUpdating
    
        'Using �N���X�̈����P�ڂ̃C���X�^���X��Ԃ��B
        Debug.Print .Args(1).GetInstance.Caption
        

    End With
    '�I��
    
    Debug.Print "Application.ScreenUpdating:" & Application.ScreenUpdating

End Sub


Sub Web()

    'http://weather.livedoor.com/weather_hacks/webservice
    Dim strBuf As String
    Dim v As IDictionary
    
    strBuf = Application.WorksheetFunction.WebService("http://weather.livedoor.com/forecast/webservice/json/v1?city=120010")

    
    Dim dic As IDictionary
    
    Set dic = Parser.ParseJSON(strBuf)
'    Debug.Print strBuf

    Dim lst As IList
    Set lst = dic.Item("forecasts")

    For Each v In lst
    
        Debug.Print v.Item("date")
        Debug.Print v.Item("dateLabel")
        Debug.Print v.Item("telop")
        If IsEmpty(v.Item("temperature").Item("max")) Then
            Debug.Print ""
        Else
           Debug.Print v.Item("temperature").Item("max").Item("celsius")
        End If
        If IsEmpty(v.Item("temperature").Item("min")) Then
            Debug.Print ""
        Else
           Debug.Print v.Item("temperature").Item("min").Item("celsius")
        End If
    
    Next


End Sub

Sub BookReader_Sample()

    Dim BR As BookReader
    
    Set BR = BookReader.CreateObject("Sample.xlsx")
    
    
    Set BR = Nothing


End Sub




