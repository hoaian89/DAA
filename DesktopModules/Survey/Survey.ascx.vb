'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2008
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
' 6/2007 - Firefox fix / voting count enhancements provided by Effority.net
' 10/2007 - Result Templates provided by Rutger Buijzen 
' 9/2008 - XHTML fix by Brian Swanson

Imports DotNetNuke
Imports DotNetNuke.Security.Roles
Imports System.Collections.Generic
Namespace DotNetNuke.Modules.Survey

    Partial Class Survey
        Inherits DotNetNuke.Entities.Modules.PortalModuleBase
        Implements Entities.Modules.IActionable

        Private strCookie As String
        Private blnSurveyExpired As Boolean
        Private blnPersonalVoteTracking As Boolean
        Private blnVoted As Boolean
        Private blnPrivateResults As Boolean

        Protected Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Try
                strCookie = "_Module" & ModuleId.ToString & "_Survey"
                blnSurveyExpired = SurveyExpired()
                blnPersonalVoteTracking = SurveyTracking()
                blnPrivateResults = SurveyResultsType()
                blnVoted = HasVoted()

                If Not Page.IsPostBack Then
                    DisplaySurveyPage()
                End If

            Catch exc As Exception        'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

#Region "Survey Closing Date"
        Private Function SurveyExpired() As Boolean
            If Not Settings("surveyclosingdate") Is Nothing Then
                Try
                    If (DateDiff(DateInterval.Day, Now, CDate(Settings("surveyclosingdate"))) > -1) Then
                        Return False
                    Else
                        Return True
                    End If
                Catch
                    Return False
                End Try
            Else
                Return False
            End If
        End Function
#End Region

#Region "Survey Tracking"
        Private Function SurveyTracking() As Boolean
            ' Check the settings to see if this module is using Personalization for vote tracking
            If Not Settings("surveytracking") Is Nothing Then
                Return CType(Settings("surveytracking"), Boolean)
            Else
                Return False
            End If
        End Function
#End Region

#Region "SurveyResultsType"
        Private Function SurveyResultsType() As Boolean
            'If the user is able to edit the module then they are always able to see the results
            If DotNetNuke.Security.PortalSecurity.IsInRoles(Me.ModuleConfiguration.AuthorizedEditRoles) Then
                Return False
            End If

            ' Check the settings to see if this module is using Personalization for vote tracking
            If Not Settings("surveyresultstype") Is Nothing Then
                Return CType(Settings("surveyresultstype"), Boolean)
            Else
                Return False
            End If
        End Function
#End Region

#Region "HasVoted"
        Private Function HasVoted() As Boolean
            If blnPersonalVoteTracking = True Then
                If UserId <> -1 Then
                    ' Check if the user has voted before
                    If Not DotNetNuke.Services.Personalization.Personalization.GetProfile(ModuleId.ToString, "Voted") Is Nothing Then
                        Return CType(DotNetNuke.Services.Personalization.Personalization.GetProfile(ModuleId.ToString, "Voted"), Boolean)
                    Else
                        Return False
                    End If
                Else
                    ' The module is using Personalization but the user is not logged in
                    Return True
                End If
            Else
                ' The Module is not using personalization so look for a cookie
                If Request.Cookies(strCookie) Is Nothing Then
                    Return False
                Else
                    Return True
                End If
            End If

        End Function
#End Region

#Region "Display Survey Page"
        Private Sub DisplaySurveyPage()
            ' Only show Survey if it is not expired
            If Not blnSurveyExpired Then
                If (blnPersonalVoteTracking) And (UserId = -1) Then
                    ' The User is not logged in and the module is using personalization
                    DisplaySurvey()
                    cmdSubmit.Visible = False
                    If blnPrivateResults Then
                        cmdResults.Visible = False
                    End If
                    Message_Label.Text = Localization.GetString("Survey_MustBeSignedIn", Me.LocalResourceFile)
                Else
                    If blnVoted = False Then
                        'They haven't voted so show the Survey
                        DisplaySurvey()
                        ' If the results are private, hide the results link
                        If blnPrivateResults Then
                            cmdResults.Visible = False
                        End If
                    Else
                        'They have voted so display the results
                        DisplayResults()
                    End If
                End If
            Else
                ' Survey is expired so display the results
                DisplayResults()
            End If
        End Sub
#End Region

#Region "Display Survey"
        Private Sub DisplaySurvey()
            pnlResults.Visible = False

            Dim Surveylist As List(Of SurveyInfo)
            Surveylist = SurveyController.GetSurveys(ModuleId)
            If Surveylist.Count > 0 Then
                lstSurvey.DataSource = Surveylist
                lstSurvey.DataBind()
                pnlSurvey.Visible = True
            Else
                pnlSurvey.Visible = False
            End If

        End Sub
#End Region

#Region "Display Results"
        Private Sub DisplayResults()

            lstResults.DataSource = SurveyController.GetSurveys(ModuleId)
            lstResults.DataBind()

            ' Hide the survey items, show the results
            pnlSurvey.Visible = False
            pnlResults.Visible = True

            ' If they can edit the module then they can always see the show survey button
            If (DotNetNuke.Security.PortalSecurity.IsInRoles(Me.ModuleConfiguration.AuthorizedEditRoles)) And (UserId <> -1) Then
                cmdSurvey.Visible = True
            Else
                ' If the results are private, hide the results and the results link
                If blnPrivateResults Then
                    lstResults.Visible = False
                    cmdResults.Visible = False
                    'Only display this message if they have not just voted
                    If Message_Label.Text = "" Then
                        Message_Label.Text = Localization.GetString("AlreadyVoted", Me.LocalResourceFile)
                    End If
                End If

                ' If they have voted or the Survey has expired, 
                ' or the survey uses personalization and they are not logged in
                ' hide the button to show the Survey items
                If (Not blnVoted And Not blnSurveyExpired) Or ((blnPersonalVoteTracking) And (UserId = -1)) Then
                    cmdSurvey.Visible = True
                Else
                    cmdSurvey.Visible = False
                End If
            End If

        End Sub
#End Region

#Region "Form Events"
        Private Sub cmdSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click
            Dim objRadioButtonList As RadioButtonList
            Dim objCheckBoxList As CheckBoxList
            Dim objSurvey As SurveyInfo
            Dim intSurvey As Integer
            Dim objSurveyOption As New SurveyOptionInfo
            Dim intSurveyOption As Integer
            Dim intQuestion As Integer
            Dim intOption As Integer
            Dim blnValid As Boolean = True
            Dim blntmpValid As Boolean = False

            intQuestion = -1
            Try
                If (HasVoted() = False) Then
                    Dim arrSurveys As List(Of SurveyInfo) = SurveyController.GetSurveys(ModuleId)
                    For intSurvey = 0 To arrSurveys.Count - 1
                        objSurvey = arrSurveys(intSurvey)
                        intQuestion += 1
                        Select Case objSurvey.OptionType
                            Case "R"
                                objRadioButtonList = Me.FindControl("lstSurvey").Controls(intQuestion).FindControl("optOptions")
                                If Not IsNothing(objRadioButtonList) Then
                                    If objRadioButtonList.SelectedIndex = -1 Then
                                        blnValid = False
                                    End If
                                End If
                            Case "C"
                                objCheckBoxList = Me.FindControl("lstSurvey").Controls(intQuestion).FindControl("chkOptions")
                                blntmpValid = False
                                intOption = -1
                                Dim arrSurveyOptions As List(Of SurveyOptionInfo) = SurveyOptionController.GetSurveyOptions(objSurvey.SurveyId)
                                For intSurveyOption = 0 To arrSurveyOptions.Count - 1
                                    intOption += 1
                                    If Not IsNothing(objCheckBoxList.Items(intOption)) Then
                                        If objCheckBoxList.Items(intOption).Selected = True Then
                                            blntmpValid = True
                                        End If
                                    End If
                                Next
                                If blntmpValid = False Then
                                    blnValid = False
                                End If
                        End Select
                    Next

                    If blnValid Then
                        intQuestion = -1
                        For intSurvey = 0 To arrSurveys.Count - 1
                            objSurvey = CType(arrSurveys(intSurvey), SurveyInfo)
                            intQuestion += 1
                            Select Case objSurvey.OptionType
                                Case "R"
                                    If Not IsNothing(Me.FindControl("lstSurvey").Controls(intQuestion).FindControl("optOptions")) Then
                                        objRadioButtonList = Me.FindControl("lstSurvey").Controls(intQuestion).FindControl("optOptions")
                                        objSurveyOption.SurveyOptionId = Convert.ToInt32(objRadioButtonList.SelectedValue)
                                        If blnPersonalVoteTracking = True Then
                                            SurveyOptionController.AddSurveyResult(objSurveyOption, UserId)
                                        Else
                                            SurveyOptionController.AddSurveyResult_cookie(objSurveyOption, UserId)
                                        End If
                                    End If
                                Case "C"
                                    intOption = -1
                                    objCheckBoxList = Me.FindControl("lstSurvey").Controls(intQuestion).FindControl("chkOptions")
                                    Dim arrSurveyOptions As List(Of SurveyOptionInfo) = SurveyOptionController.GetSurveyOptions(objSurvey.SurveyId)
                                    For intSurveyOption = 0 To arrSurveyOptions.Count - 1
                                        objSurveyOption = CType(arrSurveyOptions(intSurveyOption), SurveyOptionInfo)
                                        intOption += 1
                                        If Not IsNothing(objCheckBoxList.Items(intOption)) Then
                                            If objCheckBoxList.Items(intOption).Selected = True Then
                                                If blnPersonalVoteTracking = True Then
                                                    SurveyOptionController.AddSurveyResult(objSurveyOption, UserId)
                                                Else
                                                    SurveyOptionController.AddSurveyResult_cookie(objSurveyOption, UserId)
                                                End If
                                            End If
                                        End If
                                    Next
                            End Select
                        Next

                        Message_Label.Text = Localization.GetString("SurveyComplete", Me.LocalResourceFile)

                        If blnPersonalVoteTracking = True Then
                            ' This means the module vote tracking is using personalization, so set the profile to show they have voted
                            DotNetNuke.Services.Personalization.Personalization.SetProfile(ModuleId.ToString, "Voted", True)
                            blnVoted = True
                            DisplayResults()
                        Else
                            ' Store a cookie to show the chart after the submit
                            Dim objCookie As HttpCookie = New HttpCookie("_Module" & ModuleId.ToString & "_Survey")
                            objCookie.Value = "True"
                            objCookie.Expires = DateTime.MaxValue       ' never expires
                            Response.AppendCookie(objCookie)
                            blnVoted = True
                            DisplayResults()
                        End If
                    Else
                        Message_Label.Text = Localization.GetString("SurveyIncomplete", Me.LocalResourceFile)
                    End If

                Else
                    DisplayResults()
                End If

            Catch exc As Exception        'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        Private Sub cmdResults_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdResults.Click
            DisplayResults()
        End Sub

        Private Sub cmdSurvey_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSurvey.Click
            DisplaySurvey()
        End Sub
#End Region

#Region "Databound Events"

        Private Sub lstSurvey_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles lstSurvey.ItemDataBound

            Dim objSurvey As SurveyInfo = SurveyController.GetSurvey(Int32.Parse(lstSurvey.DataKeys(e.Item.ItemIndex).ToString), ModuleId)
            If Not objSurvey Is Nothing Then
                Dim SurveyOptionList As New List(Of SurveyOptionInfo)
                SurveyOptionList = SurveyOptionController.GetSurveyOptions(objSurvey.SurveyId)

                Select Case objSurvey.OptionType
                    Case "R"
                        Dim optOptions As RadioButtonList = CType(e.Item.FindControl("optOptions"), RadioButtonList)
                        optOptions.DataSource = SurveyOptionList
                        optOptions.DataTextField = "OptionName"
                        optOptions.DataValueField = "SurveyOptionId"
                        optOptions.DataBind()
                        optOptions.Visible = True
                    Case "C"
                        Dim chkOptions As CheckBoxList = CType(e.Item.FindControl("chkOptions"), CheckBoxList)
                        chkOptions.DataSource = SurveyOptionList
                        chkOptions.DataTextField = "OptionName"
                        chkOptions.DataValueField = "SurveyOptionId"
                        chkOptions.DataBind()
                        chkOptions.Visible = True
                End Select
            End If

        End Sub

        Private Sub lstResults_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles lstResults.ItemDataBound

            Dim objSurvey As SurveyInfo
            Dim objSurveyOption As SurveyOptionInfo
            Dim intSurveyOption As Integer
            Dim strHTML As String
            Dim intGraphWidth As Integer = 400
            Dim strSurveyResultTemplate As String = ""

            If CType(Settings("surveygraphwidth"), String) <> "" Then
                intGraphWidth = Int32.Parse(CType(Settings("surveygraphwidth"), String))
            End If

            strHTML = "<br /><div class=""surveyresulttemplateUL"">"

            objSurvey = SurveyController.GetSurvey(Int32.Parse(lstResults.DataKeys(e.Item.ItemIndex).ToString), ModuleId)
            If Not objSurvey Is Nothing Then
                Dim arrSurveyOptions As List(Of SurveyOptionInfo) = SurveyOptionController.GetSurveyOptions(objSurvey.SurveyId)
                For intSurveyOption = 0 To arrSurveyOptions.Count - 1

                    'Get or create Template
                    If CType(Settings("surveyresulttemplate"), String) Is Nothing Then
                        strSurveyResultTemplate = DefaultSurveyResultTemplate()
                    Else
                        strSurveyResultTemplate = CType(Settings("surveyresulttemplate"), String)
                    End If

                    objSurveyOption = arrSurveyOptions(intSurveyOption)

                    Dim dblPercent As Double = 0
                    If objSurvey.Votes <> 0 Then
                        dblPercent = Convert.ToDouble(objSurveyOption.Votes / objSurvey.Votes)
                    End If

                    strHTML += "<div class=""surveyresulttemplateLI"">"

                    strSurveyResultTemplate = strSurveyResultTemplate.Replace("[SURVEY_OPTION_NAME]", FormatSurveyOption(objSurveyOption.OptionName, objSurveyOption.IsCorrect))
                    strSurveyResultTemplate = strSurveyResultTemplate.Replace("[SURVEY_OPTION_VOTES]", objSurveyOption.Votes.ToString)
                    strSurveyResultTemplate = strSurveyResultTemplate.Replace("[SURVEY_OPTION_PERCENTAGE]", CInt(dblPercent * 100).ToString)
                    strSurveyResultTemplate = strSurveyResultTemplate.Replace("[SURVEY_OPTION_GRAPH_WIDTH]", (intGraphWidth * dblPercent))
                    strSurveyResultTemplate = strSurveyResultTemplate.Replace("[SURVEY_OPTION_IMAGEPATH]", Me.TemplateSourceDirectory)

                    strHTML += strSurveyResultTemplate

                    strHTML += "</div>"
                Next
            End If

            strHTML += "</div>"

            Dim litResults As Literal = CType(e.Item.FindControl("litResults"), Literal)
            litResults.Text = strHTML
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

#Region "Utility Functions"
        Public Function FormatQuestion(ByVal strQuestion As String, ByVal ItemNumber As Integer) As String
            Return ItemNumber.ToString & ". " & strQuestion
        End Function

        Private Function FormatSurveyOption(ByVal OptionName As String, ByVal IsCorrect As Boolean) As String
            If IsCorrect Then
                If OptionName.StartsWith(">") = True And OptionName.EndsWith("<") = True Then
                    Return OptionName
                Else
                    Return ">" & OptionName & "<"
                End If
            Else
                If OptionName.StartsWith(">") = True And OptionName.EndsWith("<") = True Then
                    Return OptionName.Substring(1, OptionName.Length - 2)
                Else
                    Return OptionName
                End If
            End If
        End Function
#End Region

#Region "Optional Interfaces"

        Public ReadOnly Property ModuleActions() As DotNetNuke.Entities.Modules.Actions.ModuleActionCollection Implements DotNetNuke.Entities.Modules.IActionable.ModuleActions
            Get
                Dim Actions As New Entities.Modules.Actions.ModuleActionCollection
                Actions.Add(GetNextActionID, Localization.GetString(Entities.Modules.Actions.ModuleActionType.AddContent, LocalResourceFile), Entities.Modules.Actions.ModuleActionType.AddContent, "", "", EditUrl(), False, SecurityAccessLevel.Edit, True, False)
                Return Actions
            End Get
        End Property

#End Region

    End Class

End Namespace

