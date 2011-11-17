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
Imports System.Collections.Generic
Imports System.Data
Imports DotNetNuke

Namespace DotNetNuke.Modules.Survey

    Public Class SurveyOptionController
        Public Shared Function GetSurveyOptions(ByVal SurveyId As Integer) As List(Of SurveyOptionInfo)
            Dim SurveyOptionInfolist As List(Of SurveyOptionInfo) = New List(Of SurveyOptionInfo)
            Using dr As IDataReader = DataProvider.Instance().GetSurveyOptions(SurveyId)
                While dr.Read
                    Dim SurveyOptionInfo As SurveyOptionInfo = New SurveyOptionInfo
                    SurveyOptionInfo.SurveyOptionId = Convert.ToInt32(dr("SurveyOptionID"))
                    SurveyOptionInfo.OptionName = Convert.ToString(dr("OptionName"))
                    SurveyOptionInfo.IsCorrect = Convert.ToString(dr("IsCorrect"))
                    SurveyOptionInfo.Votes = Convert.ToInt32(SurveyController.ConvertNullInteger(dr("Votes")))
                    SurveyOptionInfo.ViewOrder = Convert.ToInt32(SurveyController.ConvertNullInteger(dr("ViewOrder")))
                    SurveyOptionInfolist.Add(SurveyOptionInfo)
                End While
            End Using
            Return SurveyOptionInfolist
        End Function
        Public Shared Function GetSurveyResultData(ByVal ModuleId As Integer) As List(Of SurveyResultInfo)
            Dim SurveyResultInfolist As List(Of SurveyResultInfo) = New List(Of SurveyResultInfo)
            Using dr As IDataReader = DataProvider.Instance().GetSurveyResultData(ModuleId)
                While dr.Read
                    Dim SurveyResultInfo As SurveyResultInfo = New SurveyResultInfo
                    SurveyResultInfo.UserId = Convert.ToInt32(dr("UserID"))
                    SurveyResultInfo.OptionName = Convert.ToString(dr("OptionName"))
                    SurveyResultInfo.IsCorrect = Convert.ToString(dr("IsCorrect"))
                    SurveyResultInfo.Question = Convert.ToString(dr("Question"))
                    SurveyResultInfo.OptionType = Convert.ToString(dr("OptionType"))
                    SurveyResultInfolist.Add(SurveyResultInfo)
                End While
            End Using
            Return SurveyResultInfolist
        End Function
        Public Shared Sub DeleteSurveyOption(ByVal objSurveyOption As SurveyOptionInfo)
            DataProvider.Instance().DeleteSurveyOption(objSurveyOption.SurveyOptionId)
        End Sub
        Public Shared Function AddSurveyOption(ByVal objSurveyOption As SurveyOptionInfo) As Integer
            Return CType(DataProvider.Instance().AddSurveyOption(objSurveyOption.SurveyId, objSurveyOption.OptionName, objSurveyOption.ViewOrder, objSurveyOption.IsCorrect), Integer)
        End Function
        Public Shared Sub UpdateSurveyOption(ByVal objSurveyOption As SurveyOptionInfo)
            DataProvider.Instance().UpdateSurveyOption(objSurveyOption.SurveyOptionId, objSurveyOption.OptionName, objSurveyOption.ViewOrder, objSurveyOption.IsCorrect)
        End Sub
        Public Shared Sub AddSurveyResult(ByVal objSurveyOption As SurveyOptionInfo, ByVal UserID As Integer)
            DataProvider.Instance().AddSurveyResult(objSurveyOption.SurveyOptionId, UserID)
        End Sub
        Public Shared Sub AddSurveyResult_cookie(ByVal objSurveyOption As SurveyOptionInfo, ByVal UserID As Integer)
            DataProvider.Instance().AddSurveyResult_cookie(objSurveyOption.SurveyOptionId, UserID)
        End Sub
        Public Shared Sub DeleteSurveyResultData(ByVal ModuleId As Integer)
            DataProvider.Instance().DeleteSurveyResultData(ModuleId)
        End Sub
    End Class

End Namespace

