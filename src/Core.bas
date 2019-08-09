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
'>### Core �W�����W���[��
'>
'>**Remarks**
'>
'>- �R���X�g���N�^�����𒇉��w���p�֐����B
'>
'-----------------------------------------------------------------------------------------------------
Option Private Module
Option Explicit
'-----------------------------------------------------------------------------------------------------
' �R���X�g���N�^����
'-----------------------------------------------------------------------------------------------------
Public Function Constructor(ByRef obj As Object, ParamArray Args() As Variant) As Object

    Dim c As IConstructor
    Dim v As Variant
    
    '�R���N�V�����̃R���X�g���N�^
    If TypeOf obj Is Collection Then
    
        If UBound(Args) = 0 And IsArray(Args) Then
            For Each v In Args(0)
                obj.Add v
            Next
        Else
            For Each v In Args
                obj.Add v
            Next
        End If
        Set Constructor = obj
    
    '���̑��N���X�̃R���X�g���N�^
    Else
        '������Collection�ɋl�ߑւ���
        Dim col As Collection
        Set col = New Collection
        
        For Each v In Args
            'Form��Me�w��̏ꍇControls�������Ă��܂��΍�
            If TypeName(v) = "Controls" Then
                col.Add v(1).Parent
            Else
                col.Add v
            End If
        Next
        
        'IConstructor Interface���Ăяo���B
        Set c = obj
        Set Constructor = c.Instancing(col)
    End If
    
    '�I�u�W�F�N�g���ԋp����Ȃ������ꍇ�G���[
    If Constructor Is Nothing Then
        Error.Raise 512 + 1, "Core.Constructor", "Argument Error"
    End If

End Function '-----------------------------------------------------------------------------------------------------
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
'>---
'>#### CastICompatibleProperty
'>
'>**Syntax**
'>
'>```
'>Set obj = Convert.CastICompatibleProperty(inObj)
'>```
'>
'>**Parameters**
'>
'>|Name|Required/Optional|Data type|Description|
'>---|---|---|---
'>inObj|�K�{|ICompatibleProperty�ɑΉ������I�u�W�F�N�g|
'>
'>**Return Value**
'>
'>ICompatibleProperty�ɃL���X�g���ꂽ�I�u�W�F�N�g
'>
'>**Remarks**
'>
'>ICompatibleProperty�ϊ�<br>
'>
'>**Example**
'>
'>* None
'>
'>**See also**
'>
'>* ICompatibleProperty
'>
Public Function CastICompatibleProperty(ByRef obj As Object) As ICompatibleProperty
    Set CastICompatibleProperty = obj
End Function
'-------------------------------------------------
' NewInstance
'-------------------------------------------------
Public Function GetNewInstance(obj As INewInstance) As Object
    Set GetNewInstance = obj.NewInstance
End Function
'------------------------------------------------------------------------------------------------------------------------
' ��ʃo�C�g�擾
'------------------------------------------------------------------------------------------------------------------------
Public Function UByte(ByVal lngValue As Long) As Long
    UByte = RShift((lngValue And &HFF00&), 8)
End Function
'------------------------------------------------------------------------------------------------------------------------
' ���ʃo�C�g�擾
'------------------------------------------------------------------------------------------------------------------------
Public Function LByte(ByVal lngValue As Long) As Long
    LByte = lngValue And &HFF&
End Function
'------------------------------------------------------------------------------------------------------------------------
' ���V�t�g
'------------------------------------------------------------------------------------------------------------------------
Public Function LShift(ByVal lngValue As Long, ByVal lngKeta As Long) As Long
    LShift = lngValue * (2 ^ lngKeta)
End Function
'------------------------------------------------------------------------------------------------------------------------
' �E�V�t�g
'------------------------------------------------------------------------------------------------------------------------
Public Function RShift(ByVal lngValue As Long, ByVal lngKeta As Long) As Long
    RShift = lngValue \ (2 ^ lngKeta)
End Function
