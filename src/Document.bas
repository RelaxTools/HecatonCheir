Attribute VB_Name = "Document"
'-----------------------------------------------------------------------------------------------------
'
' [Hidennotare] v1
'
' Copyright (c) 2019 Yasuhiro Watanabe
' https://github.com/RelaxTools/Hidennotare
' author:relaxtools@opensquare.net
'
' The MIT License (MIT)
'
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all
' copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
' SOFTWARE.
'
'-----------------------------------------------------------------------------------------------------
'>### Document �W�����W���[��
'>
'>**Remarks**
'>
'>* �h�L�������g�������W���[��(Hidennotare��git��wiki�ŊǗ����邽�߂̃��W���[��)
'>
'-----------------------------------------------------------------------------------------------------
Private Const TARGET_URL As String = "https://github.com/RelaxTools/Hidennotare/wiki/"
Option Explicit
'-----------------------------------------------------------------------------------------------------
' �\�[�X�̃G�N�X�|�[�g
'-----------------------------------------------------------------------------------------------------
Sub Export()

    Dim strFile As String
    Dim strExt As String
    Dim obj As Object
    Dim strTo As String
    
    strFile = FileIO.BuildPath(FileIO.GetParentFolderName(ThisWorkbook.FullName), "src")
    FileIO.CreateFolder strFile
    
    For Each obj In ThisWorkbook.VBProject.VBComponents
    
        If obj.Name Like "Module*" Then
            GoTo pass
        End If
    
        Select Case obj.Type
            Case 1
                strExt = ".bas"
            Case 3
                strExt = ".frm"
            Case 2
                strExt = ".cls"
            Case 11, 100
                GoTo pass
        End Select
        
        strTo = FileIO.BuildPath(strFile, obj.Name & strExt)
        obj.Export strTo
pass:
    Next
    
    MsgBox "Complete!", vbInformation, "Export"
    
End Sub
'-----------------------------------------------------------------------------------------------------
' Markdown�o��
' Markdown������s�̐擪�Ɂu'>�v��������̂ɂ��ăt�@�C���ɏo�͂���B
'-----------------------------------------------------------------------------------------------------
Sub OutputMarkDown()
    
    Dim obj As Object
    Dim strFolder As String
    Dim strFile As String
    Dim SB As StringBuilder
    Dim strBuf As String
    Dim strMark As String
    Dim i As Long
    Dim TC As IList
    Dim fp As Integer
    Dim bytBuf() As Byte
    
    '�ڎ��쐬�p
    Set TC = New ArrayList
    
    '�͔ԍ���t�����郌�x��
    Const Level As Long = 4
    
    '�ڎ����쐬���郌�x��
    Const ContentsLevel As Long = 3
    
    Dim No1() As Long
    Dim No2() As Long
    Dim No3() As Long
    ReDim No1(1 To Level)
    ReDim No2(1 To Level)
    ReDim No3(1 To Level)
    
     
    '�W�����W���[���̃X�^�[�g
     No1(1) = 2
     No1(2) = 1
     No1(3) = 0
     
    '�C���^�[�t�F�C�X�̃X�^�[�g
     No2(1) = 2
     No2(2) = 2
     No2(3) = 0
     
    '�N���X�̃X�^�[�g
     No3(1) = 2
     No3(2) = 3
     No3(3) = 0
    
    strFolder = ThisWorkbook.Path & ".wiki"
    FileIO.CreateFolder strFolder
    
    Dim dic As IDictionary
    Set dic = New SortedDictionary
    
    For Each obj In ThisWorkbook.VBProject.VBComponents
        dic.Add obj.Name, obj
    Next
    
    Dim Key As Variant
    For Each Key In dic.Keys
        
        Set obj = dic.Item(Key)
        
        strFile = FileIO.BuildPath(strFolder, obj.Name & ".md")
        
        With obj.CodeModule
            
            Set SB = New StringBuilder
            
            For i = 1 To .CountOfLines
                '�w��ʒu����P�s�擾
                strBuf = .Lines(i, 1)
                If Left$(strBuf, 2) = "'>" Then
                    strMark = Mid$(strBuf, 3)
                    Select Case True
                        Case obj.Type = 1
                           SB.Append LevelNo(strMark, No1(), Level, TC, ContentsLevel, obj.Name)
                        Case RegExp.Test(obj.Name, "^I[A-Z]")
                           SB.Append LevelNo(strMark, No2(), Level, TC, ContentsLevel, obj.Name)
                        Case Else
                           SB.Append LevelNo(strMark, No3(), Level, TC, ContentsLevel, obj.Name)
                    End Select
                End If
            Next i
        
            '�Ώۂ�����Ώo�͂���
            If SB.Length > 0 Then
                
                FileIO.TruncateFile strFile
                
                fp = FreeFile()
                Open strFile For Binary As fp
                
                bytBuf = Convert.ToUTF8(SB.ToJoin(vbLf))
                
                Put #fp, , bytBuf
                Close fp
            End If
            
            Set SB = Nothing
        End With
    
    Next
    
    'Wiki�̖ڎ��쐬
    If TC.Count > 0 Then
    
        Dim strStatic As String
        
        strFile = FileIO.BuildPath(strFolder, "_Sidebar.md")
        
        '�ڎ��̐ÓI�R���e���c�������擾
        strStatic = GetStaticContents(strFile)
        
        '�\�[�g
        TC.Sort New ExplorerComparer
        
        '�ڎ��쐬
        TC.Insert 0, "#### 2 ���t�@�����X"
        TC.Insert 1, "##### 2.1 �W�����W���[��"
        For i = 0 To TC.Count
            If StringHelper.StartsWith(TC.Item(i), "[2.2") Then
                TC.Insert i, "##### 2.2 �C���^�[�t�F�C�X"
                Exit For
            End If
        Next
        For i = 0 To TC.Count
            If StringHelper.StartsWith(TC.Item(i), "[2.3") Then
                TC.Insert i, "##### 2.3 �N���X"
                Exit For
            End If
        Next
        
        FileIO.TruncateFile strFile
        
        fp = FreeFile()
        Open strFile For Binary As fp
        
        bytBuf = Convert.ToUTF8(strStatic)
        
        Put #fp, , bytBuf
        
        bytBuf = Convert.ToUTF8(Join(TC.ToArray(), vbLf))
        
        Put #fp, , bytBuf
        Close fp
    End If
    
    MsgBox "Complete!", vbInformation, "Markdown"

End Sub
'---------------------------------------------------
' �͔ԍ�����
'---------------------------------------------------
Private Function LevelNo(ByVal strBuf As String, No() As Long, ByVal lngLevel As Long, TC As IList, ByVal lngContentsLevel As Long, ByVal strName As String) As String

    Dim Col As Collection
    Dim SB As StringBuilder
    Dim lngLen As Long
    Dim i As Long
    
    Set Col = RegExp.Execute(strBuf, "^#+ ")

    If Col.Count > 0 Then
    
        lngLen = Len(Col(1).Value) - 1
        
        Dim strLeft As String
        Dim strRight As String
        
        strLeft = Col(1).Value
        strRight = Mid$(strBuf, Col(1).Length + 1)
        
        If lngLen <= lngLevel Then
        
            '�����l�����邩�H
            Dim c As Collection
            
            Set c = RegExp.Execute(strRight, "^[0-9.]+")
        
            If c.Count > 0 Then

                strRight = Mid$(strRight, c(1).Length + 2)

            End If

            '�����ʃ��x����0�̏ꍇ1��ݒ�
            For i = 1 To lngLen - 1
                If No(i) = 0 Then
                    No(i) = 1
                End If
            Next

            No(lngLen) = No(lngLen) + 1

            Set SB = New StringBuilder
            For i = 1 To lngLen
                SB.Append CStr(No(i))
            Next

            For i = lngLen + 1 To lngLevel
                No(i) = 0
            Next

            LevelNo = strLeft & SB.ToJoin(".") & " " & strRight
        
        
            '�ڎ��쐬���x���ȏ�ł���Ζڎ��쐬
            If lngLen <= lngContentsLevel Then
            
                Dim strContent As String
                
                strContent = "[" & Mid$(LevelNo, InStr(LevelNo, " ") + 1) & "](" & TARGET_URL & Replace$(strName, " ", "-") & ")  "
                
                '�ڎ��̃G���A��������̂Ŗڎ��̂ݎ�ނ͍폜
                strContent = Replace$(strContent, " �N���X", "")
                strContent = Replace$(strContent, " �C���^�[�t�F�C�X", "")
                strContent = Replace$(strContent, " �W�����W���[��", "")
            
                TC.Add strContent
            End If
        
        Else
            LevelNo = strBuf
        End If
    Else
        LevelNo = strBuf
    End If

End Function
'URL�G���R�[�h
Private Function EncodeURLFnc(ByVal sWord As String) As String
    EncodeURLFnc = Application.WorksheetFunction.EncodeURL(sWord)
End Function
'---------------------------------------------------
'�ڎ�����ÓI�R���e���c�����𔲂��o��
'---------------------------------------------------
Private Function GetStaticContents(ByVal strFile As String) As String

    Dim fp As Integer
    Dim bytBuf() As Byte
    Dim strBuf As String
    
    GetStaticContents = ""
    
    fp = FreeFile
    
    Open strFile For Binary As fp
    
    ReDim bytBuf(0 To LOF(fp) - 1)
    
    Get #fp, , bytBuf

    Close fp
    
    strBuf = Convert.FromUTF8(bytBuf)

    Dim SB As StringBuilder
    
    Set SB = New StringBuilder

    Dim IC As ICursor
    
    Set IC = Constructor(New LineCursor, Split(strBuf, vbLf))
    
    Do Until IC.Eof
    
        If StringHelper.StartsWith(IC, "#### 2") Then
            Exit Do
        End If
        
        SB.Append IC
        
        IC.MoveNext
    Loop

    If SB.Length > 0 Then
        GetStaticContents = SB.ToJoin(vbLf) & vbLf
    End If
    
End Function
