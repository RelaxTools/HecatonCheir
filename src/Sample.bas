Attribute VB_Name = "Sample"
Option Private Module
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
    Debug.Print S2.ToString(",", "[", "]")


End Sub

Sub Message_Sample()


    'Information ���b�Z�[�W
    message.Information "�T���v���ł��B"

    '���s����ꍇ
    message.Information "�T���v���ł��B\n���s���ȒP�Ɏg���܂��B"

    '���v���[�X�z���_���g�p����ꍇ
    message.Information "�T���v���ł��B{0}�̂����łȂ�{1}������", "��", "���_"
    
    '�X�e�[�^�X�o�[
    message.StatusBar "�T���v���ł��B{0}�̂����łȂ�{1}������", "��", "���_"

    
    '���v���[�X�z���_�̕������ԋp
    Debug.Print message.PlaceHolder("�T���v���ł��B{0}�̂����łȂ�{1}������", "��", "���_")


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
Sub Serialize_Sample()

    Dim Row As IList
    Dim Col As IDictionary
    
    Set Row = New ArrayList
    
    Set Col = New Dictionary
    
    Col.Add "Field01", 10
    Col.Add "Field02", 20
    Col.Add "Field03", 30

    Row.Add Col

    Set Col = New Dictionary
    Col.Add "Field01", 40
    Col.Add "Field02", 50
    Col.Add "Field03", 60

    Row.Add Col
    
    Debug.Print Row.ToString

End Sub
Sub desirialize_Sample()

    Dim Row As IList

    Set Row = JSON.ParseJSON("[{""Field01"":10, ""Field02"":20, ""Field03"":30}, {""Field01"":40, ""Field02"":50, ""Field03"":60}]")

    Debug.Print Row.ToString

End Sub

Sub SortedDictionary_sample()


    Dim d As IDictionary
    Dim v As Variant
'    Set D = New SortedDictionary
    Set d = Constructor(New SortedDictionary, New ExplorerComparer)
    
    d.Add "10", "10"
    d.Add "1", "1"
    d.Add "2", "2"

    For Each v In d.Keys
        Debug.Print v
    Next


End Sub
Sub OrderedDictionary_sample()


    Dim d As IDictionary
    Dim v As Variant
    Set d = New OrderedDictionary
    
    d.Add "10", "10"
    d.Add "1", "1"
    d.Add "2", "2"

    d.Remove "1"
    
    d.Key("2") = "3"

    For Each v In d.Keys
        Debug.Print v
    Next
    
'    D.Remove "2"
    d.Remove "10"


End Sub
Sub CsvParser_Sample()

    Dim strBuf As String
    Dim Row As Collection
    Dim Col As Collection
    Dim v As Variant
    strBuf = "1, Watanabe, Fukushima, 36, ""�J���}�������Ă�,OK""" & vbCrLf & "2, satoh, chiba, 24, ""���s�������Ă�" & vbLf & "OK���"""

    Set Row = StringHelper.CsvParser(strBuf, True)

    For Each Col In Row
        For Each v In Col
            Debug.Print v
        Next
    Next

End Sub
Sub ArrayList_ParseFromListObject_Sample()

    Dim lst As IList
    Dim dic As IDictionary
    Dim Key As Variant

    Set lst = ArrayList.ParseFromListObject(ActiveSheet.ListObjects(1))

    For Each dic In lst

        For Each Key In dic.Keys
        
            Debug.Print dic.Item(Key)
        
        Next

    Next

    Dim a As ArrayList
    
    Set a = lst
    
    a.CopyToListObject ActiveSheet.ListObjects(2)

End Sub
Sub Dictionary_ParseFromListObject_Sample()

    Dim lst As IDictionary
    Dim dic As IDictionary
    Dim Key As Variant
    Dim Key2 As Variant

    Set lst = Dictionary.ParseFromListObject(ActiveSheet.ListObjects(1), "A")

    For Each Key In lst.Keys

        Set dic = lst.Item(Key)

        For Each Key2 In dic.Keys
        
            Debug.Print dic.Item(Key2)
        
        Next

    Next

    Dim a As Dictionary
    
    Set a = lst
    
    a.CopyToListObject ActiveSheet.ListObjects(2)

End Sub

Sub IsDictionary_Sample()

    Dim dic As Object
    
    
    Set dic = New Dictionary
    
    Debug.Print IsDictionary(dic)

    Set dic = New OrderedDictionary
    
    Debug.Print IsDictionary(dic)

    Set dic = New SortedDictionary
    
    Debug.Print IsDictionary(dic)

    Set dic = CreateObject("Scripting.Dictionary")
    
    Debug.Print IsDictionary(dic)


End Sub
Sub Web()

    'http://weather.livedoor.com/weather_hacks/webservice
    Dim strBuf As String
    Dim v As IDictionary
    
    strBuf = Application.WorksheetFunction.WebService("http://weather.livedoor.com/forecast/webservice/json/v1?city=120010")

    
    Dim dic As IDictionary
    
    Set dic = JSON.ParseJSON(strBuf)
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
