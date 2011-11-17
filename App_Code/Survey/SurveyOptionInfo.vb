'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2007
' by DotNetNuke Corporation
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

Imports System
Imports System.Data
Imports DotNetNuke

Namespace DotNetNuke.Modules.Survey

    Public Class SurveyOptionInfo

        ' local property declarations
        Private _SurveyOptionId As Integer
        Private _SurveyId As Integer
        Private _ViewOrder As Integer
        Private _OptionName As String
        Private _Votes As Integer
        Private _IsCorrect As Boolean
        Private _UserId As Integer

        ' initialization
        Public Sub New()
        End Sub

        ' public properties
        Public Property SurveyOptionId() As Integer
            Get
                Return _SurveyOptionId
            End Get
            Set(ByVal Value As Integer)
                _SurveyOptionId = Value
            End Set
        End Property

        Public Property SurveyId() As Integer
            Get
                Return _SurveyId
            End Get
            Set(ByVal Value As Integer)
                _SurveyId = Value
            End Set
        End Property

        Public Property ViewOrder() As Integer
            Get
                Return _ViewOrder
            End Get
            Set(ByVal Value As Integer)
                _ViewOrder = Value
            End Set
        End Property

        Public Property OptionName() As String
            Get
                Return _OptionName
            End Get
            Set(ByVal Value As String)
                _OptionName = Value
            End Set
        End Property

        Public Property Votes() As Integer
            Get
                Return _Votes
            End Get
            Set(ByVal Value As Integer)
                _Votes = Value
            End Set
        End Property

        Public Property IsCorrect() As Boolean
            Get
                Return _IsCorrect
            End Get
            Set(ByVal Value As Boolean)
                _IsCorrect = Value
            End Set
        End Property

        Public Property UserId() As Integer
            Get
                Return _UserId
            End Get
            Set(ByVal Value As Integer)
                _UserId = Value
            End Set
        End Property
    End Class

End Namespace

