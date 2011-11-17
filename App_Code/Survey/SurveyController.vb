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
Imports System.Xml
Imports System.Xml.XPath
Imports System.Data
Imports System.Collections.Generic
Imports DotNetNuke
Imports DotNetNuke.Services.Search
Imports DotNetNuke.Common.Utilities.XmlUtils

Namespace DotNetNuke.Modules.Survey

    Public Class SurveyController
        Implements Entities.Modules.ISearchable

        Implements Entities.Modules.IPortable
        Implements DotNetNuke.Entities.Modules.IUpgradeable

        Public Shared Function GetSurveys(ByVal ModuleId As Integer) As List(Of SurveyInfo)
            Dim SurveyInfolist As List(Of SurveyInfo) = New List(Of SurveyInfo)
            Using dr As IDataReader = DataProvider.Instance().GetSurveys(ModuleId)
                While dr.Read
                    Dim SurveyInfo As SurveyInfo = New SurveyInfo
                    SurveyInfo.SurveyId = Convert.ToInt32(dr("SurveyId"))
                    SurveyInfo.Question = Convert.ToString(dr("Question"))
                    SurveyInfo.OptionType = Convert.ToString(dr("OptionType"))
                    SurveyInfo.ViewOrder = Convert.ToInt32(ConvertNullInteger(dr("ViewOrder")))
                    SurveyInfo.CreatedByUser = Convert.ToInt32(dr("CreatedByUser"))
                    SurveyInfo.CreatedDate = Convert.ToDateTime(dr("CreatedDate"))
                    SurveyInfolist.Add(SurveyInfo)
                End While
            End Using
            Return SurveyInfolist
        End Function

        Public Shared Function GetSurvey(ByVal SurveyID As Integer, ByVal ModuleId As Integer) As SurveyInfo
            Dim SurveyInfo As SurveyInfo = New SurveyInfo
            Using dr As IDataReader = DataProvider.Instance().GetSurvey(SurveyID, ModuleId)
                While dr.Read
                    SurveyInfo.SurveyId = Convert.ToInt32(dr("SurveyId"))
                    SurveyInfo.ModuleId = Convert.ToInt32(dr("ModuleID"))
                    SurveyInfo.Question = Convert.ToString(dr("Question"))
                    SurveyInfo.OptionType = Convert.ToString(dr("OptionType"))
                    SurveyInfo.ViewOrder = Convert.ToInt32(ConvertNullInteger(dr("ViewOrder")))
                    SurveyInfo.Votes = Convert.ToInt32(ConvertNullInteger(dr("Votes")))
                    SurveyInfo.CreatedByUser = Convert.ToInt32(dr("CreatedByUser"))
                    SurveyInfo.CreatedDate = Convert.ToDateTime(dr("CreatedDate"))
                End While
            End Using
            Return SurveyInfo
        End Function

        Public Shared Sub DeleteSurvey(ByVal objSurvey As SurveyInfo)
            DataProvider.Instance().DeleteSurvey(objSurvey.SurveyId, objSurvey.ModuleId)
        End Sub

        Public Shared Function AddSurvey(ByVal objSurvey As SurveyInfo) As Integer
            Return CType(DataProvider.Instance().AddSurvey(objSurvey.ModuleId, objSurvey.Question, objSurvey.ViewOrder, objSurvey.OptionType, objSurvey.CreatedByUser), Integer)
        End Function

        Public Shared Sub UpdateSurvey(ByVal objSurvey As SurveyInfo)
            DataProvider.Instance().UpdateSurvey(objSurvey.SurveyId, objSurvey.Question, objSurvey.ViewOrder, objSurvey.OptionType, objSurvey.CreatedByUser, objSurvey.ModuleId)
        End Sub

#Region " Utility Functions "
        Public Shared Function ConvertNullInteger(ByVal Field As Object) As Integer
            If Field Is DBNull.Value Then
                Return 0
            Else
                Return Convert.ToInt32(Field)
            End If
        End Function
#End Region

#Region " Optional Interfaces "
        Public Function UpgradeModule(ByVal Version As String) As String Implements Entities.Modules.IUpgradeable.UpgradeModule
            Return "Custom upgrade code goes here for Version: " & Version
        End Function
        Public Function ExportModule(ByVal ModuleID As Integer) As String Implements DotNetNuke.Entities.Modules.IPortable.ExportModule
            Dim strXML As New StringBuilder()

            Dim settings As New XmlWriterSettings()
            settings.Indent = True
            settings.OmitXmlDeclaration = True

            Dim Writer As XmlWriter = XmlWriter.Create(strXML, settings)
            '----
            'Outer Loop - To build the Surveys
            Dim colSurveys As List(Of SurveyInfo) = GetSurveys(ModuleID)
            If colSurveys.Count > 0 Then
                Writer.WriteStartElement("surveys")
                Dim SurveyInfo As SurveyInfo
                For Each SurveyInfo In colSurveys
                    Writer.WriteStartElement("survey")
                    Writer.WriteElementString("question", SurveyInfo.Question)
                    Writer.WriteElementString("vieworder", SurveyInfo.ViewOrder)
                    Writer.WriteElementString("createdbyuser", SurveyInfo.CreatedByUser)
                    Writer.WriteElementString("createddate", SurveyInfo.CreatedDate)
                    Writer.WriteElementString("optiontype", SurveyInfo.OptionType.ToString)

                    'Inner Loop - To build the Options for each Survey
                    Dim colSurveyOptions As List(Of SurveyOptionInfo) = SurveyOptionController.GetSurveyOptions(SurveyInfo.SurveyId)
                    If colSurveyOptions.Count > 0 Then
                        Writer.WriteStartElement("surveyoptions")
                        Dim SurveyOptionInfo As SurveyOptionInfo
                        For Each SurveyOptionInfo In colSurveyOptions
                            Writer.WriteStartElement("surveyoption")
                            Writer.WriteElementString("optionname", SurveyOptionInfo.OptionName)
                            Writer.WriteElementString("iscorrect", SurveyOptionInfo.IsCorrect)
                            Writer.WriteElementString("vieworder", SurveyOptionInfo.ViewOrder)
                            Writer.WriteEndElement()
                        Next ' Retrieve the next SurveyOption
                        Writer.WriteEndElement()
                    End If
                    Writer.WriteEndElement()

                Next
                Writer.WriteEndElement()
                Writer.Close()
            Else
                ' There is nothing to export
                Return String.Empty
            End If
            Return strXML.ToString()
        End Function


        Public Sub ImportModule(ByVal ModuleID As Integer, ByVal Content As String, ByVal Version As String, ByVal UserId As Integer) Implements DotNetNuke.Entities.Modules.IPortable.ImportModule

            'Import the Surveys
            'Outer Loop - To insert the Surveys
            Dim intCurrentSurvey As Integer
            Dim xmlSurvey As XmlNode
            Dim xmlSurveys As XmlNode = GetContent(Content, "surveys")

            For Each xmlSurvey In xmlSurveys

                Dim SurveyInfo As New SurveyInfo
                SurveyInfo.ModuleId = ModuleID
                SurveyInfo.Question = xmlSurvey.Item("question").InnerText
                SurveyInfo.ViewOrder = xmlSurvey.Item("vieworder").InnerText
                SurveyInfo.CreatedByUser = xmlSurvey.Item("createdbyuser").InnerText
                SurveyInfo.CreatedDate = xmlSurvey.Item("createddate").InnerText
                SurveyInfo.OptionType = xmlSurvey.Item("optiontype").InnerText

                'Add the Survey to the database
                intCurrentSurvey = AddSurvey(SurveyInfo)

                'Inner Loop - To insert the Survey Options
                Dim xmlSurveyOption As XmlNode
                Dim xmlSurveyOptions As XmlNode = xmlSurvey.SelectSingleNode("surveyoptions")

                For Each xmlSurveyOption In xmlSurveyOptions
                    Dim SurveyOptionInfo As New SurveyOptionInfo
                    SurveyOptionInfo.SurveyId = intCurrentSurvey
                    SurveyOptionInfo.OptionName = xmlSurveyOption.Item("optionname").InnerText
                    SurveyOptionInfo.IsCorrect = xmlSurveyOption.Item("iscorrect").InnerText
                    SurveyOptionInfo.ViewOrder = xmlSurveyOption.Item("vieworder").InnerText

                    'Add the Survey to the database
                    SurveyOptionController.AddSurveyOption(SurveyOptionInfo)
                Next

            Next ' Retrieve the next Survey
        End Sub


#End Region

        Public Function GetSearchItems(ByVal ModInfo As Entities.Modules.ModuleInfo) _
        As Services.Search.SearchItemInfoCollection Implements Entities.Modules.ISearchable.GetSearchItems
            ' Get the Surveys for this Module instance
            Dim colSurveys As List(Of SurveyInfo) = GetSurveys(ModInfo.ModuleID)

            Dim SearchItemCollection As New SearchItemInfoCollection
            Dim SurveyInfo As SurveyInfo

            For Each SurveyInfo In colSurveys
                Dim SearchItem As SearchItemInfo
                SearchItem = New SearchItemInfo _
                (ModInfo.ModuleTitle & " - " & SurveyInfo.Question, _
                SurveyInfo.Question, _
                SurveyInfo.CreatedByUser, _
                SurveyInfo.CreatedDate, ModInfo.ModuleID, _
                SurveyInfo.SurveyId, _
                SurveyInfo.Question)
                SearchItemCollection.Add(SearchItem)
            Next

            Return SearchItemCollection
        End Function

    End Class
End Namespace

