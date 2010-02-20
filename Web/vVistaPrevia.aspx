<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vVistaPrevia.aspx.cs" Inherits="vVistaPrevia" %>

<%@ Register Src="ucLoadCss.ascx" TagName="ucLoadCss" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Vista Previa</title>    
  <style type="text/css"> body { margin:0px; }</style>
</head>
<body>
  <form id="form1" runat="server">
    <asp:Literal ID="ltlHeader" runat="server"></asp:Literal>   
    <asp:Literal ID="ltlBody" runat="server"></asp:Literal>
    <uc1:ucLoadCss ID="UcLoadCss1" runat="server" />
  </form>
</body>
</html>
