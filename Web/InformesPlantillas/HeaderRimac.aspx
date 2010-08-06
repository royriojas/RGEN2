<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HeaderRimac.aspx.cs" Inherits="InformesPlantillas_HeaderRimacInforme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Rimac</title>
	 <link href='<%= ResolveUrl("~/InformesPlantillas/infRimac.css?nc=" + DateTime.Now.Ticks) %>' rel="Stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <div class="Header">
			  <div class="logo-pasa">
          <asp:Image ID="Image1" ImageUrl="~/InformesPlantillas/assets/header.gif" Width="220px" Height="170px" runat="server" />
			  </div>
      </div>
    </div>
    </form>
</body>
</html>
