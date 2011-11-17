<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ManageSurvey.ascx.cs" Inherits="DesktopModules_C_Survey_ManageSurvey_" %>

<style type="text/css">
    .style1
    {
        width: 130px;
        text-align: right;
    }
    .style2
    {
        margin-left: 40px;
    }
    #TextArea1
    {
        width: 556px;
        height: 171px;
    }
    #TextArea2
    {
        width: 515px;
        height: 79px;
    }
</style>

<table style="width:100%;">
    <tr>
        <td class="style1">
            Danh sách lớp:</td>
        <td class="style2">
            <asp:ListBox ID="lstClasses" runat="server" Height="163px" Width="343px" 
                DataSourceID="SqlDataSourceClass" DataTextField="ClassName" 
                DataValueField="ClassID">
            </asp:ListBox>
            <asp:SqlDataSource ID="SqlDataSourceClass" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SiteSQLServer %>" 
                DeleteCommand="delete from C_Class where ClassID = @ClassID" 
                InsertCommand="insert into C_Class(ClassName) values(@ClassName)" 
                onload="SqlDataSourceClass_Load" SelectCommand="SELECT * FROM [C_Class]
order by ClassName">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="lstClasses" Name="ClassID" 
                        PropertyName="SelectedValue" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtClass" Name="ClassName" 
                        PropertyName="Text" />
                </InsertParameters>
            </asp:SqlDataSource>
        &nbsp;<asp:Button ID="btnDeleteClass" runat="server" Text="Xóa lớp" Width="63px" 
                onclick="btnDeleteClass_Click" />
        </td>
    </tr>
    <tr>
        <td class="style1">
            Thêm lớp:</td>
        <td class="style2">
            <asp:TextBox ID="txtClass" runat="server" Width="337px"></asp:TextBox>
            &nbsp;<asp:Button ID="btnAddClass" runat="server" Text="Thêm" 
                onclick="btnAddClass_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
    </tr>
    <tr>
        <td class="style1">
            &nbsp;</td>
        <td class="style2">
            <hr />
        </td>
    </tr>
    <tr>
        <td class="style1">
            Câu hỏi:</td>
        <td class="style2">
            <asp:ListBox ID="lstQuestions" runat="server" Height="205px" Width="100%" 
                DataSourceID="SqlDataSourceSurveys" DataTextField="Question" 
                DataValueField="SurveyID">
            </asp:ListBox>
            <asp:SqlDataSource ID="SqlDataSourceSurveys" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SiteSQLServer %>" 
                DeleteCommand="delete from C_Survey where SurveyID = @SurveyId" 
                InsertCommand="sp_InsertSurvey" 
                SelectCommand="SELECT * FROM [C_Survey]" 
                oninserted="SqlDataSourceSurveys_Inserted" UpdateCommand="update C_Survey
set Question = @Question
where SurveyID = @SurveyID" InsertCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="lstQuestions" Name="SurveyId" 
                        PropertyName="SelectedValue" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtQuestion" DbType="String" DefaultValue=" " 
                        Name="Question" PropertyName="Text"/>
                    <asp:Parameter DefaultValue="-1" Direction="Output" Name="SurveyID" 
                        DbType="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtQuestion" Name="Question" 
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="hidSurveyID" Name="SurveyID" 
                        PropertyName="Value" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style1">
            &nbsp;</td>
        <td class="style2">

            <table style="width:100%;">
                <tr>
                    <td>
                        <asp:Button ID="btnAddQuestion" runat="server" Text="Thêm câu hỏi" 
                            onclick="btnAddQuestion_Click" />
                    </td>
                    <td align="center">
                        <asp:Button ID="btnEditQuestion" runat="server" Text="Chỉnh sửa câu hỏi" 
                            Width="126px" onclick="btnEditQuestion_Click" />
                    </td>
                    <td align="right">
                        <asp:Button ID="btnDeleteQuestion" runat="server" Text="Xóa câu hỏi" 
                            onclick="btnDeleteQuestion_Click" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>

<asp:Panel ID="pnlQuestionDetails" runat="server" Visible="false">
    <table style="width:100%;">
        <tr>
            <td class="style1">
                Nội dung:
            </td>
            <td class="style2">
                <asp:TextBox ID="txtQuestion" runat="server" Columns="60" Rows="10" 
                    TextMode="MultiLine" Width="100%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Lựa chọn:</td>
            <td class="style2">
                <asp:ListBox ID="lstOptions" runat="server" Height="93px" Width="341px" 
                    DataSourceID="SqlDataSourceSurveyOption" DataTextField="OptionName" 
                    DataValueField="SurveyOptionID">
                </asp:ListBox>
                <asp:SqlDataSource ID="SqlDataSourceSurveyOption" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:SiteSQLServer %>" DeleteCommand="delete from C_SurveyOption 
where SurveyOptionID = @SurveyOptionID" 
                    InsertCommand="insert into C_SurveyOption(OptionName, SurveyId) values( @OptionName, @SurveyID)" 
                    onload="SqlDataSourceSurveyOption_Load" 
                    SelectCommand="SELECT * FROM [C_SurveyOption] WHERE ([SurveyID] = @SurveyID)">
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="lstOptions" Name="SurveyOptionID" 
                            PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter DbType="String" Name="OptionName" Size="200" />
                        <asp:Parameter DbType="Int32" Name="SurveyID" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidSurveyID" Name="SurveyID" 
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Thêm lựa chọn:</td>
            <td class="style2">
                <asp:TextBox ID="txtOption" runat="server" Width="336px"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnAddOption" runat="server" Text="Thêm" 
                    onclick="btnAddOption_Click" />
                &nbsp;&nbsp;
                <asp:Button ID="btnDeleteOption" runat="server" Text="Xóa lựa chọn" 
                    onclick="btnDeleteOption_Click" />
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style2">
                <asp:HiddenField ID="hidSurveyID" runat="server"/>
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style2">
                <asp:Button ID="btnFinish" runat="server" Text="Hoàn thành" 
                    onclick="btnFinish_Click" />
            </td>
        </tr>
    </table>
</asp:Panel>


