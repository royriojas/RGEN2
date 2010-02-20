<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAsignarAjustador.aspx.cs"
  Inherits="vAsignarAjustador" %>

<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
  TagPrefix="uc2" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Registro de Ajuste</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css' />
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/style.css' />

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script type="text/javascript">
        function refrescate() {
            var nuevaUrl = document.location.href;
            document.location.href = nuevaUrl;
        }
  </script>

</head>
<body>
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 999px;
    height: 472px; left: 0px; top: 0px;">
    <form id="form1" runat="server">
      <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="ajuste" />
      <uc2:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server" />
      <div id="ContenidoPagina">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight">
            <div style="margin-bottom: 5px;">
              <asp:Label ID="lblListaAjusteSinAjustador" Text="Lista de Ajustes sin Ajustador"
                Font-Bold="True" Font-Size="18px" runat="server"></asp:Label>
            </div>
            <div class="hr">
            </div>
            <div>
              <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1"
                Width="972px" OnRowDataBound="GridView1_RowDataBound" Style="left: 1px" AllowSorting="True">
                <Columns>
                  <asp:BoundField DataField="Aseguradora" HeaderText="Aseguradora" SortExpression="Aseguradora" />
                  <asp:BoundField DataField="Broker" HeaderText="Broker" SortExpression="Broker" />
                  <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado" />
                  <asp:BoundField DataField="siniestro" HeaderText="Tipo" SortExpression="siniestro" />
                  <asp:BoundField DataField="fsiniestro" HeaderText="F. Siniestro" SortExpression="fsiniestro" />
                  <asp:BoundField DataField="NroDias" HeaderText="N&#186; D&#237;as" SortExpression="NroDias" />
                  <asp:BoundField DataField="numAjustePASA" HeaderText="N&#186; Ajuste" SortExpression="numAjustePASA" />
                  <asp:BoundField DataField="NumeroAjuste" HeaderText="N&#186; Ajuste" SortExpression="NumeroAjuste"
                    Visible="False" />
                  <asp:BoundField DataField="numeroPoliza" HeaderText="N&#186; P&#243;liza" SortExpression="numeroPoliza" />
                  <asp:BoundField DataField="observaciones" HeaderText="Observaciones" SortExpression="observaciones" />
                </Columns>
                <RowStyle CssClass="ItemStyle" />
                <HeaderStyle CssClass="HeaderStyle" Height="20px" />
                <EmptyDataTemplate>
                  No hay ajustes sin ajustador asignado...
                </EmptyDataTemplate>
              </asp:GridView>
              &nbsp;<br />
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
    </form>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetDataByAjustadorNull" TypeName="dsAjusteTableAdapters.ListaAjusteTableAdapter">
    </asp:ObjectDataSource>
  </div>

  <script type="text/javascript" language="javascript">
			creaPopUpDivs();
  </script>

</body>
</html>
