<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Favorite Products.aspx.cs" Inherits="Favorite_Products" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Favorite</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <span class="CatalogTitle">Loyal Customers </span>
        <br />
        <br />
        <asp:GridView ID="GridView1" AllowPaging="True" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" PageSize="5">
            <Columns>
                <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" SortExpression="CustomerName" />
                <asp:BoundField DataField="ShippingAddress" HeaderText="Shipping Address" SortExpression="ShippingAddress" />
                <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
                <asp:BoundField DataField="DateCreated" HeaderText="Order Date" SortExpression="DateCreated" />
                <asp:BoundField DataField="Subtotal" HeaderText="Total Expense" ReadOnly="True" SortExpression="Subtotal" />
                <asp:TemplateField HeaderText="Thumbnail Image" SortExpression="Thumbnail">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Thumbnail") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl= '<%#"ProductImages/" +Eval("Thumbnail")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BalloonShopConnectionString %>" SelectCommand="LoyalCustomer" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </span>
    </div>
    </form>
</body>
</html>
