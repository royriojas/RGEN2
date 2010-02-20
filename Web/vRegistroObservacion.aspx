<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroObservacion.aspx.cs"
  Inherits="vRegistroObservacion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Registro de Observaciones</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

</head>
<body style="background-image: none;">
  <form id="form1" runat="server">
    <div>
      <div class="DataTop">
        <div class="DataTopLeft">
        </div>
        <div class="DataTopRight">
        </div>
      </div>
      <div class="DataContent">
        <div class="DataContentRight" style="padding:1%;">
          <div class="PanelEncabezado" style="height: 30px;">
            <img id="btnShowFilters" src="./imgRGen/openCloseCollapse.jpg" alt="Agregar" title="Agregar"
              class="btnCollapse" style="right: 15px; top: 1px" />
            <asp:Label ID="lblListaTitulo" runat="server" Text="Registrar Observación" Font-Bold="True"
              Font-Size="18px"></asp:Label>
            <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
              onclick="return separar();" Width="22px"></asp:HyperLink>
          </div>
          <div class="hr">
          </div>
          <div class="DataTable" style="padding: 5px;">
            <table width="503" height="113" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" style="height: 66px">
                  <asp:TextBox ID="txtObservacion" runat="server" TextMode="MultiLine" Width="600px"
                    CssClass="FormText" Rows="5"></asp:TextBox></td>
              </tr>
              <tr>
                <td height="19" valign="top">
                  &nbsp;</td>
              </tr>
              <tr>
                <td height="19" valign="top">
                  <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/IconSave24.gif"
                    OnClick="ImageButton1_Click" /></td>
              </tr>
            </table>
          </div>
        </div>
      </div>
      <div class="DataBottom">
        <div class="DataBottomLeft">
        </div>
        <div class="DataBottomRight">
        </div>
      </div>
    </div>
    <asp:ObjectDataSource ID="odsRegistroObservacion" runat="server" SelectMethod="GetData"
      TypeName="dsAjusteTableAdapters.SituacionAjusteListadoTableAdapter" UpdateMethod="Update">
      <UpdateParameters>
        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
        <asp:ControlParameter ControlID="txtObservacion" Name="observacion" PropertyName="Text"
          Type="String" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
  </form>
</body>
</html>
