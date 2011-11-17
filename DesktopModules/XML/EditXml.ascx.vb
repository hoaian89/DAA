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
Imports DotNetNuke
Imports DotNetNuke.Common
Imports DotNetNuke.Modules.XML
Imports System.Web


Namespace DotNetNuke.Modules.XML

    ''' -----------------------------------------------------------------------------
    ''' <summary>
	''' The EditXml PortalModuleBase is used to manage the XML
	''' </summary>
    ''' -----------------------------------------------------------------------------
	Public Partial Class EditXml
        Inherits DotNetNuke.Entities.Modules.PortalModuleBase




#Region "Event Handlers"
        ''' <summary>
        ''' Page_Load runs when the control is loaded
        ''' </summary>
        ''' <param name="sender"></param>
        ''' <param name="e"></param>
        ''' <remarks></remarks>
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Try
                rblIndexRun.Enabled = True
                BindSourceSettings()
                BindTransformSettings()
                BindAdvancedSettings()
            Catch exc As Exception    'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        ''' <summary>
        ''' Called before page is rendered
        ''' </summary>
        ''' <param name="sender"></param>
        ''' <param name="e"></param>
        ''' <remarks></remarks>
        Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender
            CheckWhetherParametersAreDynamic()
        End Sub

       
        ''' <summary>
        ''' cmdCancel_Click runs when the cancel button is clicked
        ''' </summary>
        ''' <param name="sender"></param>
        ''' <param name="e"></param>
        ''' <remarks></remarks>
        Private Sub cmdCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdCancel.Click
            Try
                Response.Redirect(NavigateURL(), True)
            Catch exc As Exception    'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub


        ''' <summary>
        ''' cmdUpdate_Click runs when the update button is clicked
        ''' </summary>
        ''' <param name="sender"></param>
        ''' <param name="e"></param>
        ''' <remarks></remarks>
        Private Sub cmdUpdate_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdUpdate.Click
            Try
                If Page.IsValid And UrlAccessIsPermitted() Then
                    ' Update settings in the database
                    Dim objModules As New DotNetNuke.Entities.Modules.ModuleController
                    objModules.UpdateModuleSetting(ModuleId, Setting.SourceUrl, ctlURLxml.Url)
                    objModules.UpdateModuleSetting(ModuleId, Setting.TransUrl, ctlURLxsl.Url)
                    objModules.UpdateModuleSetting(ModuleId, Setting.UrlEncoding, rblQueryStringEncoding.SelectedValue)
                    objModules.UpdateModuleSetting(ModuleId, Setting.SourceAccount, txtAccount.Text)
                    objModules.UpdateModuleSetting(ModuleId, Setting.SourcePassWord, txtPassword.Text)
                    objModules.UpdateModuleSetting(ModuleId, Setting.ContentType, rblContentType.SelectedValue)
                    objModules.UpdateModuleSetting(ModuleId, Setting.IndexRun, rblIndexRun.SelectedValue)
                    objModules.UpdateModuleSetting(ModuleId, Setting.RenderTo, rblOutput.SelectedValue)
                    objModules.UpdateModuleSetting(ModuleId, Setting.EnableParam, txtEnableParam.Text)
                    objModules.UpdateModuleSetting(ModuleId, Setting.EnableValue, txtEnableValue.Text)
                    ' Redirect back to the portal home page
                    Response.Redirect(NavigateURL(), True)
                End If
            Catch exc As Exception    'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        ''' <summary>
        ''' Clear search index of this module
        ''' </summary>
        ''' <param name="sender"></param>
        ''' <param name="e"></param>
        ''' <remarks></remarks>
        Private Sub cmdClearSearchIndex_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdClearSearchIndex.Click
            Dim objController As New XmlController(Me)
            objController.ClearSearchIndex()
        End Sub

        ''' <summary>
        ''' Clears Enable by parameter settings, disable feature
        ''' </summary>
        ''' <param name="sender"></param>
        ''' <param name="e"></param>
        ''' <remarks></remarks>
        Private Sub cmdClearEnableByParam_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdClearEnableByParam.Click
            txtEnableParam.Text = ""
            txtEnableValue.Text = ""
        End Sub

#End Region

#Region "Private Methods"

        ''' <summary>
        ''' Check whether parameters are dynamic
        ''' </summary>
        ''' <remarks></remarks>
        Private Sub CheckWhetherParametersAreDynamic()
            Dim IndexAllowed As Boolean = pedSource.IsStatic AndAlso pedXsl.IsStatic
            rblIndexRun.Enabled = IndexAllowed
            lblDynamicParameter.Visible = Not IndexAllowed
            If Not IndexAllowed Then
                rblIndexRun.SelectedValue = ConvertIndexRunToString(IndexRun.Never)
            End If
        End Sub

        ''' <summary>
        ''' Check needed permissions  (Medium trust)
        ''' </summary>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Private Function UrlAccessIsPermitted() As Boolean
            Dim xmlUrlIsOk As Boolean = ctlURLxml.UrlType <> "U" OrElse ctlURLxml.Url = String.Empty OrElse Utils.CheckWebPermission(ctlURLxml.Url)
            Dim xslUrlIsOk As Boolean = ctlURLxsl.UrlType <> "U" OrElse ctlURLxsl.Url = String.Empty OrElse Utils.CheckWebPermission(ctlURLxsl.Url)
            If Not xmlUrlIsOk Then UI.Skins.Skin.AddModuleMessage(Me, Localization.GetString("XmlWebPermisssion.ErrorMessage", LocalResourceFile), Skins.Controls.ModuleMessage.ModuleMessageType.RedError)
            If Not xslUrlIsOk Then UI.Skins.Skin.AddModuleMessage(Me, Localization.GetString("XslWebPermisssion.ErrorMessage", LocalResourceFile), Skins.Controls.ModuleMessage.ModuleMessageType.RedError)
            Return xmlUrlIsOk And xslUrlIsOk
        End Function

        ''' <summary>
        ''' Bind XML Source settings
        ''' </summary>
        ''' <remarks></remarks>
        Private Sub BindSourceSettings()
            'LoadSettings
            pedSource.ModuleId = ModuleId
            If Not Page.IsPostBack Then
                Dim xmlsrc As String = CStrN(Settings(Setting.SourceUrl))
                ctlURLxml.Url = xmlsrc
                ctlURLxml.FileFilter = "xml"
                If xmlsrc = "" Then ctlURLxml.UrlType = "U"
                divUrlSettings.Visible = Not (GetURLType(xmlsrc) = Entities.Tabs.TabType.File)
                txtAccount.Text = CStrN(Settings(Setting.SourceAccount))
                txtPassword.Text = CStrN(Settings(Setting.SourcePassWord))
                rblQueryStringEncoding.SelectedValue = CStrN(Settings(Setting.UrlEncoding), "UTF8")
            Else
                'SetVisibility
                divUrlSettings.Visible = ctlURLxml.UrlType = "U"
            End If
        End Sub

        ''' <summary>
        ''' Bind XSL Transformation settings
        ''' </summary>
        ''' <remarks></remarks>
        Private Sub BindTransformSettings()
            pedXsl.ModuleId = ModuleId
            If Not Page.IsPostBack Then
                Dim xslsrc As String = CStrN(Settings(Setting.TransUrl))
                ctlURLxsl.Url = xslsrc
                ctlURLxsl.FileFilter = "xsl,xslt"
                If xslsrc = "" Then ctlURLxsl.UrlType = "F"
            End If
        End Sub

        ''' <summary>
        ''' Bind Advanced Settings
        ''' </summary>
        ''' <remarks></remarks>
        Private Sub BindAdvancedSettings()
            If Not Page.IsPostBack Then
                rblContentType.SelectedValue = CStrN(Settings(Setting.ContentType), "xml|text/xml")
                rblIndexRun.SelectedValue = CStrN(Settings(Setting.IndexRun), "Never")
                rblOutput.SelectedValue = CStrN(Settings(Setting.RenderTo), "Inline").Replace("Default", "Inline")
                txtEnableParam.Text = CStrN(Settings(Setting.EnableParam))
                txtEnableValue.Text = CStrN(Settings(Setting.EnableValue))
            End If
        End Sub

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
