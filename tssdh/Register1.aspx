<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="webRegister._Default" %>

<%@ Register assembly="webRegister" namespace="webRegister" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Đăng ký Tuyển sinh sau Đại học</title>
    <style type="text/css">
        .style1
        {
            width: 93%;
        }
        .style3
        {
        }
        .style6
        {
            width: 93%;
        }
        .style7
        {
            width: 269px;
        }
        .style14
        {
        }
        .style15
        {
        }
        .style16
        {
            width: 209px;
        }
        .style17
        {
            width: 97%;
        }
        .style20
        {
        }
        .style21
        {
        }
        .style22
        {
            width: 250px;
            font-weight: 700;
        }
        .style23
        {
        }
        #form1
        {
            height: 2915px;
            width: 1024px;
        }
        .style24
        {
            width: 1000px;
            height: 15px;
        }
        .style27
        {
        }
        .style30
        {
            margin-left: 40px;
        }
        .style34
        {
        }
        .style35
        {
        }
        .style36
        {
        }
        .style37
        {
            width: 284px;
            font-weight: 700;
        }
        .style38
        {
            width: 198px;
        }
        .style39
        {
            width: 1000px;
            border-left-style: solid;
            border-left-width: 1px;
            border-right: 1px solid #C0C0C0;
            border-top-style: solid;
            border-top-width: 1px;
            border-bottom: 1px solid #C0C0C0;
        }
        .style40
        {
            height: 1786px;
        }
        .style42
        {
            width: 23%;
            font-weight: bold;
        }
        .style45
        {
            width: 113px;
        }
        .style46
        {
            width: 110px;
        }
        .style47
        {
            width: 141px;
        }
        .style51
        {
            width: 268435456px;
        }
        .style52
        {
            width: 113px;
            font-weight: bold;
        }
        .style53
        {
            width: 110px;
            font-weight: bold;
        }
        .style54
        {
            width: 141px;
            font-weight: bold;
        }
        .style58
        {
            width: 43px;
        }
        .style59
        {
            width: 160px;
        }
        .style61
        {
            width: 701px;
        }
        .style62
        {
            width: 280px;
        }
        .style63
        {
            width: 122px;
            font-weight: bold;
        }
        .style64
        {
            width: 122px;
        }
        .style65
        {
            width: 106px;
            font-weight: bold;
        }
        .style66
        {
            width: 106px;
        }
        .style67
        {
            width: 126px;
        }
        .style68
        {
        }
        .style69
        {
            height: 26px;
        }
        .style71
        {
            width: 245px;
            font-weight: bold;
        }
        .style72
        {
            width: 245px;
        }
        .style73
        {
            width: 150px;
        }
        .style74
        {
            width: 280px;
            height: 12px;
        }
        .style75
        {
            margin-left: 40px;
            height: 12px;
        }
        .style76
        {
            width: 23%;
        }
        .style77
        {
            width: 22%;
            font-weight: bold;
        }
        .style78
        {
            width: 22%;
        }
        .style79
        {
            width: 109px;
            font-weight: bold;
        }
        .style80
        {
            width: 109px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server" 
    
    
    
    
    
    
    
    
    
    style="background-position: center center; background-color: #FFFFCC; position: absolute; top: 4px; left: 0px; width: 1050px; margin-right: 0px;">
    <br />
    <br />
    <br />
    <table align="center" class="style39">
        <tr>
            <td class="style40" 
                style="border: thin groove #C0C0C0; background-color: #FFFFFF; top: 100px;">
    <table class="style1" 
        
        style="caption-side: top; width: 1000px; " 
        align="center">
        <tr>
            <td class="style69" align="center" colspan="2">
                <asp:Image ID="Banner" runat="server" Height="118px" ImageAlign="AbsMiddle" 
                    Width="991px" ImageUrl="~/tssdh/Register_Resources/banner_01.jpg" />
            </td>
        </tr>
        <tr>
            <td class="style69" align="left" colspan="2" 
                
                style="border-top-style: solid; border-color: #C0C0C0; color: #FF0000; font-style: italic;">
                (*): Thông tin bắt buộc</td>
        </tr>
        <tr>
            <td class="style69" align="center" colspan="2" 
                style="border-top-style: solid; border-color: #C0C0C0">
                <asp:Label ID="lblError0" runat="server" ForeColor="Blue" Font-Size="20pt" 
                    EnableTheming="False" EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style69" align="center" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style62" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Họ&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style30">
                <cc1:advTextbox ID="atbFirstName" runat="server" style="margin-left: 0px" 
                    Width="250px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style62" align="Right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* Tên&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style30">
                <cc1:advTextbox ID="atbLastName" runat="server" Width="150px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style74" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Giới tính&nbsp; :&nbsp;&nbsp;&nbsp;
            </td>
            <td class="style75">
                <asp:RadioButtonList ID="grdGender" runat="server" Width="134px" 
                    RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="false">Nam</asp:ListItem>
                    <asp:ListItem Value="true">Nữ</asp:ListItem>
                </asp:RadioButtonList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td class="style62" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Ngày sinh&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style30">
                <asp:DropDownList ID="ddlDayBirth" runat="server" Width="62px">
                </asp:DropDownList>
                &nbsp;/
                <asp:DropDownList ID="ddlMonthBirth" runat="server" Width="64px">
                </asp:DropDownList>
                &nbsp;/
                <cc1:advTextbox ID="atbYearBirth" runat="server" Width="95px"></cc1:advTextbox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td class="style62" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;* Nơi sinh&nbsp; :&nbsp; &nbsp;
            </td>
            <td class="style30">
                <cc1:advTextbox ID="atbPlaceBirth" runat="server" style="margin-left: 0px" 
                    Width="300px"></cc1:advTextbox>
                &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td class="style62" align="right">
                Dân tộc&nbsp; :&nbsp;&nbsp;&nbsp;</td>
            <td class="style30">
                <cc1:advTextbox ID="atbEthnic" runat="server" Width="250px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style62" align="right">
                Tôn giáo&nbsp; :&nbsp;&nbsp;&nbsp;</td>
            <td class="style30">
                <cc1:advTextbox ID="atbReligion" runat="server" Width="300px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style62" align="right">
                Chính sách ưu tiên&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td class="style30">
                <asp:DropDownList ID="ddlPriority" runat="server" Width="485px">
                </asp:DropDownList>
            </td>
        </tr>
        </table>
                <table class="style1" 
        
        style="caption-side: top; width: 1000px; " 
        align="center">
        <tr>
            <td class="style3" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style36" align="justify" rowspan="2">
                &nbsp;</td>
            <td class="style36" align="justify">
                <asp:Label ID="lblError1" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style36" align="justify">
                <asp:Label ID="lblError2" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style27" align="center" 
                
                
                style="border-width: thin; border-bottom-style: groove; border-bottom-color: #808080;" 
                colspan="2">
                &nbsp;</td>
        </tr>
    </table>
    <table class="style6" align="center" style="border-style: none; width: 1000px">
        <tr>
            <td class="style20" align="right" colspan="4">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Địa chỉ thường trú&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbAddressHome" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
            <td class="style21" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ngày vào Đoàn&nbsp; :&nbsp; </td>
            <td class="style7">
                <asp:DropDownList ID="ddlDayUnion" runat="server" Width="62px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthUnion" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearUnion" runat="server" Width="95px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Địa chỉ hiện nay&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbAddressCur" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
            <td class="style21" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nơi vào Đoàn&nbsp; :&nbsp; </td>
            <td class="style7">
                <cc1:advTextbox ID="atbPlaceUnion" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Việc làm hiện tại&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbJobName" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
            <td class="style21" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ngày vào Đảng&nbsp; :&nbsp; </td>
            <td class="style7">
                <asp:DropDownList ID="ddlDayParty" runat="server" Width="62px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthParty" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearParty" runat="server" Width="95px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Nơi làm việc&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbJobPlace" runat="server" 
                    style="margin-left: 0px" Width="270px"></cc1:advTextbox>
            </td>
            <td class="style21" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nơi vào Đảng&nbsp; :&nbsp; </td>
            <td class="style7">
                <cc1:advTextbox ID="atbPlaceParty" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Năm công tác&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbJobYear" runat="server" style="margin-left: 0px" 
                    Width="120px"></cc1:advTextbox>
            </td>
            <td class="style21">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;</td>
            <td class="style16">
                <asp:CheckBox ID="cbOffical" runat="server" Text="Công văn cử đi thi" />
            </td>
            <td class="style21">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Điện thoại cơ quan&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbWorkPhone" runat="server" style="margin-left: 0px" 
                    Width="200px"></cc1:advTextbox>
            </td>
            <td class="style21" align="right">
                &nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;* Người liên lạc&nbsp; :&nbsp; </td>
            <td class="style7">
                <cc1:advTextbox ID="atbContactPerson" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Điện thoại nhà riêng&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbHomePhone" runat="server" style="margin-left: 0px" 
                    Width="200px"></cc1:advTextbox>
            </td>
            <td class="style21" align="right">
                                *
                Điện thoại người liên lạc&nbsp; :&nbsp; </td>
            <td class="style7">
                <cc1:advTextbox ID="atbContactPhone" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Điện thoại di động&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbCellPhone" runat="server" style="margin-left: 0px" 
                    Width="200px"></cc1:advTextbox>
            </td>
            <td class="style21" align="right">
                                *
                Địa chỉ người liên lạc&nbsp; :&nbsp; </td>
            <td class="style7">
                <cc1:advTextbox ID="atbContactAddress" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td class="style38" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;Email&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td class="style16">
                <cc1:advTextbox ID="atbEmail" runat="server" style="margin-left: 0px" 
                    Width="270px"></cc1:advTextbox>
            </td>
            <td class="style21" colspan="2">
                <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                    ControlToValidate="atbEmail" ErrorMessage="Địa chỉ Email không hợp lệ" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    EnableViewState="False"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style15" colspan="4">
                &nbsp;</td>
        </tr>
        </table>
                <table class="style6" align="center" style="border-style: none; width: 1000px">
        <tr>
            <td class="style59" rowspan="3" align="justify">
                <asp:Button ID="btnTestPInfo" runat="server" Text="Kiểm tra hợp lệ" 
                    EnableViewState="False" />
            </td>
            <td class="style14" width="800">
                <asp:Label ID="lblError3" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style14">
                <asp:Label ID="lblError4" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style14">
                <asp:Label ID="lblError5" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style20" align="center" colspan="2" 
                style="border-bottom-style: solid; border-bottom-color: #C0C0C0; border-bottom-width: thick;" 
                width="200">
                &nbsp;</td>
        </tr>
    </table>
    <table class="style17" align="center" 
        style="border-style: dashed; width: 1000px;">
        <tr>
            <td class="style23" colspan="4" style="border-bottom-width: medium;">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style37">
                <b>Năm học&nbsp; :</b>&nbsp;&nbsp;
                <asp:Label ID="lblYearStudy" runat="server"></asp:Label>
            </td>
            <td colspan="2" class="style22">
                Đợt tuyển sinh&nbsp; :&nbsp;&nbsp;
                <asp:Label ID="lblCourseStudy" runat="server"></asp:Label>
            </td>
            <td style="font-weight: 700">
                Ngành học&nbsp; :&nbsp;&nbsp;
                <asp:Label ID="lblMajorStudy" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style35" colspan="2" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Đăng ký&nbsp;thi&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td colspan="2" width="700">
                <asp:RadioButtonList ID="rdlRegMajor" runat="server">
                    <asp:ListItem Selected="True" Value="true">Cao học</asp:ListItem>
                    <asp:ListItem Value="false">Nghiên cứu sinh</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="style35" colspan="2" align="right">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Cụm thi&nbsp; :&nbsp;&nbsp;&nbsp; </td>
            <td colspan="2" width="700">
                <asp:DropDownList ID="ddlGroupExam" runat="server" Width="300px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style35" colspan="4" align="right">
                &nbsp;</td>
        </tr>
    </table>
    <table align="center" class="style24" style="border-style: none" width="1000">
        <tr>
            <td align="right" class="style34" 
                
                
                
                style="border-top-style: solid; border-width: thick; border-color: #C0C0C0">
                &nbsp;</td>
        </tr>
        </table>
                    <br />
                    <table align="center" class="style24" style="border-style: none" width="1000">
        <tr>
            <td align="right" class="style34">
                Chứng chỉ ngoại ngữ&nbsp;&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            <td align="char" width="800">
                <asp:DropDownList ID="ddlCertificate" runat="server" Width="300px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="right" class="style34">
                Ngày cấp&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;             </td>
            <td align="char">
                <asp:DropDownList ID="ddlDayCer" runat="server" Width="62px" Height="16px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthCer" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearCer" runat="server" Width="95px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td align="right" class="style34">
                Điểm&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td align="char">
                <cc1:advTextbox ID="atbCerMark" runat="server" style="margin-left: 0px" 
                    Width="120px"></cc1:advTextbox>
            </td>
        </tr>
        <tr>
            <td align="right" class="style34" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="Left" class="style34" colspan="2">
                <asp:Label ID="lblError6" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="Left" class="style34" colspan="2">
                <asp:Label ID="lblError7" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="Left" class="style34" colspan="2">
                &nbsp;</td>
        </tr>
        </table>
                <table align="center" class="style24" style="border-style: none" width="1000">
        <tr style="border-style: ridge; border-color: #808080; background-color: #C0C0C0;">
            <td align="center" class="style71" 
                
                
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0; font-size: medium; ">
                Tên bài báo</td>
            <td align="center" class="style42" 
                
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0; ">
                Lĩnh vực</td>
            <td align="center" class="style77" 
                
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                Tạp chí đăng</td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0; width: 250px;">
                <b>Ngày đăng</b></td>
        </tr>
        <tr>
            <td align="center" dir="ltr" class="style72">
                <cc1:advTextbox ID="advArtName1" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center" class="style76">
                <cc1:advTextbox ID="advArtField1" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center" class="style78">
                <cc1:advTextbox ID="advArtMag1" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlDayArt1" runat="server" Width="60px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthArt1" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearArt1" runat="server" Width="70px"></cc1:advTextbox>
            </td>
        </tr>
                    <tr>
            <td align="center" class="style72">
                <cc1:advTextbox ID="advArtName2" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center" class="style76">
                <cc1:advTextbox ID="advArtField2" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="left" class="style78">
                <cc1:advTextbox ID="advArtMag2" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlDayArt2" runat="server" Width="60px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthArt2" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearArt2" runat="server" Width="70px"></cc1:advTextbox>
            </td>
                    </tr>
                    <tr>
            <td align="center" class="style72">
                <cc1:advTextbox ID="advArtName3" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center" class="style76">
                <cc1:advTextbox ID="advArtField3" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="left" class="style78">
                <cc1:advTextbox ID="advArtMag3" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlDayArt3" runat="server" Width="60px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthArt3" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearArt3" runat="server" Width="70px"></cc1:advTextbox>
            </td>
                    </tr>
                    <tr>
            <td align="center" class="style72">
                <cc1:advTextbox ID="advArtName4" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center" class="style76">
                <cc1:advTextbox ID="advArtField4" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="left" class="style78">
                <cc1:advTextbox ID="advArtMag4" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlDayArt4" runat="server" Width="60px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthArt4" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearArt4" runat="server" Width="70px"></cc1:advTextbox>
            </td>
                    </tr>
                    <tr>
            <td align="center" class="style72">
                <cc1:advTextbox ID="advArtName5" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center" class="style76">
                <cc1:advTextbox ID="advArtField5" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="left" class="style78">
                <cc1:advTextbox ID="advArtMag5" runat="server" Width="240px"></cc1:advTextbox>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlDayArt5" runat="server" Width="60px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthArt5" runat="server" Width="64px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearArt5" runat="server" Width="70px"></cc1:advTextbox>
            </td>
                    </tr>
                    </table>
                <p>
                </p>
                <table align="center" class="style24" style="border-style: none" width="1000">
                    <tr>
            <td align="left">
                &nbsp;</td>
                    </tr>
        <tr>
            <td align="left" class="style68">
                <asp:Label ID="lblError8" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left" class="style68">
                <asp:Label ID="lblError9" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" style="border-bottom-style: groove" 
                class="style68">
                &nbsp;</td>
        </tr>
        </table>
                <br />
                <table align="center" class="style24" width="70">
        <tr>
            <td align="center" class="style52" 
                
                style="border-color: #808080; border-style: ridge; background-color: #C0C0C0; font-size: small;">
                Tên công trình</td>
            <td align="center" class="style53" 
                
                style="border-color: #808080; border-style: ridge; background-color: #C0C0C0; font-size: small;">
                Lĩnh vực</td>
            <td align="center" class="style54" 
                
                style="border-color: #808080; border-style: ridge; background-color: #C0C0C0; font-size: small;">
                Giáo viên hướng dẫn</td>
            <td align="center" class="style79" 
                
                
                style="border-color: #808080; border-style: ridge; background-color: #C0C0C0; font-size: small;">
                Nơi công bố</td>
            <td align="center" class="style63" 
                
                style="border-color: #808080; border-style: ridge; background-color: #C0C0C0; font-size: small;">
                Vai trò</td>
            <td align="center" class="style65" 
                
                style="border-color: #808080; border-style: ridge; background-color: #C0C0C0; font-size: small;">
                Đề cương</td>
            <td align="center" class="style51" 
                
                style="border-color: #808080; border-style: ridge; background-color: #C0C0C0; font-weight: 700; font-size: small;">
                Ngày công bố</td>
        </tr>
                    <tr>
            <td align="center" class="style45">
                <cc1:advTextbox ID="advResName1" runat="server" Width="150px"></cc1:advTextbox>
            </td>
            <td align="center" class="style46">
                <cc1:advTextbox ID="advResField1" runat="server" Width="120px"></cc1:advTextbox>
            </td>
            <td align="center" class="style47">
                <cc1:advTextbox ID="advResGuide1" runat="server" Width="150px"></cc1:advTextbox>
                        </td>
            <td align="center" class="style80">
                &nbsp;</td>
            <td align="center" class="style64">
                <asp:DropDownList ID="ddlResRole1" runat="server" Width="120px">
                    <asp:ListItem>Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Đồng Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Cố vấn chuyên môn</asp:ListItem>
                    <asp:ListItem>Cộng tác viên</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center" class="style66">
                <asp:CheckBox ID="cbResDraft1" runat="server" Checked="True" Enabled="False" />
            </td>
            <td align="center" class="style51">
                &nbsp;</td>
                    </tr>
                    <tr>
            <td align="center" class="style45">
                <cc1:advTextbox ID="advResName2" runat="server" Width="150px"></cc1:advTextbox>
            </td>
            <td align="center" class="style46">
                <cc1:advTextbox ID="advResField2" runat="server" Width="120px"></cc1:advTextbox>
            </td>
            <td align="center" class="style47">
                <cc1:advTextbox ID="advResGuide2" runat="server" Width="150px"></cc1:advTextbox>
            </td>
            <td align="center" class="style80">
                <cc1:advTextbox ID="advResPlace2" runat="server" Width="120px"></cc1:advTextbox>
            </td>
            <td align="center" class="style64">
                <asp:DropDownList ID="ddlResRole2" runat="server" Width="120px">
                    <asp:ListItem>Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Đồng Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Cố vấn chuyên môn</asp:ListItem>
                    <asp:ListItem>Cộng tác viên</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center" class="style66">
                &nbsp;</td>
            <td align="center" class="style51">
                <asp:DropDownList ID="ddlDayRes2" runat="server" Width="50px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthRes2" runat="server" Width="50px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearRes2" runat="server" Width="60px"></cc1:advTextbox>
            </td>
                    </tr>
                    <tr>
            <td align="center" class="style45">
                <cc1:advTextbox ID="advResName3" runat="server" Width="150px"></cc1:advTextbox>
            </td>
            <td align="center" class="style46">
                <cc1:advTextbox ID="advResField3" runat="server" Width="120px"></cc1:advTextbox>
            </td>
            <td align="center" class="style47">
                <cc1:advTextbox ID="advResGuide3" runat="server" Width="150px"></cc1:advTextbox>
            </td>
            <td align="center" class="style80">
                <cc1:advTextbox ID="advResPlace3" runat="server" Width="120px"></cc1:advTextbox>
            </td>
            <td align="center" class="style64">
                <asp:DropDownList ID="ddlResRole3" runat="server" Width="120px">
                    <asp:ListItem>Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Đồng Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Cố vấn chuyên môn</asp:ListItem>
                    <asp:ListItem>Cộng tác viên</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center" class="style66">
                &nbsp;</td>
            <td align="center" class="style51">
                <asp:DropDownList ID="ddlDayRes3" runat="server" Width="50px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthRes3" runat="server" Width="50px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearRes3" runat="server" Width="60px"></cc1:advTextbox>
            </td>
                    </tr>
                    <tr>
            <td align="center" class="style45">
                <cc1:advTextbox ID="advResName4" runat="server" Width="150px"></cc1:advTextbox>
            </td>
            <td align="center" class="style46">
                <cc1:advTextbox ID="advResField4" runat="server" Width="120px"></cc1:advTextbox>
            </td>
            <td align="center" class="style47">
                <cc1:advTextbox ID="advResGuide4" runat="server" Width="150px"></cc1:advTextbox>
            </td>
            <td align="center" class="style80">
                <cc1:advTextbox ID="advResPlace4" runat="server" Width="120px"></cc1:advTextbox>
            </td>
            <td align="center" class="style64">
                <asp:DropDownList ID="ddlResRole4" runat="server" Width="120px">
                    <asp:ListItem>Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Đồng Chủ Nhiệm</asp:ListItem>
                    <asp:ListItem>Cố vấn chuyên môn</asp:ListItem>
                    <asp:ListItem>Cộng tác viên</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center" class="style66">
                &nbsp;</td>
            <td align="center" class="style51">
                <asp:DropDownList ID="ddlDayRes4" runat="server" Width="50px">
                </asp:DropDownList>
&nbsp;/
                <asp:DropDownList ID="ddlMonthRes4" runat="server" Width="50px">
                </asp:DropDownList>
&nbsp;/
                <cc1:advTextbox ID="atbYearRes4" runat="server" Width="60px"></cc1:advTextbox>
            </td>
                    </tr>
        </table>
                <br />
                <table align="center" class="style24" style="border-style: none" width="1000">
        <tr>
            <td align="left" rowspan="2" class="style58">
                <asp:Button ID="btnTestArchive" runat="server" Text="Kiểm tra hợp lệ" 
                    EnableViewState="False" />
            </td>
            <td align="char">
                <asp:Label ID="lblError10" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="char">
                <asp:Label ID="lblError11" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" class="style34" colspan="2" 
                
                style="border-bottom-style: solid; border-width: thick; border-color: #C0C0C0">
                &nbsp;</td>
        </tr>
    </table>
                <br />
    <table align="center" class="style24" width="800">
        <tr>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0; font-size: medium; width: 25%;">
                <b>Ngày tháng năm</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0; font-size: medium; width: 25%;">
                <b>Học, làm việc gì</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0; font-size: medium; width: 25%;">
                <b>Ở đâu</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0; font-size: medium; width: 25%;">
                <b>Thành tích</b></td>
        </tr>
        <tr>
            <td align="center">
                <cc1:advTextbox ID="advHisDate1" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisWork1" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisPlace1" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisArchi1" runat="server" Width="245px"></cc1:advTextbox>
            </td>
        </tr>
                        <tr>
            <td align="center">
                <cc1:advTextbox ID="advHisDate2" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisWork2" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisPlace2" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisArchi2" runat="server" Width="245px"></cc1:advTextbox>
            </td>
                        </tr>
                        <tr>
            <td align="center">
                <cc1:advTextbox ID="advHisDate3" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisWork3" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisPlace3" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisArchi3" runat="server" Width="245px"></cc1:advTextbox>
            </td>
                        </tr>
                        <tr>
            <td align="center">
                <cc1:advTextbox ID="advHisDate4" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisWork4" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisPlace4" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisArchi4" runat="server" Width="245px"></cc1:advTextbox>
            </td>
                        </tr>
                        <tr>
            <td align="center">
                <cc1:advTextbox ID="advHisDate5" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisWork5" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisPlace5" runat="server" Width="245px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advHisArchi5" runat="server" Width="245px"></cc1:advTextbox>
            </td>
                        </tr>
        </table>
                    <table align="center" class="style24" width="800">
        <tr>
            <td align="Left">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="Left">
                <asp:Label ID="lblError12" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" 
                
                
                style="border-width: thin; border-bottom-style: groove; border-color: #000000">
                &nbsp;</td>
        </tr>
                        </table>
                <br />
                <table align="center" class="style24" width="800">
        <tr style="font-size: smaller" align="center">
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                <b>Cấp học</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                <b>Tên trường</b></td>
            <td align="center" 
                
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0" 
                class="style67">
                <b>Ngành học</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                <b>Hệ đào tạo</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                <b>Xếp loại</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                <b>Điểm
                <br />
                trung bình</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                <b>Năm
                <br />
                bắt đầu</b></td>
            <td align="center" 
                style="border-style: ridge; border-color: #808080; background-color: #C0C0C0">
                <b>Năm
                <br />
                tốt nghiệp</b></td>
        </tr>
        <tr style="font-size: medium">
            <td align="center" rowspan="3" 
                style="border: 2px groove #808080; background-color: #C0C0C0;">
                <b>Đại học</b></td>
            <td align="center">
                <cc1:advTextbox ID="advSchName1" runat="server" 
                    Width="300px"></cc1:advTextbox>
            </td>
            <td align="center" class="style67">
                <asp:DropDownList ID="ddlSchMajor1" runat="server" Width="156px">
                </asp:DropDownList>
            </td>
            <td align="center" style="margin-left: 40px">
                <asp:DropDownList ID="ddlSchMethod1" runat="server" Width="120px">
                    <asp:ListItem>Chính quy</asp:ListItem>
                    <asp:ListItem>Chuyên tu</asp:ListItem>
                    <asp:ListItem>Tại chức</asp:ListItem>
                    <asp:ListItem>Mở rộng</asp:ListItem>
                    <asp:ListItem>Từ xa</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlSchRank1" runat="server" Width="120px">
                    <asp:ListItem>Xuất sắc</asp:ListItem>
                    <asp:ListItem>Giỏi</asp:ListItem>
                    <asp:ListItem>Khá</asp:ListItem>
                    <asp:ListItem>Trung bình khá</asp:ListItem>
                    <asp:ListItem>Trung bình</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchMark1" runat="server" 
                    Width="64px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearBegin1" runat="server" 
                    Width="59px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearEnd1" runat="server" Width="62px"></cc1:advTextbox>
            </td>
        </tr>
                        <tr>
            <td align="center">
                <cc1:advTextbox ID="advSchName2" runat="server" 
                    Width="300px"></cc1:advTextbox>
            </td>
            <td align="center" class="style67">
                <asp:DropDownList ID="ddlSchMajor2" runat="server" Width="156px">
                </asp:DropDownList>
            </td>
            <td align="center" style="margin-left: 40px">
                <asp:DropDownList ID="ddlSchMethod2" runat="server" Width="120px">
                    <asp:ListItem>Chính quy</asp:ListItem>
                    <asp:ListItem>Chuyên tu</asp:ListItem>
                    <asp:ListItem>Tại chức</asp:ListItem>
                    <asp:ListItem>Mở rộng</asp:ListItem>
                    <asp:ListItem>Từ xa</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlSchRank2" runat="server" Width="120px">
                    <asp:ListItem>Xuất sắc</asp:ListItem>
                    <asp:ListItem>Giỏi</asp:ListItem>
                    <asp:ListItem>Khá</asp:ListItem>
                    <asp:ListItem>Trung bình khá</asp:ListItem>
                    <asp:ListItem>Trung bình</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchMark2" runat="server" 
                    Width="64px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearBegin2" runat="server" 
                    Width="59px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearEnd2" runat="server" Width="62px"></cc1:advTextbox>
            </td>
                        </tr>
                        <tr>
            <td align="center">
                <cc1:advTextbox ID="advSchName3" runat="server" 
                    Width="300px"></cc1:advTextbox>
            </td>
            <td align="center" class="style67">
                <asp:DropDownList ID="ddlSchMajor3" runat="server" Width="156px">
                </asp:DropDownList>
            </td>
            <td align="center" style="margin-left: 40px">
                <asp:DropDownList ID="ddlSchMethod3" runat="server" Width="120px">
                    <asp:ListItem>Chính quy</asp:ListItem>
                    <asp:ListItem>Chuyên tu</asp:ListItem>
                    <asp:ListItem>Tại chức</asp:ListItem>
                    <asp:ListItem>Mở rộng</asp:ListItem>
                    <asp:ListItem>Từ xa</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlSchRank3" runat="server" Width="120px">
                    <asp:ListItem>Xuất sắc</asp:ListItem>
                    <asp:ListItem>Giỏi</asp:ListItem>
                    <asp:ListItem>Khá</asp:ListItem>
                    <asp:ListItem>Trung bình khá</asp:ListItem>
                    <asp:ListItem>Trung bình</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchMark3" runat="server" 
                    Width="64px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearBegin3" runat="server" 
                    Width="59px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearEnd3" runat="server" Width="62px"></cc1:advTextbox>
            </td>
                        </tr>
                        <tr>
            <td align="center" rowspan="2" style="border: 2px groove #808080; background-color: #C0C0C0;">
                <b>Cao học</b></td>
            <td align="center">
                <cc1:advTextbox ID="advSchName4" runat="server" 
                    Width="300px"></cc1:advTextbox>
            </td>
            <td align="center" class="style67">
                <asp:DropDownList ID="ddlSchMajor4" runat="server" Width="156px">
                </asp:DropDownList>
            </td>
            <td align="center" style="margin-left: 40px">
                <asp:DropDownList ID="ddlSchMethod4" runat="server" Width="120px">
                    <asp:ListItem>Chính quy</asp:ListItem>
                    <asp:ListItem>Chuyên tu</asp:ListItem>
                    <asp:ListItem>Tại chức</asp:ListItem>
                    <asp:ListItem>Mở rộng</asp:ListItem>
                    <asp:ListItem>Từ xa</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlSchRank4" runat="server" Width="120px">
                    <asp:ListItem>Xuất sắc</asp:ListItem>
                    <asp:ListItem>Giỏi</asp:ListItem>
                    <asp:ListItem>Khá</asp:ListItem>
                    <asp:ListItem>Trung bình khá</asp:ListItem>
                    <asp:ListItem>Trung bình</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchMark4" runat="server" 
                    Width="64px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearBegin4" runat="server" 
                    Width="59px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearEnd4" runat="server" Width="62px"></cc1:advTextbox>
            </td>
                        </tr>
                        <tr>
            <td align="center">
                <cc1:advTextbox ID="advSchName5" runat="server" 
                    Width="300px"></cc1:advTextbox>
            </td>
            <td align="center" class="style67">
                <asp:DropDownList ID="ddlSchMajor5" runat="server" Width="156px">
                </asp:DropDownList>
            </td>
            <td align="center" style="margin-left: 40px">
                <asp:DropDownList ID="ddlSchMethod5" runat="server" Width="120px">
                    <asp:ListItem>Chính quy</asp:ListItem>
                    <asp:ListItem>Chuyên tu</asp:ListItem>
                    <asp:ListItem>Tại chức</asp:ListItem>
                    <asp:ListItem>Mở rộng</asp:ListItem>
                    <asp:ListItem>Từ xa</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <asp:DropDownList ID="ddlSchRank5" runat="server" Width="120px">
                    <asp:ListItem>Xuất sắc</asp:ListItem>
                    <asp:ListItem>Giỏi</asp:ListItem>
                    <asp:ListItem>Khá</asp:ListItem>
                    <asp:ListItem>Trung bình khá</asp:ListItem>
                    <asp:ListItem>Trung bình</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchMark5" runat="server" 
                    Width="64px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearBegin5" runat="server" 
                    Width="59px"></cc1:advTextbox>
            </td>
            <td align="center">
                <cc1:advTextbox ID="advSchYearEnd5" runat="server" Width="62px"></cc1:advTextbox>
            </td>
                        </tr>
                        </table>
                    <table align="center" class="style24" width="800">
        <tr>
            <td align="center" colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="justify" rowspan="3" class="style73">
                <asp:Button ID="btnTestHisSchl" runat="server" Text="Kiểm tra hợp lệ" 
                    EnableViewState="False" />
            </td>
            <td align="char" class="style61">
                <asp:Label ID="lblError13" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="char" class="style61">
                <asp:Label ID="lblError14" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="char" class="style61">
                <asp:Label ID="lblError15" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
        </table>
                    <br />
                    <br />
                    <table align="center" class="style24" width="800">
        <tr>
            <td align="center">
                Nhập các ký tự bạn nhìn thấy trong 2 bức hình dưới đây:<br />
                (Có ký tự khoảng trắng giữa 2 từ)</td>
        </tr>
        <tr>
            <td align="center">
                <asp:Image ID="Captcha1" runat="server" Height="30px" Width="100px" />
                <asp:Image ID="Captcha2" runat="server" Height="30px" Width="100px" />
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle">
                <asp:TextBox ID="atbCaptcha" runat="server" style="margin-left: 0px" 
                    Width="188px" EnableTheming="False" EnableViewState="False"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btnCaptchaReload" runat="server" 
                    ImageUrl="~/tssdh/Register_Resources/recaptcha.png" Height="24px" Width="57px" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblError16" runat="server" ForeColor="Red" EnableTheming="False" 
                    EnableViewState="False"></asp:Label>
            </td>
        </tr>
    </table>
                    <br />
    <table align="center" class="style24">
        <tr>
            <td align="center">
    <asp:Button ID="btnRegister" runat="server" Text="ĐĂNG KÝ" Width="200px" Font-Bold="True" 
                    Font-Underline="True" ForeColor="Red" EnableViewState="False" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>
                </td>
            </tr>
        </table>
    &nbsp;<br />
    <br />
</form>
</body>
</html>
