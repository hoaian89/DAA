<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowInfo.aspx.cs" Inherits="Show_Info.ShowInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Tuyển sinh sau đại học</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" Text="Họ Tên :"></asp:Label>
    
    </div>
    <p>
        <asp:TextBox ID="HoTen" runat="server" ToolTip="Họ và Tên"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="Label2" runat="server" Text="Số Báo Danh :"></asp:Label>
    </p>
    <p>
        <asp:TextBox ID="SoBaoDanh" runat="server" ToolTip="Số Báo Danh"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="XemThongTin" runat="server" Text="Xem Thông Tin" onclick="XemThongTin_Click" />
    </p>
    <p>
        <asp:Label ID="lblTTTS" runat="server" Text="Thông Tin Thí Sinh :" 
            ForeColor="Red" Visible="False"></asp:Label>
    </p>
    <asp:DetailsView ID="DetailsView_ThongTinTS" runat="server" CellPadding="4" 
        ForeColor="#333333" GridLines="None" 
        Height="50px" Width="462px" AutoGenerateRows="False">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <RowStyle BackColor="#EFF3FB" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <Fields>
            <asp:BoundField DataField="HoTen" HeaderText="Họ Tên :" ReadOnly="True" />
            <asp:BoundField DataField="NgaySinh" HeaderText="Ngày Sinh :" ReadOnly="True" />
            <asp:BoundField DataField="NoiSinh" HeaderText="Nơi Sinh :" ReadOnly="True" />
            <asp:BoundField DataField="CaoHoc" HeaderText="Đăng Ký Dự Thi :" 
                ReadOnly="True" />
            <asp:BoundField DataField="Khoa" HeaderText="Khóa :" />
            <asp:BoundField DataField="NganhTuyenSinh" HeaderText="Ngành Dự Thi :" 
                ReadOnly="True" />
            <asp:BoundField DataField="TenCT" HeaderText="Cụm Thi :" ReadOnly="True" />
            <asp:BoundField DataField="SBD" HeaderText="Số Báo Danh :" ReadOnly="True" />
            <asp:BoundField DataField="MPT" HeaderText="Phòng Thi :" ReadOnly="True" />
            <asp:BoundField DataField="DiaChi" HeaderText="Địa Chỉ Phòng Thi :" 
                ReadOnly="True" />
            <asp:BoundField DataField="CS" HeaderText="Diện Ưu Tiên :" />
            <asp:BoundField DataField="AV" HeaderText="Miễn thi Anh Văn :" />
        </Fields>
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:DetailsView>
    <p>
        <asp:Label ID="lblKQT" runat="server" Text="Kết Quả Thi:" ForeColor="Red" 
            Visible="False"></asp:Label>
        </p>
    <asp:GridView ID="Grid_BangDiem" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None" Width="433px">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="TenMT" HeaderText="Môn Thi">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField ConvertEmptyStringToNull="False" DataField="Vang" 
                HeaderText="Vắng" NullDisplayText="Không">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="KyLuat" HeaderText="Kỷ Luật">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Diem" HeaderText="Điểm" NullDisplayText="0">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <p>
        <asp:Label ID="lblKQPK" runat="server" Text="Kết Quả Phúc Khảo :" 
            ForeColor="Red" Visible="False"></asp:Label>
        </p>
    <asp:GridView ID="Grid_PhucKhao" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None" Width="347px">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="TenMT" HeaderText="Môn Thi">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField ConvertEmptyStringToNull="False" DataField="Diem1" 
                HeaderText="Điểm trước phúc khảo">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Diem2" HeaderText="Điểm sau phúc khảo">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="GhiChu" HeaderText="Ghi Chú">
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    </form>
</body>
</html>
