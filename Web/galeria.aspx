<%@ Page Language="C#" AutoEventWireup="true" CodeFile="galeria.aspx.cs" Inherits="galeria" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="odsGaleriaAnexos" Width="535px">
        </asp:GridView>
        <asp:ObjectDataSource ID="odsGaleriaAnexos" runat="server"></asp:ObjectDataSource>
    
    </div>
    </form>
</body>
</html>
