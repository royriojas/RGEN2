<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vMuestraMensaje.aspx.cs" Inherits="vMuestraMensaje" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="cuerpoMensaje" style="position:relative; padding-right: 20px; padding-left: 20px; padding-bottom: 20px; padding-top: 20px; background-color: #5688ba;margin-left:auto;margin-right:auto; width:834px; left: 0px; top: 0px; height: 638px;">
        <div style="position:relative;background-color:Red; left: 20px; vertical-align: middle; width: 95%; padding-top: 10px; top: 18px; height: 79px; text-align: center;">
            <asp:Image style="position:absolute; left: 16px; top: 12px;" ID="Image1" runat="server" ImageUrl="~/imgRGen/important.jpg" />
            <asp:Label ID="lblTitulo" runat="server" Font-Bold="True" Font-Size="18px" Text="Restricción"></asp:Label>
            <br />
            <asp:Label ID="lblMensaje" runat="server" Text="Restricción" Font-Bold="True" Font-Size="12px" Width="400px"></asp:Label></div>
    </div>
    </form>
</body>
</html>
