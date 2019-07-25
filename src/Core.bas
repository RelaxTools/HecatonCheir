Attribute VB_Name = "Core"
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
' �R���X�g���N�^����
'-----------------------------------------------------------------------------------------------------
Option Explicit

'Callback�p
Private mCallback As IDictionary

'-----------------------------------------------------------------------------------------------------
' �R���X�g���N�^����
'-----------------------------------------------------------------------------------------------------
Public Function Constructor(ByRef obj As Object, ParamArray Args() As Variant) As Object

    Dim c As IConstructor
    Dim v As Variant
    
    '�R���N�V�����̃R���X�g���N�^
    If TypeOf obj Is Collection Then
        For Each v In Args
            obj.Add v
        Next
        Set Constructor = obj
    
    '���̑��N���X�̃R���X�g���N�^
    Else
        '������Collection�ɋl�ߑւ���
        Dim Col As Collection
        Set Col = New Collection
        
        For Each v In Args
            'Form��Me�w��̏ꍇControls�������Ă��܂��΍�
            If TypeName(v) = "Controls" Then
                Col.Add v(1).Parent
            Else
                Col.Add v
            End If
        Next
        
        'IConstructor Interface���Ăяo���B
        Set c = obj
        Set Constructor = c.Instancing(Col)
    End If
    
    '�I�u�W�F�N�g���ԋp����Ȃ������ꍇ�G���[
    If Constructor Is Nothing Then
        Message.Throw 1, "ClassHelper", "Constructor", "Argument Error"
    End If

End Function
'-----------------------------------------------------------------------------------------------------
' VBA �l�I�ėp���� https://qiita.com/nukie_53/items/bde16afd9a6ca789949d
' @nukie_53
' Set/Let���B������v���p�e�B
'-----------------------------------------------------------------------------------------------------
Public Property Let SetVar(outVariable As Variant, inExpression As Variant)
    
    Select Case True
        Case VBA.IsObject(inExpression), VBA.VarType(inExpression) = vbDataObject
            
            Set outVariable = inExpression
        
        Case Else
            
            Let outVariable = inExpression
    
    End Select

End Property
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
    
    MsgBox "�\�[�X��ۑ����܂����B", vbInformation, "Export"
    
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
    Dim No() As Long
    Dim strMark As String
    Dim i As Long
    
    Const Level As Long = 4
    
    ReDim No(1 To Level)
    
    For i = 1 To Level
        No(i) = 0
    Next
    
    strFolder = FileIO.BuildPath(FileIO.GetParentFolderName(ThisWorkbook.FullName), "md")
    FileIO.CreateFolder strFolder
    
    For Each obj In ThisWorkbook.VBProject.VBComponents
    
        strFile = FileIO.BuildPath(strFolder, obj.Name & ".md")
        
        With obj.CodeModule
            
            Set SB = New StringBuilder
            
            For i = 1 To .CountOfLines
                '�w��ʒu����P�s�擾
                strBuf = .Lines(i, 1)
                If Left$(strBuf, 2) = "'>" Then
                    strMark = Mid$(strBuf, 3)
                    SB.Append LevelNo(strMark, No(), Level)
                End If
            Next i
        
            '�Ώۂ�����Ώo�͂���
            If SB.Length > 0 Then
                Dim fp As Integer
                fp = FreeFile()
                Open strFile For Output As fp
                Print #fp, SB.ToJoin(vbCrLf)
                Close
            End If
            
            Set SB = Nothing
        End With
    
    Next

End Sub
Private Function LevelNo(ByVal strBuf As String, No() As Long, ByVal lngLevel As Long) As String

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
            
                Dim a As Variant
                
                a = Split(c(1).Value, ".")
        
                For i = LBound(a) To UBound(a)
                    No(i + 1) = a(i)
                Next
            
                LevelNo = strBuf
            Else
            
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
        
                LevelNo = strLeft & SB.ToJoin(".") & strRight
            
            End If
        
        Else
            LevelNo = strBuf
        End If
    Else
        LevelNo = strBuf
    End If

End Function
'---------------------------------------------------------------------------------------------------
'�@Callback�̍ۂ�Install���\�b�h
'---------------------------------------------------------------------------------------------------
Public Function InstallCallback(MH As Callback) As String

    Dim Key As String

    If mCallback Is Nothing Then
        Set mCallback = New Dictionary
    End If
    
    Key = CStr(ObjPtr(MH))
    
    mCallback.Add Key, MH
    
    InstallCallback = Key
    
End Function
'---------------------------------------------------------------------------------------------------
'�@Callback�̍ۂ�UnInstall���\�b�h
'---------------------------------------------------------------------------------------------------
Public Sub UninstallCallback(ByVal Key As String)

    If mCallback.ContainsKey(Key) Then
        mCallback.Remove Key
    End If
    
End Sub
'---------------------------------------------------------------------------------------------------
'�@Callback�̍ۂɌĂяo����郁�\�b�h
'---------------------------------------------------------------------------------------------------
Public Function OnActionCallback(ByVal Key As String, ByVal lngEvent As Long, ByVal opt As String)

    Dim MH As Callback
    
    If mCallback.ContainsKey(Key) Then
        
        Set MH = mCallback(Key)
        Call MH.OnActionCallback(lngEvent, opt)
        
    End If

End Function
'---------------------------------------------------------------------------------------------------
' Dictionary����
'---------------------------------------------------------------------------------------------------
Public Function IsDictionary(v As Variant) As Boolean

    IsDictionary = True
    
    Select Case TypeName(v)
        Case "Dictionary"
        Case "OrderedDictionary"
        Case "SortedDictionary"
        Case Else
            IsDictionary = False
    End Select

End Function
'---------------------------------------------------------------------------------------------------
' List����
'---------------------------------------------------------------------------------------------------
Public Function IsList(v As Variant) As Boolean

    IsList = True
    
    Select Case TypeName(v)
        Case "ArrayList"
        Case "Collection"
        Case Else
            IsList = False
    End Select

End Function
