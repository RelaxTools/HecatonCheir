Attribute VB_Name = "CallbackHelper"
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
'>### CallbackHelper �W�����W���[��
'>
'>**Remarks**
'>
'>- Callback�N���X�ƘA�g���ăN���X���W���[������OnAction���̃��W�b�N���J�v�Z��������B
'>
'-----------------------------------------------------------------------------------------------------
Option Private Module
Option Explicit

'Callback�p
Private mCallback As IDictionary
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
