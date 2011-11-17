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

Imports System.IO
Imports System.Runtime.Serialization.Formatters
Imports System.Collections.Generic
Imports DotNetNuke

Namespace DotNetNuke.Modules.Survey

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' The Settings ModuleSettingsBase is used to manage the 
    ''' settings for the Survey Module
    ''' </summary>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' 	[cnurse]	    10/22/2004	Updated to reflect design changes for Help, 508 support
    '''                       and localisation
    '''		[cnurse]	    10/22/2004	Converted to a ModuleSettingsBase class
    '''     [mwashington]	8/12/2006	Converted to ASP.NET 2.0
    ''' 
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Partial Public Class Settings
        Inherits DotNetNuke.Entities.Modules.ModuleSettingsBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If DotNetNuke.Framework.AJAX.IsInstalled Then
                DotNetNuke.Framework.AJAX.RegisterScriptManager()
                DotNetNuke.Framework.AJAX.RegisterPostBackControl(lnkExport)
            End If
        End Sub

#Region "Base Method Implementations"

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' LoadSettings loads the settings from the Database and displays them
        ''' </summary>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        '''		[cnurse]	10/22/2004	created
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Public Overrides Sub LoadSettings()
            Try
                'this needs to execute always to the client script code is registred in InvokePopupCal
                cmdCalendar.NavigateUrl = DotNetNuke.Common.Utilities.Calendar.InvokePopupCal(txtClosingDate)

                If (Page.IsPostBack = False) Then
                    If CType(ModuleSettings("surveyclosingdate"), String) <> "" Then
                        txtClosingDate.Text = CType(ModuleSettings("surveyclosingdate"), Date).ToShortDateString
                    End If
                    txtGraphWidth.Text = CType(TabModuleSettings("surveygraphwidth"), String)
                    rblstPersonal.SelectedIndex = CType(ModuleSettings("surveytracking"), Integer)
                    rblstSurveyResults.SelectedIndex = CType(ModuleSettings("surveyresultstype"), Integer)

                    'Get or create Template
                    If CType(Settings("surveyresulttemplate"), String) Is Nothing Then
                        txtSurveyResultsTremplate.Text = DefaultSurveyResultTemplate()
                    Else
                        txtSurveyResultsTremplate.Text = CType(Settings("surveyresulttemplate"), String)
                    End If

                End If

            Catch exc As Exception    'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' UpdateSettings saves the modified settings to the Database
        ''' </summary>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        '''		[cnurse]	10/22/2004	created
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Public Overrides Sub UpdateSettings()
            Try
                Dim objModules As New DotNetNuke.Entities.Modules.ModuleController

                Dim datClosingDate As Date = Null.NullDate
                If txtClosingDate.Text.Trim.Length > 0 Then
                    If IsDate(txtClosingDate.Text.Trim) Then
                        datClosingDate = Convert.ToDateTime(txtClosingDate.Text.Trim)
                    End If
                End If

                'Update Module Settings
                objModules.UpdateModuleSetting(ModuleId, "surveyclosingdate", DotNetNuke.Common.Globals.DateToString(datClosingDate))
                objModules.UpdateModuleSetting(ModuleId, "surveytracking", (rblstPersonal.SelectedIndex).ToString)
                objModules.UpdateModuleSetting(ModuleId, "surveyresultstype", (rblstSurveyResults.SelectedIndex).ToString)
                objModules.UpdateModuleSetting(ModuleId, "surveyresulttemplate", txtSurveyResultsTremplate.Text)

                Dim strGraphWidth As String = ""
                If txtGraphWidth.Text.Trim.Length > 0 Then
                    If IsNumeric(txtGraphWidth.Text.Trim) Then
                        strGraphWidth = txtGraphWidth.Text.Trim
                    End If
                End If

                'Update Tab Module Settings
                objModules.UpdateTabModuleSetting(TabModuleId, "surveygraphwidth", strGraphWidth)

            Catch exc As Exception    'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

#End Region

#Region "Export"

        Public Sub ExportData()

            Response.Clear()
            Response.AddHeader("content-disposition", "attachment; filename=Survey_Results_" + ModuleId.ToString + "_" + DateTime.Now.ToShortDateString().Replace("/", "_") + ".csv")
            Response.Charset = ""
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Dim stringWriter As System.IO.StringWriter = New System.IO.StringWriter()
            Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWriter)

            stringWriter.Write("Question,Option,Option Type,Is Correct?,UserID" & vbCrLf)

            Dim colSurveyResultInfo As List(Of SurveyResultInfo) = SurveyOptionController.GetSurveyResultData(ModuleId)
            Dim objSurveyResultInfo As SurveyResultInfo

            For Each objSurveyResultInfo In colSurveyResultInfo
                stringWriter.Write(objSurveyResultInfo.Question & "," & objSurveyResultInfo.OptionName & "," & objSurveyResultInfo.OptionType & "," & objSurveyResultInfo.IsCorrect & "," & objSurveyResultInfo.UserId & vbCrLf)
            Next

            Response.Write(stringWriter.ToString())
            Response.End()

        End Sub

        Protected Sub lnkExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkExport.Click
            ExportData()
        End Sub

#End Region

#Region "Clear Results"

        Protected Sub lnkClear_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkClear.Click
            SurveyOptionController.DeleteSurveyResultData(ModuleId)
            lnkClear.Enabled = False
        End Sub

#End Region

#Region "Default Template"
        Public Function DefaultSurveyResultTemplate() As String
            Dim objModules As New DotNetNuke.Entities.Modules.ModuleController
            Dim strHTML As String = ""

            strHTML += "<table border=""0"" cellpadding=""2"" cellspacing=""0"" summary=""Survey Results"">"
            strHTML += "<tr>"
            strHTML += "<td valign=""top"" class=""YourCompanyNameSurveyResults"">[SURVEY_OPTION_NAME]&nbsp;([SURVEY_OPTION_VOTES])</td>"
            strHTML += "<td align=""left"" valign=""top"" class=""Normal"" nowrap=""nowrap""><img src=""[SURVEY_OPTION_IMAGEPATH]/red.gif"" width=""[SURVEY_OPTION_GRAPH_WIDTH]"" border=""0"" height=""15"" alt="""" />&nbsp;[SURVEY_OPTION_PERCENTAGE]%"
            strHTML += "</td>"
            strHTML += "</tr>"
            strHTML += "</table>"

            objModules.UpdateModuleSetting(ModuleId, "surveyresulttemplate", strHTML)

            Return strHTML
        End Function
#End Region

    End Class

End Namespace


