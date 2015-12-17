<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesRank.aspx.cs" Inherits="SalesRank" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SalesRank</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <span class="CatalogTitle">Cake Sales Rank </span>
        <br />
        <br />

        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" PageSize="5">
            <Columns>
                
                <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
                <asp:BoundField DataField="description" HeaderText="Product Description" SortExpression="description" />
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                <asp:BoundField DataField="maxQuantities" HeaderText="Max Quantities" ReadOnly="True" SortExpression="maxQuantities" />
                <asp:TemplateField HeaderText="Thumbnail Image" SortExpression="Thumbnail">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Thumbnail") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                            <asp:Image ID="Image2" runat="server" ImageUrl= '<%#"ProductImages/" +Eval("Thumbnail")%>' />

                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BalloonShopConnectionString %>" SelectCommand="maxSales" SelectCommandType="StoredProcedure"></asp:SqlDataSource>


        <br />
        <br />
        
    
    </div>
    </form>
</body>
</html>
