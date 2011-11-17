<%@ Control Language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Survey.Survey"
    CodeFile="Survey.ascx.vb" %>
<table id="Table1" cellspacing="1" cellpadding="1" width="100%" border="0">
    <tr>
        <td align="right">
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Label1" runat="server" EnableViewState="False" CssClass="NormalBold"></asp:Label>
            <asp:Panel ID="pnlSurvey" runat="server" Visible="False">
                <asp:DataList ID="lstSurvey" runat="server" CellPadding="4" DataKeyField="SurveyId"
                    CssClass="survey">
                    <ItemTemplate>
                        <asp:HyperLink ID="cmdEdit2" ImageUrl="~/images/edit.gif" NavigateUrl='<%# EditURL("SurveyId",DataBinder.Eval(Container.DataItem,"SurveyId")) %>'
                            Visible="<%# IsEditable %>" runat="server" />
                        <asp:Label ID="QuestionLabel" runat="server" Text='<%# Eval("Question") %>' CssClass="NormalBold"></asp:Label><br />
                        <asp:RadioButtonList ID="optOptions" runat="server" CssClass="Normal">
                        </asp:RadioButtonList>
                        <asp:CheckBoxList ID="chkOptions" runat="server" CssClass="Normal">
                        </asp:CheckBoxList><br />
                    </ItemTemplate>
                    <ItemStyle CssClass="surveyitems" />
                </asp:DataList>
                <asp:LinkButton ID="cmdSubmit" runat="server" resourcekey="cmdSubmit" CssClass="CommandButton">Submit Survey</asp:LinkButton>&nbsp;
                <asp:LinkButton ID="cmdResults" runat="server" resourcekey="cmdResults" CssClass="CommandButton">View Results</asp:LinkButton></asp:Panel>
            <asp:Label ID="Message_Label" runat="server" EnableViewState="False" CssClass="NormalBold"></asp:Label>
            <asp:Panel ID="pnlResults" runat="server" Visible="False">
                <asp:DataList ID="lstResults" runat="server" CellPadding="4" DataKeyField="SurveyId"
                    CssClass="surveyresults">
                    <ItemTemplate>
                        <asp:HyperLink ID="cmdEdit2" ImageUrl="~/images/edit.gif" NavigateUrl='<%# EditURL("SurveyId",DataBinder.Eval(Container.DataItem,"SurveyId")) %>'
                            Visible="<%# IsEditable %>" runat="server" />
                        <asp:Label ID="lblQuestion2" runat="server" CssClass="NormalBold" Text='<%# FormatQuestion(DataBinder.Eval(Container.DataItem,"Question"),lstResults.Items.Count + 1) %>'>
                        </asp:Label><br />
                        <asp:Literal ID="litResults" runat="server"></asp:Literal>
                        <br />
                    </ItemTemplate>
                    <ItemStyle CssClass="surveyresultsitems" />
                </asp:DataList>
                <asp:LinkButton ID="cmdSurvey" runat="server" resourcekey="cmdSurvey" CssClass="CommandButton">View Survey</asp:LinkButton>
            </asp:Panel>
        </td>
    </tr>
</table>
