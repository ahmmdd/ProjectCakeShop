<%@ Page Language="C#" MasterPageFile="~/BalloonShop.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Welcome to Cake Shop!" %>

<%@ Register Src="UserControls/ProductsList.ascx" TagName="ProductsList" TagPrefix="uc1" %>
<%@ Register src="UserControls/UserInfo.ascx" tagname="UserInfo" tagprefix="uc5" %>
<%@ Register src="UserControls/DepartmentsList.ascx" tagname="DepartmentsList" tagprefix="uc2" %>
<%@ Register src="UserControls/CategoriesList.ascx" tagname="CategoriesList" tagprefix="uc3" %>
<%@ Register src="UserControls/SearchBox.ascx" tagname="SearchBox" tagprefix="uc4" %>
<%@ Register src="UserControls/CartSummary.ascx" tagname="CartSummary" tagprefix="uc6" %>

<asp:Content ID="content" ContentPlaceHolderID="contentPlaceHolder" Runat="server">
    <div id="container" style="width:975px;margin-left:auto;margin-right:auto;">
<table style="width:100%;">
    <tr>
        <td class="auto-style3"></td>
        <td class="auto-style1" colspan="3">
        <span class="CatalogTitle">Welcome to CakeShop! </span>
        </td>
    </tr>
     <tr>
        <td class="auto-style9"></td>
        <td class="auto-style10" colspan="3">
        <span class="CatalogDescription">This week we have a special price for these fantastic products:</span>
        </td>
    </tr>
    <tr>
        <td class="auto-style3"></td>
        <td class="auto-style1">
  <span class="CatalogDescription">
          <uc5:UserInfo ID="UserInfo1" runat="server" />
  </span></td>
        <td class="auto-style2">
  <span class="CatalogDescription">
          <uc2:DepartmentsList ID="DepartmentsList1" runat="server" />
  </span></td>
        <td>
          <uc4:SearchBox id="SearchBox1" runat="server">
          </uc4:SearchBox>
          </td>
        
    </tr>
</table>
<br />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
<title>PPT Demo</title>
<style type="text/css">
    .ppt-container, .ppt-container ul, .ppt-container li, .ppt-container img {
    border-style: none;
        border-color: inherit;
        border-width: 0;
        margin: 0 0 0 244;
        padding: 0;
    }
.ppt-container {
width : 752px; /*?????????????????width?height*/
height : 328px;
position : relative;
}
.ppt-container img {
width : 93%;
height : 100%;
}
.ppt-container .hide {
display : none;
}
.ppt-container ul.image-list li {
position : absolute;
top : -1px;
left : 258px;
        width: 283px;
    }
.ppt-container ul.button-list {
list-style : none;
position : absolute;
right : 20px;
bottom : 20px;
}
.ppt-container ul.button-list li {
float : left;
padding-right : 10px;
}
.ppt-container ul.button-list span {
background : #E5E5E5;
padding : 1px 7px;
line-height : 20px;
font-size : 13px;
display : block;
cursor : default;
}
.ppt-container ul.button-list span.selected {
color : #FFF;
background : #FF7000;
}
    .auto-style2 {
        width: 160px;
    }
    .auto-style3 {
        width: 108px;
    }
    .auto-style5 {
        width: 201px;
    }
    .auto-style7 {
        width: 197px;
    }
    .auto-style8 {
        width: 73px;
    }
    .auto-style9 {
        width: 108px;
        height: 35px;
    }
    .auto-style10 {
        width: 6px;
        height: 35px;
    }
</style>
<script type="text/javascript">
    $(function () {
        var iCountOfImage = 3; // ?????
        var iPreIndex = 0; // ???????
        $(".ppt-container ul.button-list li span").click(function () {
            var iIndex = $(this).attr("data-index");
            if (iIndex == iPreIndex) {
                return; // ???????,???
            }

            $(".ppt-container .image-list li[data-index=" + iIndex + "]").fadeIn(1500);
            $(".ppt-container .image-list li[data-index=" + iPreIndex + "]").fadeOut(1500);
            iPreIndex = iIndex;
            $(".ppt-container .button-list span").removeClass("selected");
            $(this).addClass("selected");
        });
        setInterval(function () { // ????,?5?????????,??????
            var iNextIndex = (iPreIndex + 1) % iCountOfImage;
            $(".ppt-container ul.button-list li span[data-index=" + iNextIndex + "]").click();
        }, 5000);
    });
</script>
</head>
<body>
<div class="ppt-container">
<ul class="image-list">
<li data-index="0"><img src="Images/slider-img2.jpg"/></li>
<li data-index="1" class="hide"><img src="Images/slider-img3.png"/></li>
<li data-index="2" class="hide"><img src="Images/slider-img1.gif"/></li>
</ul>
<ul class="button-list">
<li><span data-index="0" class="selected">1</span></li>
<li><span data-index="1">2</span></li>
<li><span data-index="2">3</span></li>
</ul>
</div>
</body>
</html>

<table>
    <tr>
        <td><uc1:ProductsList ID="ProductsList1" runat="server" /></td>
    </tr>
</table>
<table>
    <tr>
        <td class="auto-style3"></td>
        <td class="auto-style5">
      <span class="CartSummary">Loyal Customers:<asp:HyperLink ID="viewCartLink" runat="server" NavigateUrl="../Favorite Products.aspx"
        CssClass="CartLink" Text="(view details)" />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          </span>
        </td> 
        <td class="auto-style7"><span class="CartSummary">Sales Rank:<asp:HyperLink ID="viewCartLink0" runat="server" NavigateUrl="../SalesRank.aspx"
        CssClass="CartLink" Text="(view details)" />
          </span>
        &nbsp; </td>
        <td class="auto-style7"><span class="CartSummary">Sales Scope:<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="../SalesScope.aspx"
        CssClass="CartLink" Text="(view details)" />
          </span>
        &nbsp; </td>
        <td></td>
</tr>
</table>
<table>
    <tr>
    <td class="auto-style3"></td>
    </tr>
    <tr>
        <td class="auto-style3"></td>
        <td class="auto-style8">
            <uc6:CartSummary ID="CartSummary1" runat="server" />
        </td>
        <td>
            <uc3:CategoriesList ID="CategoriesList1" runat="server" />
        </td>
</tr>
</table>

</div>
</asp:Content>


