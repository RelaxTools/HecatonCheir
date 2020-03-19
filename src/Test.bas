Attribute VB_Name = "Test"
Option Explicit
Option Private Module

Sub Show_Test()
    frmTest.Show
End Sub

Sub Test_ArrayList()

    Dim IL As IList
    Dim ic As ICursor
    
    Set IL = ArrayList.NewInstance()
    
    Debug.Assert IL.Count = 0
    
    IL.Add "a"
    IL.Add 1
    IL.Add 3.14159

    Debug.Assert IL.Item(0) = "a"
    Debug.Assert IL.Item(1) = 1
    Debug.Assert IL.Item(2) = 3.14159

    Debug.Assert IL.Count = 3

    IL.RemoveAt 1
    
    Debug.Assert IL.Item(0) = "a"
    Debug.Assert IL.Item(1) = 3.14159
    
    Debug.Assert IL.Count = 2
        
    IL.Clear
    
    Debug.Assert IL.Count = 0
    
    Dim col As Collection
    
    Set col = New Collection
    
    col.Add "a"
    col.Add 1
    col.Add 3.14159
    
    Set ic = ArrayList.NewInstance(col)
    Dim i As Long
    
    i = 0
    Do Until ic.Eof
    
        Select Case i
            Case 0
                Debug.Assert ic.Item = "a"
            Case 1
                Debug.Assert ic.Item = 1
            Case 2
                Debug.Assert ic.Item = 3.14159
        End Select
        
        i = i + 1
        ic.MoveNext
    
    Loop
    
    Debug.Assert i = 3
    
    Set IL = ic
    
    Debug.Assert IL.Count = 3
    
    IL.Clear
    
    Debug.Assert IL.Count = 0
    
    Dim v As Variant
    
    v = Array("a", 1, 3.14159)
    
    Set IL = ArrayList.NewInstance(v)
    
    'JSON
    Debug.Assert IL.ToString = "[""a"", 1, 3.14159]"
    
    Debug.Assert Join(IL.ToArray(), "/") = "a/1/3.14159"

    IL.sort

    Debug.Assert IL.Item(0) = 1
    Debug.Assert IL.Item(1) = 3.14159
    Debug.Assert IL.Item(2) = "a"
    
    Debug.Assert IL.Count = 3
    
    IL.Insert 1, "�ǉ�"

    Debug.Assert IL.Item(0) = 1
    Debug.Assert IL.Item(1) = "�ǉ�"
    Debug.Assert IL.Item(2) = 3.14159
    Debug.Assert IL.Item(3) = "a"
    
    Debug.Assert IL.Count = 4
    
    Set IL = ArrayList.NewInstance(Array("a", "b", "c"))

    Debug.Assert IL.Item(0) = "a"
    
    
    Set IL = ArrayList.NewInstance
    Dim ID As SampleVO
    
'    Dim j As Long
    For i = 1 To 10
'        For i = 1 To 10
        
            Set ID = New SampleVO
            ID.Name = i & "����"
            ID.Age = i
            ID.Address = i & "�Ԓn"
            
            IL.Add ID
'        Next
    Next
    
    Arrays.CopyToRange IL, ThisWorkbook.Sheets("�e�X�g").Range("B18")

End Sub
Sub Test_LinkedList()

    Dim IL As IList
    Dim ic As ICursor
    
    Set IL = LinkedList.NewInstance()
    
    Debug.Assert IL.Count = 0
    
    IL.Add "a"
    IL.Add 1
    IL.Add 3.14159

    Debug.Assert IL.Item(0) = "a"
    Debug.Assert IL.Item(1) = 1
    Debug.Assert IL.Item(2) = 3.14159

    Debug.Assert IL.Count = 3

    IL.RemoveAt 1
    
    Debug.Assert IL.Item(0) = "a"
    Debug.Assert IL.Item(1) = 3.14159
    
    Debug.Assert IL.Count = 2
        
    IL.Clear
    
    Debug.Assert IL.Count = 0
    
    Dim col As Collection
    
    Set col = New Collection
    
    col.Add "a"
    col.Add 1
    col.Add 3.14159
    
    Set ic = LinkedList.NewInstance(col)
    Dim i As Long
    
    i = 0
    Do Until ic.Eof
    
        Select Case i
            Case 0
                Debug.Assert ic.Item = "a"
            Case 1
                Debug.Assert ic.Item = 1
            Case 2
                Debug.Assert ic.Item = 3.14159
        End Select
        
        i = i + 1
        ic.MoveNext
    
    Loop
    
    Debug.Assert i = 3
    
    Set IL = ic
    
    Debug.Assert IL.Count = 3
    
    IL.Clear
    
    Debug.Assert IL.Count = 0
    
    Dim v As Variant
    
    v = Array("a", 1, 3.14159)
    
    Set IL = LinkedList.NewInstance(v)
    
    'JSON
    Debug.Assert IL.ToString = "[""a"", 1, 3.14159]"
    
    Debug.Assert Join(IL.ToArray(), "/") = "a/1/3.14159"

    IL.sort

    Debug.Assert IL.Item(0) = 1
    Debug.Assert IL.Item(1) = 3.14159
    Debug.Assert IL.Item(2) = "a"
    
    Debug.Assert IL.Count = 3
    
    IL.Insert 1, "�ǉ�"

    Debug.Assert IL.Item(0) = 1
    Debug.Assert IL.Item(1) = "�ǉ�"
    Debug.Assert IL.Item(2) = 3.14159
    Debug.Assert IL.Item(3) = "a"
    
    Debug.Assert IL.Count = 4
    


End Sub

Sub Test_ICursor_SheetCursor()

    'ICursor �C���^�[�t�F�[�X���g�p����
    Dim ic As ICursor

    '3�s�ڂ��火�Ɍ������ēǂށB
    'B�񂪋󕶎���("")�ɂȂ�����I���B
    Set ic = SheetCursor.NewInstance(Sheet1, 3, "B")

    Dim i As Long
    i = 0
    Do Until ic.Eof

        '�����͗��\����������ԍ����w�肷��B
        'IC.Item("C").Value �ł� IC.Item(3).Value �ł��ǂ��BRange��ԋp�B
        Select Case i
            Case 0
                Debug.Assert ic("C") = "A1"
                Debug.Assert ic("D") = "B1"
                Debug.Assert ic("E") = "C1"
            Case 1
                Debug.Assert ic("C") = "A2"
                Debug.Assert ic("D") = "B2"
                Debug.Assert ic("E") = "C2"
            Case 2
                Debug.Assert ic("C") = "A3"
                Debug.Assert ic("D") = "B3"
                Debug.Assert ic("E") = "C3"
        End Select
        i = i + 1
        ic.MoveNext
    Loop

End Sub
Sub Test_CollectionCursor()

    'CollectionCursor�͔p�~�A���@�\��ArrayList���g�p�̂��ƁB

    Dim col As Collection
    Set col = New Collection
    
    col.Add "a"
    col.Add "b"
    col.Add "c"
    col.Add "D"

    Dim ic As ICursor

    Set ic = ArrayList.NewInstance(col)
    Dim i As Long
    i = 0
    Do Until ic.Eof
    
        Select Case i
            Case 0
                Debug.Assert ic.Item = "a"
            Case 1
                Debug.Assert ic.Item = "b"
            Case 2
                Debug.Assert ic.Item = "c"
            Case 3
                Debug.Assert ic.Item = "D"
        End Select
        i = i + 1
        ic.MoveNext
    Loop

End Sub
Sub Test_LineCursor()

    'LineCursor�͔p�~�A���@�\��ArrayList���g�p�̂��ƁB

    Dim v As Variant
    
    v = Array("a", "b", "c")


    Dim ic As ICursor

    Set ic = ArrayList.NewInstance(v)

    Dim i As Long
    i = 0
    Do Until ic.Eof
    
        Select Case i
            Case 0
                Debug.Assert ic.Item = "a"
            Case 1
                Debug.Assert ic.Item = "b"
            Case 2
                Debug.Assert ic.Item = "c"
        End Select
        i = i + 1
        ic.MoveNext
    Loop

End Sub
Sub Test_StringBuilder()

    Dim SB As IStringBuilder
    
    Set SB = StringBuilder.NewInstance
    
    SB.Append "A"
    SB.Append "B"
    SB.Append "C"
    SB.Append "D"
    SB.Append "E"

    '������̘A��
    Debug.Assert SB.ToString = "ABCDE"
    
    Dim S2 As IStringBuilder
    
    Set S2 = StringBuilder.NewInstance
    
    'True������ƃ_�u���R�[�e�[�V�����ň͂�
    S2.Append "red", True
    S2.Append "green", True
    S2.Append "blue", True

    '������̘A���i�J���}��؂�j
    Debug.Assert S2.ToString(",", "[", "]") = "[""red"",""green"",""blue""]"
    
End Sub

Sub Test_Serialize()

    Dim Row As IList
    Dim col As IDictionary
    
    Set Row = ArrayList.NewInstance()
    
    Set col = Dictionary.NewInstance
    
    col.Add "Field01", 10
    col.Add "Field02", 20
    col.Add "Field03", 30

    Row.Add col

    Set col = Dictionary.NewInstance
    col.Add "Field01", 40
    col.Add "Field02", 50
    col.Add "Field03", 60

    Row.Add col
    
    Debug.Assert Row.ToString = "[{""Field01"":10, ""Field02"":20, ""Field03"":30}, {""Field01"":40, ""Field02"":50, ""Field03"":60}]"

End Sub
Sub Test_desirialize()

    Dim Row As IList

    Set Row = Parser.ParseJSON("[{""Field01"":10, ""Field02"":20, ""Field03"":30}, {""Field01"":40, ""Field02"":50, ""Field03"":60}]")

    Debug.Assert Row.Count = 2

    Debug.Assert Row.ToString = "[{""Field01"":10, ""Field02"":20, ""Field03"":30}, {""Field01"":40, ""Field02"":50, ""Field03"":60}]"

End Sub

Sub Test_SortedDictionary()


    Dim d As IDictionary
    Dim v As Variant
    
    Set d = SortedDictionary.NewInstance
    
    d.Add "10", "10"
    d.Add "1", "1"
    d.Add "2", "2"

    Debug.Assert d.Keys(0) = "1"
    Debug.Assert d.Keys(1) = "10"
    Debug.Assert d.Keys(2) = "2"

    Set d = SortedDictionary.NewInstance(New ExplorerComparer)
    
    d.Add "10", "10"
    d.Add "1", "1"
    d.Add "2", "2"

    Debug.Assert d.Keys(0) = "1"
    Debug.Assert d.Keys(1) = "2"
    Debug.Assert d.Keys(2) = "10"


End Sub
Sub Test_OrderedDictionary()


    Dim d As IDictionary
    Dim v As Variant
    Set d = OrderedDictionary.NewInstance
    
    d.Add "10", "10"
    d.Add "1", "1"
    d.Add "2", "2"
    
    Debug.Assert d.Keys(0) = "10"
    Debug.Assert d.Keys(1) = "1"
    Debug.Assert d.Keys(2) = "2"
    
    d.Remove "1"
    
    Debug.Assert d.Keys(0) = "10"
    Debug.Assert d.Keys(1) = "2"
    
    d.key("2") = "3"

    Debug.Assert d.Keys(0) = "10"
    Debug.Assert d.Keys(1) = "3"
    
    Dim i As Long
    i = 0
    For Each v In d
        Select Case i
            Case 0
                Debug.Assert d.Keys(i) = "10"
            Case 1
                Debug.Assert d.Keys(i) = "3"
        End Select
        i = i + 1
    Next
    
    d.Remove "10"
    
    Debug.Assert d.Keys(0) = "3"

    Debug.Assert d.Count = 1

End Sub
Sub Test_CsvParser()

    Dim strBuf As String
    Dim Row As Collection
    Dim col As Collection
    Dim v As Variant
    strBuf = "1,Watanabe,Fukushima,36,""�J���}�������Ă�,OK""" & vbCrLf & "2,satoh,chiba,24,""���s�������Ă�" & vbLf & "OK���"""

    Set Row = Parser.ParseCsv(strBuf, True)

    Debug.Assert Row(1)(1) = "1"
    Debug.Assert Row(1)(2) = "Watanabe"
    Debug.Assert Row(1)(3) = "Fukushima"
    Debug.Assert Row(1)(4) = "36"
    Debug.Assert Row(1)(5) = "�J���}�������Ă�,OK"

    Debug.Assert Row(2)(1) = "2"
    Debug.Assert Row(2)(2) = "satoh"
    Debug.Assert Row(2)(3) = "chiba"
    Debug.Assert Row(2)(4) = "24"
    Debug.Assert Row(2)(5) = "���s�������Ă�" & vbLf & "OK���"

End Sub
Sub Test_IsDictionary()

    Dim dic As Object
    
    Set dic = Dictionary.NewInstance
    
    Debug.Assert Objects.InstanceOfIDictionary(dic)

    Set dic = OrderedDictionary.NewInstance()
    
    Debug.Assert Objects.InstanceOfIDictionary(dic)

    Set dic = SortedDictionary.NewInstance
    
    Debug.Assert Objects.InstanceOfIDictionary(dic)

    Set dic = VBA.CreateObject("Scripting.Dictionary")
    
'    Debug.Assert Objects.InstanceOfIDictionary(dic)

    Debug.Assert Objects.InstanceOfIDictionary("") = False

    Dim lst As IList

    Set lst = ArrayList.NewInstance()

    Debug.Assert Objects.InstanceOfIDictionary(lst) = False


End Sub
'------------------------------------------------
' MCommand��VBA�ō쐬����ꍇ�̃w���p�[�N���X
'------------------------------------------------
Sub Test_MCommand()

    '-----------------------------------
    ' MCommand���������ɍ쐬����ꍇ
    '-----------------------------------
    Dim t1 As MTable
    Dim t2 As MTable
    Dim t3 As MTable
    
    Set t1 = MCsv.Document(MFile.Contents("C:\Test.csv"), _
                           "[Delimiter="","", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]")
    Set t2 = MTable.Skip(t1, 2)
    Set t3 = MTable.PromoteHeaders(t2, "[PromoteAllScalars=true]")

    Dim m1 As IMCommand
    Set m1 = New MCommand
    
    m1.Append t3
    
    Dim strBuf As String
    
    strBuf = "let " & vbCrLf
    strBuf = strBuf & "Source1 = Table.PromoteHeaders(Table.Skip(Csv.Document(File.Contents(""C:\Test.csv""), [Delimiter="","", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]), 2), [PromoteAllScalars=true]) " & vbCrLf
    strBuf = strBuf & "in Source1"
    
    Debug.Assert m1.ToString = strBuf

    
    '����
    'let Source1 = Table.PromoteHeaders(Table.Skip(Csv.Document(File.Contents("C:\Test.csv"),
    '              [Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]), 2), [PromoteAllScalars=true]) in Source1

    
    '-----------------------------------
    ' MCommand�ɑ�����č쐬����ꍇ
    '-----------------------------------
    Dim m2 As IMCommand
    Set m2 = New MCommand
    
    m2.Append MCsv.Document(MFile.Contents("C:\Test.csv"), _
                            "[Delimiter="","", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]")
    
    m2.Append MTable.Skip(m2.Table, 2)
    m2.Append MTable.PromoteHeaders(m2.Table, "[PromoteAllScalars=true]")

    strBuf = "let " & vbCrLf
    strBuf = strBuf & "Source1 = Csv.Document(File.Contents(""C:\Test.csv""), [Delimiter="","", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]), " & vbCrLf
    strBuf = strBuf & "Source2 = Table.Skip(Source1, 2), " & vbCrLf
    strBuf = strBuf & "Source3 = Table.PromoteHeaders(Source2, [PromoteAllScalars=true]) " & vbCrLf
    strBuf = strBuf & "in Source3"
    
    Debug.Assert m2.ToString = strBuf

    '����
    'let Source1 = Csv.Document(File.Contents("C:\Test.csv"), [Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    '    Source2 = Table.Skip(Source1, 2),
    '    Source3 = Table.PromoteHeaders(Source2, [PromoteAllScalars=true]) in Source3


    '-----------------------------------
    ' MRecord/MList��p�����T���v��
    '-----------------------------------
    Dim m3 As IMCommand
    
    'MRecord(M�����Record) �� Dictionary��Wrap�������́B�g�p���@��Dictionary�����B
    Dim rec As IDictionary
    Set rec = New MRecord
            
    rec.Add "Column1", """No."""
    rec.Add "Column2", """NAME"""
    rec.Add "Column3", """AGE"""
    rec.Add "Column4", """ADDRESS"""
    rec.Add "Column5", """TEL"""
    
    'MList(M�����List) �� ArrayList��Wrap�������́B�g�p���@��Collection�Ɠ����B
    Dim lst As IList
    Set lst = New MList
    lst.Add rec
    
    Set m3 = New MCommand

    m3.Append MCsv.Document(MFile.Contents("C:\Test.csv"), _
                            "[Delimiter="","", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]")
    m3.Append MTable.Skip(m3.Table, 2)
    m3.Append MTable.InsertRows(m3.Table, 0, lst)
    m3.Append MTable.PromoteHeaders(m3.Table, "[PromoteAllScalars=true]")

    strBuf = "let " & vbCrLf
    strBuf = strBuf & "Source1 = Csv.Document(File.Contents(""C:\Test.csv""), [Delimiter="","", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]), " & vbCrLf
    strBuf = strBuf & "Source2 = Table.Skip(Source1, 2), " & vbCrLf
    strBuf = strBuf & "Source3 = Table.InsertRows(Source2, 0, {[Column1=""No."", Column2=""NAME"", Column3=""AGE"", Column4=""ADDRESS"", Column5=""TEL""]}), " & vbCrLf
    strBuf = strBuf & "Source4 = Table.PromoteHeaders(Source3, [PromoteAllScalars=true]) " & vbCrLf
    strBuf = strBuf & "in Source4"


    Debug.Assert m3.ToString = strBuf

    '����
    'let Source1 = Csv.Document(File.Contents("C:\Test.csv"), [Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    '    Source2 = Table.Skip(Source1, 2),
    '    Source3 = Table.InsertRows(Source2, 0, {[Column1="No.", Column2="NAME", Column3="AGE", Column4="ADDRESS", Column5="TEL"]}),
    '    Source4 = Table.PromoteHeaders(Source3, [PromoteAllScalars=true]) in Source4

End Sub

Sub Test_TextWriter()

    Dim strFile As String
    Dim strBuf As String
    
    strFile = FileIO.BuildPath(ThisWorkbook.Path, "testxx.txt")

    '��t�@�C��
    With TextWriter.NewInstance(strFile, NewLineCodeLF, EncodeUTF8, OpenModeOutput, False)
    End With

    Dim blnFind As Boolean
    blnFind = False

    With TextReader.NewInstance(strFile, NewLineCodeLF, EncodeUTF8)

        Do Until .Eof

            blnFind = True

            .MoveNext
        Loop

    End With
    
    Debug.Assert blnFind = False
    
    
    With TextWriter.NewInstance(strFile, NewLineCodeLF, EncodeUTF8, OpenModeOutput, False)

        .WriteLine "����������"

    End With


    With TextReader.NewInstance(strFile, NewLineCodeLF, EncodeUTF8)

        Do Until .Eof

            strBuf = .Item

            .MoveNext
        Loop

    End With
    
    FileIO.DeleteFile strFile

    Debug.Assert strBuf = "����������"

End Sub
Sub Test_CsvWriter()

    Dim strFile As String
    Dim strBuf1 As String
    Dim strBuf2 As String
    
    strFile = FileIO.BuildPath(ThisWorkbook.Path, "testxx.csv")
    
    '��t�@�C��
    With CsvWriter.NewInstance(strFile, NewLineCodeLF, EncodeUTF16LE, OpenModeOutput, True, ",")
    End With

    Dim blnFind As Boolean
    blnFind = False
    
    With CSVReader.NewInstance(strFile, NewLineCodeLF, EncodeUTF16LE, ",", True)
        Do Until .Eof
            blnFind = True
            .MoveNext
        Loop

    End With

    Debug.Assert blnFind = False


    With CsvWriter.NewInstance(strFile, NewLineCodeLF, EncodeUTF16LE, OpenModeOutput, True, ",")

        .WriteLine Array("Name", "Key")
        .WriteLine Array("����,������", StringUtils.PlaceHolder("������\n����"))

    End With


    With CSVReader.NewInstance(strFile, NewLineCodeLF, EncodeUTF16LE, ",", True)

        Do Until .Eof

            strBuf1 = .Item(1)
            strBuf2 = .Item(2)

            .MoveNext
        Loop

    End With
    
    Debug.Assert strBuf1 = "����,������"
    Debug.Assert strBuf2 = "������" & vbLf & "����"
    
    With CSVReader.NewInstance(strFile, NewLineCodeLF, EncodeUTF16LE, ",", True, True)

        Do Until .Eof

            strBuf1 = .Item("name")
            strBuf2 = .Item("key")

            .MoveNext
        Loop

    End With
    
    Debug.Assert strBuf1 = "����,������"
    Debug.Assert strBuf2 = "������" & vbLf & "����"
    
    FileIO.DeleteFile strFile


End Sub
Sub Test_Compress()

    Dim strTmp  As String
    Dim strFile As String
    Dim strZip As String
    
    strTmp = FileIO.TempFolder
    strFile = FileIO.BuildPath(strTmp, "aaa.txt")
    strZip = FileIO.BuildPath(strTmp, "aaa.zip")

    TextWriter.NewInstance(strFile).WriteLine ("��������")


    Dim lst As IList
    
    Set lst = ArrayList.NewInstance()
    
    lst.Add strFile

    Call Zip.CompressArchive(lst.ToArray, strZip)

    Debug.Assert FileIO.FileExists(strZip)

    FileIO.DeleteFile strFile
    
    Call Zip.ExpandArchive(strZip, strTmp)

    Debug.Assert FileIO.FileExists(strFile)
    
    FileIO.DeleteFile strFile
    FileIO.DeleteFile strZip

End Sub
Sub Test_PlaceHolder()

    Debug.Assert StringUtils.PlaceHolder("����̓e�X�g�ł��B\n{0}", 10) = "����̓e�X�g�ł��B" & vbLf & "10"

End Sub
Sub Test_TaskTrayView()

    Dim TV As TaskTrayView
    
    With TaskTrayView.NewInstance("�e�X�g�ł��B")
        .ShowBalloon "�����点", "�o���[���\��", 5
    End With
    
End Sub
Sub Test_RegExp()

    Dim col As Collection

    Set col = RegExp.Execute("12AB56", "[A-Z]{2}")

    Debug.Assert col(1).Index = 3
    Debug.Assert col(1).Length = 2
    Debug.Assert col(1).Value = "AB"

End Sub
Sub Test_StrSch()

    Dim col As Collection

    Set col = StrSch.Execute("12AB56", "AB")

    Debug.Assert col(1).Index = 3
    Debug.Assert col(1).Length = 2
    Debug.Assert col(1).Value = "AB"

End Sub
Sub Test_Graphics()

    Dim IP As IPictureDisp
    Dim strFile As String
    
    '�A�C�R���擾
    Set IP = Graphics.LoadIcon(Application.Path & "\EXCEL.EXE")
    
    '�ۑ�
    strFile = FileIO.BuildPath(ThisWorkbook.Path, "Test.png")
    Call Graphics.SavePicture(IP, strFile)

    Debug.Assert FileIO.FileExists(strFile)

    FileIO.DeleteFile strFile
    
    'ImageMso�ۑ�
    Call Graphics.SavePicture(CommandBars.GetImageMso("Paste", 32, 32), strFile)
    
    Debug.Assert FileIO.FileExists(strFile)
    
    Set IP = Graphics.LoadPicture(strFile)
    
    FileIO.DeleteFile strFile
    
    Debug.Assert Not IP Is Nothing

End Sub
Sub Test_StringEx()

    Dim s As StringEx
    
    Set s = StringEx.NewInstance()
    
    
    s = "abcdefg"
    
    Debug.Assert s = "abcdefg"

    Debug.Assert s.Length = 7
    
    s = " aaa�@"

    Debug.Assert s.Trim = "aaa"
    
    s = "123��#"
    
    Debug.Assert s.StartsWith("123")
    Debug.Assert s.EndsWith("��#")
    
'    Debug.Assert s.SJISLength = 6
    
    
'    Debug.Assert s.SJISLeft(5) = "123��"
    
    s = "\"
    Debug.Assert s.Escape = "\\"

    s = "\\"
    Debug.Assert s.Unescape = "\"
    
    s = "���Ȃ���{0}��{1}�ł��B"

    Debug.Assert s.PlaceHolder("�V��", "����") = "���Ȃ��͓V�˂����قł��B"
    
    Debug.Assert s.ToKatakana = "�A�i�^�n{0}�J{1}�f�X�B"
    
    s = "�J�^�J�i"

    Debug.Assert s.ToHiragana = "��������"
    
    
    Debug.Assert s.SubString(0, 2) = "�J�^"
    
    Debug.Assert s.SubString(0, 2).ToHiragana = "����"
    
    Debug.Assert StringEx.NewInstance("���Ȃ���{0}�ł��B").PlaceHolder("�ɂ��") = "���Ȃ��͂ɂ��ł��B"





End Sub

Sub Test_Arrays()

    Call SubText_Arrays("1", "2", "3")

    Dim v As Variant
    
    v = Array("1", "2", "3")
    
    Dim col As Collection
    
    Set col = Arrays.ToCollection(v)
    
    Debug.Assert col.Count = 3


End Sub

Private Sub SubText_Arrays(ParamArray args() As Variant)


    Dim col As Collection
    
    Dim v As Variant
    
    v = args()
    
    
    Set col = Arrays.ToCollection(v)
    
    Debug.Assert col.Count = 3



End Sub


'Sub a()
'
'    Dim b As IList
'
'    Set b = Dictionary.NewInstance
'
'
'
'End Sub
