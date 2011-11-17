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

    Public Class SurveyInfo

        ' local property declarations
        Private _SurveyId As Integer
        Private _ModuleId As Integer
        Private _Question As String
        Private _ViewOrder As Integer
        Private _OptionType As String
        Private _CreatedByUser As Integer
        Private _CreatedDate As Date
        Private _Votes As Integer

        ' initialization
        Public Sub New()
        End Sub

        ' public properties
        Public Property SurveyId() As Integer
            Get
                Return _SurveyId
            End Get
            Set(ByVal Value As Integer)
                _SurveyId = Value
            End Set
        End Property

        Public Property ModuleId() As Integer
            Get
                Return _ModuleId
            End Get
            Set(ByVal Value As Integer)
                _ModuleId = Value
            End Set
        End Property

        Public Property Question() As String
            Get
                Return _Question
            End Get
            Set(ByVal Value As String)
                _Question = Value
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

        Public Property OptionType() As String
            Get
                Return _OptionType
            End Get
            Set(ByVal Value As String)
                _OptionType = Value
            End Set
        End Property

        Public Property CreatedByUser() As Integer
            Get
                Return _CreatedByUser
            End Get
            Set(ByVal Value As Integer)
                _CreatedByUser = Value
            End Set
        End Property

        Public Property CreatedDate() As Date
            Get
                Return _CreatedDate
            End Get
            Set(ByVal Value As Date)
                _CreatedDate = Value
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

    End Class

End Namespace

