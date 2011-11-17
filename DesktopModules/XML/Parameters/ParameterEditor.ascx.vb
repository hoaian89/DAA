'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2007 by DotNetNuke Inc.
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
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Imports DotNetNuke.Entities.Modules
Imports DotNetNuke.UI.Skins
Imports DotNetNuke.UI.Skins.Controls
Imports DotNetNuke.UI.UserControls
Imports DotNetNuke.UI.Utilities



Namespace DotNetNuke.Modules.XML

    Public Partial Class ParameterEditor
        Inherits System.Web.UI.UserControl


#Region "| Sub-Classes |"

        ''' <summary>
        ''' Represents misc constants for the <see cref="ParameterEditor"/> control.
        ''' </summary>
        Private NotInheritable Class Constants
            Public Const TableHeadScope As String = "scope"
            Public Const TableHeadRowScope As String = "row"
            Public Const TableHeadColScope As String = "col"
        End Class


        ''' <summary>
        ''' Represents child control names for the <see cref="ParameterEditor"/> control.
        ''' </summary>
        Private NotInheritable Class ControlNames
            Public Const ParameterDeleteButton As String = "cmdDeleteParam"
            Public Const ParameterNameLabel As String = "lblParamName"
            Public Const ParameterName As String = "txtParamName"
            Public Const ParameterTypeLabel As String = "lblParamType"
            Public Const ParameterType As String = "cboParamType"
            Public Const ParameterArgumentLabel As String = "lblParamArgument"
            Public Const ParameterArgument As String = "txtParamArgument"
            Public Const ParameterScript As String = "lblParamScript"
            Public Const ParameterIsValueRequired As String = "chkRequired"
            Public Const ParameterIsValueRequiredLabel As String = "lblRequired"
        End Class


        ''' <summary>
        ''' Represents localization keys for the <see cref="ParameterEditor"/> control.
        ''' </summary>
        Protected NotInheritable Class LocaleKeys
            Public Const ParameterNameHeader As String = "Name.Header"
            Public Const ParameterTypeHeader As String = "Type.Header"
            Public Const ParameterArgumentHeader As String = "Argument.Header"
            Public Const ParameterDeleteConfirmation As String = "DeleteParamConfirmation"
            Public Const ParameterIsValueRequiredHeader As String = "IsValueRequired.Header"
            Public Const ParameterInvalidHeader As String = "ParameterInvalid.Header"
            Public Const ParameterInvalid As String = "ParameterInvalid"
            Public Const ParameterFallback As String = "ParameterFallback"
        End Class


#End Region

        Private _ModuleId As Integer
        Private _Purpose As String = String.Empty
        Private _localResourceFile As String
        Private _isStatic As Boolean = True
        Private _RequiredValuesNeeded As Boolean = False
        Private _SupportsFallbackValues As Boolean = False

        Public Property ModuleId() As Integer
            Get
                Return _ModuleId
            End Get
            Set(ByVal value As Integer)
                _ModuleId = value
            End Set
        End Property

        Public Property Purpose() As String
            Get
                Return _Purpose
            End Get
            Set(ByVal value As String)
                _Purpose = value
            End Set
        End Property

        Public ReadOnly Property IsStatic() As Boolean
            Get
                Return _isStatic
            End Get
        End Property

        Public Property RequiredValuesNeeded() As Boolean
            Get
                Return _RequiredValuesNeeded
            End Get
            Set(ByVal Value As Boolean)
                _RequiredValuesNeeded = Value
            End Set
        End Property

        Public Property SupportsFallbackValues() As Boolean
            Get
                Return _SupportsFallbackValues
            End Get
            Set(ByVal value As Boolean)
                _SupportsFallbackValues = value
            End Set
        End Property

        Protected ReadOnly Property LocalResourceFile() As String
            Get
                Return "~" & PathOfModule & Services.Localization.Localization.LocalResourceDirectory & "/EditXml.ascx.resx"
            End Get
        End Property

        Protected Sub grdParams_CancelCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdParams.CancelCommand

            Try
                grdParams.EditItemIndex = -1
                BindParameters()
            Catch exc As Exception 'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        Protected Sub grdParams_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdParams.DeleteCommand
            Try
                ' init vars
                Dim objController As New ParameterController(Purpose)
                Dim objParamKey As New ParameterInfo.UniqueKey

                ' assign key values
                objParamKey.ID = Convert.ToInt32(grdParams.DataKeys(e.Item.ItemIndex))

                ' delete parameter
                objController.DeleteParameter(objParamKey)

                ' reset edit row
                grdParams.EditItemIndex = -1
                BindParameters()
            Catch exc As Exception 'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        Protected Sub grdParams_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdParams.EditCommand
            Try
                SaveParameterEditRow(source, grdParams)
                grdParams.EditItemIndex = e.Item.ItemIndex
                grdParams.SelectedIndex = -1
                BindParameters()
            Catch exc As Exception 'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        Protected Sub grdParams_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdParams.ItemCreated
            Try
                ' add delete confirmation
                Dim cmdDeleteParam As Control = e.Item.FindControl(ControlNames.ParameterDeleteButton)
                If Not cmdDeleteParam Is Nothing Then
                    ClientAPI.AddButtonConfirm(CType(cmdDeleteParam, WebControl), Localization.GetString(LocaleKeys.ParameterDeleteConfirmation, Me.LocalResourceFile))
                End If

                ' add accessible column headers
                If e.Item.ItemType = ListItemType.Header Then
                    e.Item.Cells(1).Attributes.Add(Constants.TableHeadScope, Constants.TableHeadColScope)
                    e.Item.Cells(2).Attributes.Add(Constants.TableHeadScope, Constants.TableHeadColScope)
                End If
            Catch exc As Exception
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        Protected Sub grdParams_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdParams.ItemDataBound
            Try
                Const LabelFormat As String = "<label style=""display:none;"" for=""{0}"">{1}</label>"
                Dim objItemType As ListItemType = CType(e.Item.ItemType, ListItemType)
                If objItemType = ListItemType.EditItem Then
                    Dim ctlLabel As Label
                    Dim ctlSetting As Control
                    Dim strTypeID As String
                    Dim strArgID As String

                    ' name
                    ctlLabel = CType(e.Item.FindControl(ControlNames.ParameterNameLabel), Label)
                    ctlSetting = e.Item.FindControl(ControlNames.ParameterName)
                    ctlLabel.Text = String.Format(LabelFormat, ctlSetting.ClientID.ToString(), Localization.GetString(LocaleKeys.ParameterNameHeader, LocalResourceFile))

                    'required
                    ctlLabel = CType(e.Item.FindControl(ControlNames.ParameterIsValueRequiredLabel), Label)
                    ctlSetting = e.Item.FindControl(ControlNames.ParameterIsValueRequired)
                    ctlLabel.Text = String.Format(LabelFormat, ctlSetting.ClientID.ToString(), Localization.GetString(LocaleKeys.ParameterIsValueRequiredHeader, LocalResourceFile))

                    ' type - also add javascript to show/hide arg textbox
                    ctlLabel = CType(e.Item.FindControl(ControlNames.ParameterTypeLabel), Label)
                    ctlSetting = e.Item.FindControl(ControlNames.ParameterType)
                    ctlLabel.Text = String.Format(LabelFormat, ctlSetting.ClientID.ToString(), Localization.GetString(LocaleKeys.ParameterTypeHeader, LocalResourceFile))
                    strTypeID = ctlSetting.ClientID
                    CType(ctlSetting, WebControl).Attributes.Add("onblur", "ParameterEditor_showArgument();")
                    CType(ctlSetting, WebControl).Attributes.Add("onchange", "ParameterEditor_showArgument();")

                    ' argument - also add javascript to set default visiblity based on type
                    ctlLabel = CType(e.Item.FindControl(ControlNames.ParameterArgumentLabel), Label)
                    ctlSetting = e.Item.FindControl(ControlNames.ParameterArgument)
                    '    ctlLabel.Text = String.Format(LabelFormat, ctlSetting.ClientID.ToString(), Localization.GetString(LocaleKeys.ParameterArgumentHeader, LocalResourceFile))
                    strArgID = ctlSetting.ClientID

                    ' add javascript
                    ctlLabel = CType(e.Item.FindControl(ControlNames.ParameterScript), Label)
                    If SupportsFallbackValues Then
                        ctlLabel.Text = "<script type=""text/javascript"">ParameterEditor_showArgument();function ParameterEditor_showArgument(){document.getElementById('" + strArgID + "').style.display=((document.getElementById('" + strTypeID + "').selectedIndex<4)||(document.getElementById('" + strTypeID + "').selectedIndex>8)?'inline':'none');}</script>"
                    Else
                        ctlLabel.Text = "<script type=""text/javascript"">ParameterEditor_showArgument();function ParameterEditor_showArgument(){document.getElementById('" + strArgID + "').style.display=((document.getElementById('" + strTypeID + "').selectedIndex<4)?'inline':'none');}</script>"
                    End If

                End If
            Catch exc As Exception 'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        Protected Sub grdParams_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles grdParams.UpdateCommand
            Try
                ' init vars
                Dim objParam As New ParameterInfo

                ' set values
                If e.Item.ItemIndex > -1 Then _
                    objParam.ID = Convert.ToInt32(grdParams.DataKeys(e.Item.ItemIndex))
                objParam.ModuleID = ModuleId
                objParam.Name = CType(e.Item.FindControl(ControlNames.ParameterName), TextBox).Text
                objParam.Type = CType(e.Item.FindControl(ControlNames.ParameterType), DropDownList).SelectedValue
                If objParam.IsArgumentRequired() OrElse (SupportsFallbackValues AndAlso objParam.SupportsFallbackValue) Then _
                    objParam.TypeArgument = CType(e.Item.FindControl(ControlNames.ParameterArgument), TextBox).Text
                objParam.IsValueRequired = CType(e.Item.FindControl(ControlNames.ParameterIsValueRequired), CheckBox).Checked
                ' add/update param
                If objParam.IsValidDefinition Then
                    Dim objController As New ParameterController(Purpose)
                    If objParam.IsNew Then
                        objController.AddParameter(objParam)
                    Else
                        objController.UpdateParameter(objParam)
                    End If

                    ' clear edit row
                    grdParams.EditItemIndex = -1
                    ' bind data
                    BindParameters()
                Else
                    ErrorMessagePlaceHolder.Controls.Add( _
                         DotNetNuke.UI.Skins.Skin.GetModuleMessageControl( _
                            Localization.GetString(LocaleKeys.ParameterInvalidHeader, LocalResourceFile), _
                            Localization.GetString(LocaleKeys.ParameterInvalid, LocalResourceFile), _
                            ModuleMessage.ModuleMessageType.RedError))

                End If


            Catch exc As Exception 'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        ''' <summary>
        ''' Binds the <see cref="ParameterInfo"/> settings.
        ''' </summary>
        ''' <param name="ShowAddRow">Specifies whether an additional edit row should be displayed.</param>
        Private Sub BindParameters(Optional ByVal ShowAddRow As Boolean = False)
            Dim objController As New ParameterController(Purpose)
            Dim colParams As ParameterList = objController.GetParameters(ModuleId)
            _isStatic = colParams.IsStatic


            ' add new row
            If ShowAddRow Then
                colParams.Add(New ParameterInfo)
                grdParams.EditItemIndex = colParams.Count - 1
            End If



            ' apply data source
            grdParams.DataSource = colParams
            grdParams.DataBind()
            grdParams.Visible = (colParams.Count > 0 OrElse ShowAddRow)
            grdParams.Columns(2).Visible = grdParams.Visible AndAlso RequiredValuesNeeded

            ' bind settings
        End Sub

        Protected Sub cmdAddParam_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdAddParam.Click
            Try
                ' save edit row
                SaveParameterEditRow(sender, cmdAddParam)

                ' add item
                grdParams.EditItemIndex = -1
                BindParameters(True)
            Catch exc As Exception
                ProcessModuleLoadException(Me, exc)
            End Try
        End Sub

        ''' <summary>
        ''' Saves the <see cref="grdParams"/> edit row.
        ''' </summary>
        ''' <param name="originalSender">Original sender.</param>
        ''' <param name="trigger">Object initiating the save.</param>
        Private Sub SaveParameterEditRow(ByVal originalSender As Object, ByVal trigger As Object)
            If grdParams.EditItemIndex > -1 Then
                Dim ie As New DataGridCommandEventArgs(grdParams.Items(grdParams.EditItemIndex), trigger, New CommandEventArgs("Update", Nothing))
                grdParams_UpdateCommand(originalSender, ie)
            End If
        End Sub

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

            If Not Page.IsPostBack AndAlso ModuleId > 0 Then
                Localization.LocalizeDataGrid(grdParams, Me.LocalResourceFile)
                BindParameters()
            End If
        End Sub

        Private Sub InitializeComponent()

        End Sub
    End Class
End Namespace
