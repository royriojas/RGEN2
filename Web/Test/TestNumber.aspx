<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestNumber.aspx.cs" Inherits="Test_TestNumber" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <ajax:AjaxPanel ID="AjaxPanel1" runat="server" Height="374px" Width="702px">
        Número
        <asp:TextBox ID="TextBox1" runat="server" Width="190px"></asp:TextBox>
        <asp:Button ID="btnToNumber" runat="server" OnClick="btnToNumber_Click" Text="Go" /><br />
        <br />
        <asp:Label ID="Label1" runat="server" Font-Size="20pt" Text="Label"></asp:Label>
        <br />
         <p><%= GestorInforme.getSubtitle("SUMA_ASEGURADA", 1257) %></p>
        <br />       
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Button" /></ajax:AjaxPanel>    
      <asp:ObjectDataSource ID="odsTituloNew" runat="server" DeleteMethod="Delete"
        OldValuesParameterFormatString="{0}" SelectMethod="GetData" TypeName="dsSecInformeTableAdapters.SeccionesAdicionalesAjusteTableAdapter"
        UpdateMethod="Update">
        <DeleteParameters>
          <asp:Parameter Name="seccionId" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
          <asp:Parameter Name="TituloSeccion" Type="String" />
          <asp:Parameter Name="ContenidoSeccion" Type="String" />
          <asp:Parameter Name="uupdate" Type="String" />
          <asp:Parameter Name="visible" Type="Boolean" />
          <asp:Parameter Name="ajusteId" Type="Decimal" />
          <asp:Parameter Name="seccionId" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
          <asp:Parameter Name="ajusteid" Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    
    </form>
</body>
</html>
