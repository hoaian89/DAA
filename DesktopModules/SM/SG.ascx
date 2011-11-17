<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SG.ascx.cs" Inherits="DesktopModules_SM_SG" %>
<style type="text/css">
        .style2
        {
            width: 100%;
        }
        .style3
        {
            font-weight: bold;
            color: #CC3300;
        }
            .style5
        {
            color: #CC3300;
        }
        </style>
        <asp:FormView ID="FormView1" runat="server" Width="454px" 
            BorderColor="#DEBA84" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" 
            CellSpacing="2" DataKeyNames="StuId" DataSourceID="SqlDataSource1" 
            GridLines="Both">
            <EditItemTemplate>
                <table class="style2">
                    <tr>
                        <td class="style5">
                            MSSV :</td>
                        <td>
                            <asp:Label ID="StuIdLabel1" runat="server" Text='<%# Eval("StuId") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5" width="145">
                            Toán cao cấp A2 (*) :</td>
                        <td>
                            <asp:TextBox ID="TA2WebTextBox" runat="server" Text='<%# Bind("TA2Web") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5">
                            Toán cao cấp A2 (**) :</td>
                        <td>
                            <asp:TextBox ID="TA2InfoTextBox" runat="server" Text='<%# Bind("TA2Info") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5">
                            Đại số tuyến tính (*) :</td>
                        <td>
                            <asp:TextBox ID="TTWebTextBox" runat="server" Text='<%# Bind("TTWeb") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5">
                            Đại số tuyến tính (**) :</td>
                        <td>
                            <asp:TextBox ID="TTInfoTextBox" runat="server" Text='<%# Bind("TTInfo") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5" valign="top">
                            Ghi chú :</td>
                        <td height="10" width="10">
                            <asp:TextBox ID="MemoTextBox" runat="server" Text='<%# Bind("Memo") %>' 
                                TextMode="MultiLine" Rows="4" Width="227px"/>
                        </td>
                    </tr>
                </table>
                <hr />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                    CommandName="Update" Text="Cập nhật" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                    CausesValidation="False" CommandName="Cancel" Text="Hủy" />
                <br />
            </EditItemTemplate>
            <EditRowStyle Font-Bold="True" ForeColor="White" />
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <ItemTemplate>
                <table class="style2">
                    <tr>
                        <td class="style3" width="180">
                            <strong>MSSV&nbsp; :</strong></td>
                        <td width="30" align="left">
                            <asp:Label ID="StuIdLabel" runat="server" Text='<%# Eval("StuId") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5" width="180">
                            <b>Toán cao cấp A2 (*) :</b></td>
                        <td align="left">
                            <asp:Label ID="TA2WebLabel" runat="server" Text='<%# Bind("TA2Web") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5" width="180">
                            <b>Toán cao cấp A2 (**) :</b></td>
                        <td align="left">
                            <asp:Label ID="TA2InfoLabel" runat="server" Text='<%# Bind("TA2Info") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5" width="180">
                            <b>Đại số tuyến tính (*) :</b></td>
                        <td align="left">
                            <asp:Label ID="TTWebLabel" runat="server" Text='<%# Bind("TTWeb") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5" width="180">
                            <b>Đại số tuyến tính (**) :</b></td>
                        <td align="left">
                            <asp:Label ID="TTInfoLabel" runat="server" Text='<%# Bind("TTInfo") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="style5" valign="top" width="180">
                            <b>Thông tin ghi chú :</b></td>
                        <td align="left">
                            <asp:TextBox ID="MemoLabel" runat="server" Text='<%# Bind("Memo") %>' Rows="4" 
                                ReadOnly="true" BorderWidth="0" BackColor="Transparent" TextMode="MultiLine" 
                                Width="230px" Height="40px"/>
                        </td>
                    </tr>
                </table>
                <hr />
                
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                    CommandName="Edit" Text="Đề nghị sửa đổi" style="font-weight: 700" />                                
                <br />
                <br />
                <span class="style5">Chú ý : (*) là điểm sinh viên trên web. (**) là điểm sinh 
                viên đã biết trước đó. Sinh viên điền thêm các thông tin phụ cần thiết cho việc 
                xác nhận điểm : điểm lần mấy , thầy cô dạy..</span>&nbsp;                                
            </ItemTemplate>
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
        </asp:FormView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
            SelectCommand="SELECT * FROM [SuggestMark] WHERE ([StuId] = @StuId)" 
            ConflictDetection="CompareAllValues"             
            OldValuesParameterFormatString="original_{0}" 
            UpdateCommand="UPDATE [SuggestMark] SET [Memo] = @Memo, [TTInfo] = @TTInfo, [TTWeb] = @TTWeb, [TA2Info] = @TA2Info, [TA2Web] = @TA2Web WHERE [StuId] = @original_StuId AND (([TTInfo] = @original_TTInfo) OR ([TTInfo] IS NULL AND @original_TTInfo IS NULL)) AND (([TTWeb] = @original_TTWeb) OR ([TTWeb] IS NULL AND @original_TTWeb IS NULL)) AND (([TA2Info] = @original_TA2Info) OR ([TA2Info] IS NULL AND @original_TA2Info IS NULL)) AND (([TA2Web] = @original_TA2Web) OR ([TA2Web] IS NULL AND @original_TA2Web IS NULL))">    
            <SelectParameters>
                <asp:Parameter Name="StuId" Type="String" DefaultValue="" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="TA2Web" Type="Double" />
                <asp:Parameter Name="TA2Info" Type="Double" />
                <asp:Parameter Name="TTWeb" Type="Double" />
                <asp:Parameter Name="TTInfo" Type="Double" />
                <asp:Parameter Name="Memo" Type="String" />
                <asp:Parameter Name="original_Memo" Type="String" />
                <asp:Parameter Name="original_StuId" Type="String" />
                <asp:Parameter Name="original_TA2Web" Type="Double" />
                <asp:Parameter Name="original_TA2Info" Type="Double" />
                <asp:Parameter Name="original_TTWeb" Type="Double" />
                <asp:Parameter Name="original_TTInfo" Type="Double" />
            </UpdateParameters>
        </asp:SqlDataSource>
        
        
