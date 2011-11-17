'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2007 by DotNetNuke Inc.
'
'
' Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
' documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
' the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
' to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all copies or substantial portions 
' of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
' DEALINGS IN THE SOFTWARE.
'
Option Strict On
Option Explicit On

Imports System
Imports System.Text

Imports DotNetNuke.Entities.Users

Namespace DotNetNuke.Modules.XML


    Public NotInheritable Class ParameterList
        Inherits System.Collections.Generic.List(Of ParameterInfo)

        Private _encoding As System.Text.Encoding = System.Text.Encoding.UTF8

        Public Property Encoding() As System.Text.Encoding
            Get
                Return _encoding
            End Get
            Set(ByVal Value As System.Text.Encoding)
                _encoding = Value
            End Set
        End Property

        Public Overrides Function ToString() As String
            Dim sbValue As New StringBuilder
            Dim bParameterAdded As Boolean = False
            For i As Integer = 0 To Me.Count - 1
                Dim param As String = Me(i).ToString(Encoding)
                If param.Length > 0 Then
                    If bParameterAdded Then sbValue.Append("&")
                    sbValue.Append(param)
                    bParameterAdded = True
                End If
            Next
            Return sbValue.ToString()
        End Function

        Public Function ToXsltArgumentList() As System.Xml.Xsl.XsltArgumentList
            Dim xslArg As New System.Xml.Xsl.XsltArgumentList
            For Each param As ParameterInfo In Me
                If param.IsValidDefinition Then
                    Dim value As String = param.GetValue
                    If value.Length > 0 Then xslArg.AddParam(System.Xml.XmlConvert.EncodeName(param.Name), "", param.GetValue)
                End If
            Next
            Return xslArg
        End Function

        Public Function IsStatic() As Boolean
            If Me.Count = 0 Then
                Return True
            Else
                For Each param As ParameterInfo In Me
                    If Not param.IsStatic Then Return False
                Next
                Return True
            End If
        End Function

        Public Function IsValid() As Boolean
            If Me.Count = 0 Then
                Return True
            Else
                For Each param As ParameterInfo In Me
                    If Not param.IsValidValue Then Return False
                Next
                Return True
            End If
        End Function
    End Class

End Namespace
