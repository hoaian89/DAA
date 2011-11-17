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

Imports DotNetNuke
Imports DotNetNuke.Services.Localization
Imports System.Collections.Generic

Namespace DotNetNuke.Modules.Survey

    Partial Class EditSurvey
        Inherits DotNetNuke.Entities.Modules.PortalModuleBase
        Protected Label5 As System.Web.UI.WebControls.Label

        Dim SurveyId As Integer = -1
        Dim arrSurveyOptions As List(Of SurveyOptionInfo)

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            ' get parameter
            If Not (Request.QueryString("SurveyId") Is Nothing) Then
                SurveyId = Integer.Parse(Request.QueryString("SurveyId"))
            Else
                SurveyId = Null.NullInteger
            End If

            If Page.IsPostBack = False Then

                cmdDelete.Attributes.Add("onClick", "javascript:return confirm('" & Localization.GetString("DeleteItem") & "');")

                If Not Null.IsNull(SurveyId) Then

                    Dim objSurvey As SurveyInfo = SurveyController.GetSurvey(SurveyId, ModuleId)

                    If Not objSurvey Is Nothing Then

                        txtQuestion.Text = objSurvey.Question
                        cboOptionType.Items.FindByValue(objSurvey.OptionType).Selected = True
                        If Not Null.IsNull(objSurvey.ViewOrder) Then
                            txtViewOrder.Text = objSurvey.ViewOrder.ToString
                        End If

                        arrSurveyOptions = SurveyOptionController.GetSurveyOptions(SurveyId)
                        Dim objSurveyOption As SurveyOptionInfo
                        Dim intIndex As Integer
                        For intIndex = 0 To arrSurveyOptions.Count - 1
                            objSurveyOption = CType(arrSurveyOptions(intIndex), SurveyOptionInfo)
                            objSurveyOption.OptionName = FormatSurveyOption(objSurveyOption.OptionName, objSurveyOption.IsCorrect)
                            arrSurveyOptions(intIndex) = objSurveyOption
                        Next

                        lstOptions.DataSource = arrSurveyOptions
                        lstOptions.DataBind()

                        ctlAudit.CreatedByUser = objSurvey.CreatedByUser.ToString
                        ctlAudit.CreatedDate = objSurvey.CreatedDate.ToShortDateString()

                    Else ' security violation attempt to access item not related to this Module

                        Response.Redirect(NavigateURL())

                    End If

                Else ' new item

                    cmdDelete.Visible = False
                    ctlAudit.Visible = False

                End If

            End If

        End Sub

        Private Sub Update_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdUpdate.Click

            Dim objSurvey As New SurveyInfo

            objSurvey.SurveyId = SurveyId
            objSurvey.ModuleId = ModuleId
            objSurvey.Question = txtQuestion.Text
            If txtViewOrder.Text <> "" Then
                objSurvey.ViewOrder = Integer.Parse(txtViewOrder.Text)
            Else
                objSurvey.ViewOrder = Null.NullInteger
            End If
            objSurvey.OptionType = cboOptionType.SelectedItem.Value
            objSurvey.CreatedByUser = UserId

            If Null.IsNull(SurveyId) Then
                SurveyId = SurveyController.AddSurvey(objSurvey)
            Else
                SurveyController.UpdateSurvey(objSurvey)
            End If

            Dim intOption As Integer
            For intOption = 0 To lstOptions.Items.Count - 1

                Dim objSurveyOption As New SurveyOptionInfo

                objSurveyOption.SurveyOptionId = Integer.Parse(lstOptions.Items(intOption).Value)
                objSurveyOption.SurveyId = SurveyId
                objSurveyOption.OptionName = lstOptions.Items(intOption).Text
                objSurveyOption.ViewOrder = intOption
                objSurveyOption.Votes = 0
                objSurveyOption.IsCorrect = False
                If objSurveyOption.OptionName = FormatSurveyOption(objSurveyOption.OptionName, True) Then
                    objSurveyOption.OptionName = FormatSurveyOption(objSurveyOption.OptionName, False)
                    objSurveyOption.IsCorrect = True
                End If

                ' Determine if option is a new option or an existing one

                If Not OptionExits(objSurveyOption) Then
                    SurveyOptionController.AddSurveyOption(objSurveyOption)
                Else
                    SurveyOptionController.UpdateSurveyOption(objSurveyOption)
                End If

            Next

            ' Redirect back to the portal
            Response.Redirect(NavigateURL())

        End Sub

        Private Sub Delete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdDelete.Click

            If Not Null.IsNull(SurveyId) Then
                Dim objSurvey As New SurveyInfo
                objSurvey.SurveyId = SurveyId
                objSurvey.ModuleId = ModuleId
                SurveyController.DeleteSurvey(objSurvey)
            End If

            ' Redirect back to the portal 
            Response.Redirect(NavigateURL())

        End Sub

        Private Sub cmdCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdCancel.Click

            ' Redirect back to the portal 
            Response.Redirect(NavigateURL())

        End Sub

        Private Sub cmdAddOption_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdAddOption.Click

            If txtOption.Text <> "" Then
                Dim blnIsUnique As Boolean = True

                Dim intItem As Integer
                For intItem = 0 To lstOptions.Items.Count - 1
                    If lstOptions.Items(intItem).Text.ToLower = txtOption.Text.ToLower Then
                        blnIsUnique = False
                    End If
                Next

                If blnIsUnique Then
                    Dim strOption As String = FormatSurveyOption(txtOption.Text, chkCorrect.Checked)
                    lstOptions.Items.Add(New ListItem(strOption, lstOptions.Items.Count.ToString()))
                    chkCorrect.Checked = False
                Else
                    DotNetNuke.UI.Skins.Skin.AddModuleMessage(Me, Localization.GetString("OptionExists", Me.LocalResourceFile), DotNetNuke.UI.Skins.Controls.ModuleMessage.ModuleMessageType.YellowWarning)
                End If

                txtOption.Text = ""
            End If

        End Sub

        Private Sub cmdDeleteOption_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles cmdDeleteOption.Click

            Dim objSurveyOptionInfo As New SurveyOptionInfo
            If lstOptions.SelectedIndex <> -1 Then
                If Integer.Parse(lstOptions.SelectedItem.Value) <> -1 Then
                    objSurveyOptionInfo.SurveyOptionId = Integer.Parse(lstOptions.SelectedItem.Value)
                    SurveyOptionController.DeleteSurveyOption(objSurveyOptionInfo)
                End If
                lstOptions.Items.RemoveAt(lstOptions.SelectedIndex)
            End If

        End Sub

        Private Sub cmdUp_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles cmdUp.Click

            If lstOptions.SelectedIndex > 0 Then
                ' save
                Dim intSelectedIndex As Integer = lstOptions.SelectedIndex
                Dim objListItem As ListItem = lstOptions.Items(lstOptions.SelectedIndex)
                ' remove
                lstOptions.Items.Remove(objListItem)
                ' move up
                lstOptions.Items.Insert(intSelectedIndex - 1, objListItem)
            End If

        End Sub

        Private Sub cmdDown_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles cmdDown.Click

            If lstOptions.SelectedIndex < lstOptions.Items.Count - 1 Then
                ' save
                Dim intSelectedIndex As Integer = lstOptions.SelectedIndex
                Dim objListItem As ListItem = lstOptions.Items(lstOptions.SelectedIndex)
                ' remove
                lstOptions.Items.Remove(objListItem)
                ' move up
                lstOptions.Items.Insert(intSelectedIndex + 1, objListItem)
            End If

        End Sub

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

        Private Function OptionExits(ByVal OptionToFind As SurveyOptionInfo) As Boolean
            Dim blnOptionExits As Boolean = False

            arrSurveyOptions = SurveyOptionController.GetSurveyOptions(SurveyId)

            If arrSurveyOptions Is Nothing Then
                Return False
            End If

            Dim objSurveyOptionInfo As SurveyOptionInfo
            For Each objSurveyOptionInfo In arrSurveyOptions
                If objSurveyOptionInfo.OptionName.ToLower = OptionToFind.OptionName.ToLower Then
                    blnOptionExits = True
                End If
            Next

            Return blnOptionExits
        End Function

    End Class

End Namespace


