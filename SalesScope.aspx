<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesScope.aspx.cs" Inherits="SalesScope" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <span class="CatalogTitle">Sales Scope Statistics </span>
        <br />
        <br />
        <br />
        <asp:GridView ID="GridView1" AllowPaging="True" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" PageSize="5">
            <Columns>
                <asp:BoundField DataField="Region" HeaderText="Region" SortExpression="Region" />
                <asp:BoundField DataField="ShippingAddress" HeaderText="Shipping Address" SortExpression="ShippingAddress" />
                <asp:BoundField DataField="DateCreated" HeaderText="Date Created" SortExpression="DateCreated" />
                <asp:BoundField DataField="DateShipped" HeaderText="Date Shipped" SortExpression="DateShipped" />
                <asp:BoundField DataField="ProductName" HeaderText="Cake Name" SortExpression="ProductName" />
                <asp:BoundField DataField="UnitCost" HeaderText="Unit Cost" SortExpression="UnitCost" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                <asp:TemplateField HeaderText="Thumbnail Image" SortExpression="Thumbnail">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Thumbnail") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl= '<%#"ProductImages/" +Eval("Thumbnail")%>'/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BalloonShopConnectionString %>" SelectCommand="CustomerAnalysis" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <br />
    
    </div>
    </form>
</body>
</html>
