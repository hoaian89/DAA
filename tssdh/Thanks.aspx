<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Thanks.aspx.cs" Inherits="webRegister.Thanks"  Debug="True" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Thanks</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
            border: 1px solid #000000;
        }
    p.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	line-height:115%;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table align="center" class="style1">
        <tr>
            <td align="center" bgcolor="#FFFFCC" style="color: #008000">
                <b>CHÚC MỪNG, BẠN ĐÃ ĐĂNG KÝ THÀNH CÔNG!</b><br />
                (Vui lòng đọc thông báo bên dưới)<br />
                <br />
                <br />
                <p class="MsoNormal" 
                    style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    Thí sinh t<span lang="VI" style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;
mso-ansi-language:VI">ới các ngân hàng </span>đóng đ<span style="font-family:
">ầy đủ lệ phí thi vào tài khoản của nhà trường. </span>
                </p>
                <p class="MsoNormal">
                    <span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Số tài khoản: 
                    106.21933214.01.2 <o:p></o:p></span>
                </p>
                <p class="MsoNormal">
                    <span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Nội dung 
                    thanh toán: <b style="mso-bidi-font-weight:normal">Đóng Lệ phí cho hồ sơ&nbsp;
                    <span style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    <asp:Label ID="lblProfile" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                    </span>&nbsp; của thí sinh&nbsp; <o:p>
                    <span style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    <asp:Label ID="lblName" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                    </span></o:p></b></span>
                </p>
                <p class="MsoNormal">
                    <span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Mức lệ phí :&nbsp;
                    <span style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    <asp:Label ID="lblMoney" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                    </span></span>
                </p>
                <p class="MsoNormal">
                    <span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Đóng lệ phí 
                    từ ngày&nbsp;
                    <span style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    <asp:Label ID="lblDateBegin" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label>
&nbsp;</span><span style="color:red"> </span>đến hết ngày&nbsp;
                    <span style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    <asp:Label ID="lblDateEnd" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                    </span>&nbsp;<o:p></o:p></span></p>
                <p class="MsoNormal" 
                    style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    <o:p>Thí sinh xem chi tiết trong Biên nhận hồ sơ được đính kèm theo bộ hồ sơ tải 
                    về.</o:p></p>
                <p class="MsoNormal" 
                    style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;">
                    <span style="font-family:">Nếu quá thời 
                    gian trên mà chưa đóng lệ phí thì hồ sơ &nbsp;</span><span 
                        style="font-family: &quot;Arial&quot;,&quot;sans-serif&quot;"><asp:Label 
                        ID="lblProfileDel" runat="server" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                    </span>&nbsp; sẽ bị hủy</p>
                <p class="MsoNormal" style="font-family: Arial, sans-serif">
                    &nbsp;Thí sinh kiểm tra thật kỹ các thông tin. Nếu có sai sót hoặc sửa đổi, thí 
                    sinh phải liên hệ ngay với Phòng Đào tạo Sau Đại học – Trường Đại học Công Nghệ 
                    Thông Tin để được giải quyết.</p>
                <p class="MsoNormal" 
                    style="font-family: Arial, sans-serif; color: #FF0000; font-style: italic;">
                    Lưu ý: Phòng đào tạo chỉ chấp nhận bộ hồ sơ do thí sinh tải về bên 
                    dưới, các bộ hồ sơ khác sẽ bị xem là không hợp lệ.</p>
                <p class="MsoNormal" 
                    style="font-family: Arial, sans-serif; color: #FF0000; font-style: italic;">
                    &nbsp;</p>
                <p class="MsoNormal">
                    <asp:Button ID="btnDownload" runat="server" Text="Tải hồ sơ" Width="150px" />
                </p>
            </td>
            <td align="center" bgcolor="#FFFFCC" style="color: #008000">
                &nbsp;</td>
        </tr>
    </table>
    </form>
</body>
</html>
