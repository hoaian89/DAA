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

Imports System.IO
Imports System.Xml
Imports System.Net
Imports System.Web
Imports DotNetNuke
Imports DotNetNuke.Modules.XML

Namespace DotNetNuke.Modules.XML

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' The XmlModule Class provides the UI for displaying the XML
    ''' </summary>
    ''' -----------------------------------------------------------------------------
    Public Partial Class XmlModule
        Inherits DotNetNuke.Entities.Modules.PortalModuleBase
        Implements DotNetNuke.Entities.Modules.IActionable

#Region "Private Fields"
        Private controller As XmlController
        Private currentMode As ShowMode = ShowMode.Inline
#End Region

#Region "Overrides"
        Protected Overrides Sub Render(ByVal output As System.Web.UI.HtmlTextWriter)
            If currentMode = ShowMode.Inline Then
                output.WriteBeginTag("span")
                output.WriteAttribute("class", "normal")
                output.Write(HtmlTextWriter.TagRightChar)
                Try
                    controller.Render(output)
                Catch exc As Exception    'Module failed to load
                    ProcessModuleLoadException(Me, exc)
                    'UI.Skins.Skin.AddModuleMessage don't work during render time
                    If Me.IsEditable Then output.Write("<table class=""normal"" ><tr><td><img src=""{2}""></td><td><span style=""COLOR: red""><strong>{1}</strong></span><br/>{0}</td></tr></table>", exc.Message, exc.GetType.FullName, ResolveUrl("~/images/red-error.gif"))
                Finally
                    output.WriteEndTag("span")
                End Try
            Else ' currentMode = ShowMode.Link 
                MyBase.Render(output)
            End If
        End Sub
#End Region

#Region "Event Handlers"

        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' Page_Load runs when the control is loaded
        ''' </summary>
        ''' -----------------------------------------------------------------------------
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Try
                controller = New XmlController(Me)
                currentMode = controller.checkShowMode(CStrN(Request.QueryString("ShowMode")))
                Dim DownloadLink As String = ResolveUrl("~" & Definition.PathOfModule & "download.ashx") & "?tabid=" & TabId.ToString & "&mid=" & ModuleId.ToString

                If currentMode = ShowMode.Response Then
                    Response.Redirect(DownloadLink)
                ElseIf currentMode = ShowMode.Link Then
                    lnkShowContent.NavigateUrl = DownloadLink
                End If
            Catch exc As System.Security.SecurityException
                UI.Skins.Skin.AddModuleMessage(Me, Localization.GetString("CAS.ErrorMessage", LocalResourceFile), Skins.Controls.ModuleMessage.ModuleMessageType.YellowWarning)
            Catch exc As Exception    'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

#End Region


#Region "Optional Interfaces"

        Public ReadOnly Property ModuleActions() As DotNetNuke.Entities.Modules.Actions.ModuleActionCollection Implements DotNetNuke.Entities.Modules.IActionable.ModuleActions
            Get
                Dim Actions As New DotNetNuke.Entities.Modules.Actions.ModuleActionCollection
                Actions.Add(GetNextActionID, Localization.GetString(DotNetNuke.Entities.Modules.Actions.ModuleActionType.AddContent, LocalResourceFile), DotNetNuke.Entities.Modules.Actions.ModuleActionType.AddContent, "", "", EditUrl(), False, Security.SecurityAccessLevel.Edit, True, False)
                Return Actions
            End Get
        End Property

#End Region

#Region " Web Form Designer Generated Code "

        'This call is required by the Web Form Designer.
        <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

        End Sub

        Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
            'CODEGEN: This method call is required by the Web Form Designer
            'Do not modify it using the code editor.
            InitializeComponent()
        End Sub

#End Region


    End Class

End Namespace

