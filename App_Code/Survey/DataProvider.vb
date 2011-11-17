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
Imports DotNetNuke

Namespace DotNetNuke.Modules.Survey

    Public MustInherit Class DataProvider

        ' singleton reference to the instantiated object 
        Private Shared objProvider As DataProvider = Nothing

        ' constructor
        Shared Sub New()
            CreateProvider()
        End Sub

        ' dynamically create provider
        Private Shared Sub CreateProvider()
            objProvider = CType(Framework.Reflection.CreateObject("data", "DotNetNuke.Modules.Survey", ""), DataProvider)
        End Sub

        ' return the provider
        Public Shared Shadows Function Instance() As DataProvider
            Return objProvider
        End Function

        ' all core methods defined below

        Public MustOverride Function GetSurveys(ByVal ModuleId As Integer) As IDataReader
        Public MustOverride Function GetSurvey(ByVal SurveyID As Integer, ByVal ModuleId As Integer) As IDataReader
        Public MustOverride Function GetSurveyResultData(ByVal ModuleId As Integer) As IDataReader
        Public MustOverride Function AddSurvey(ByVal ModuleId As Integer, ByVal Question As String, ByVal ViewOrder As Integer, ByVal OptionType As String, ByVal UserId As Integer) As Integer
        Public MustOverride Sub UpdateSurvey(ByVal SurveyId As Integer, ByVal Question As String, ByVal ViewOrder As Integer, ByVal OptionType As String, ByVal UserId As Integer, ByVal ModuleId As Integer)
        Public MustOverride Sub DeleteSurvey(ByVal SurveyID As Integer, ByVal ModuleId As Integer)
        Public MustOverride Function GetSurveyOptions(ByVal SurveyId As Integer) As IDataReader
        Public MustOverride Function AddSurveyOption(ByVal SurveyId As Integer, ByVal OptionName As String, ByVal ViewOrder As Integer, ByVal IsCorrect As Boolean) As Integer
        Public MustOverride Sub UpdateSurveyOption(ByVal SurveyOptionId As Integer, ByVal OptionName As String, ByVal ViewOrder As Integer, ByVal IsCorrect As Boolean)
        Public MustOverride Sub DeleteSurveyOption(ByVal SurveyOptionID As Integer)
        Public MustOverride Sub AddSurveyResult(ByVal SurveyOptionId As Integer, ByVal UserId As Integer)
        Public MustOverride Sub AddSurveyResult_cookie(ByVal SurveyOptionId As Integer, ByVal UserId As Integer)
        Public MustOverride Sub DeleteSurveyResultData(ByVal ModuleId As Integer)

    End Class

End Namespace
