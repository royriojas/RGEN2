<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaControlCalidad.aspx.cs"
  Inherits="vListaControlCalidad" %>

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
            <div>
              <asp:Label ID="Label1" runat="server" Text="Lista de Ajustes en Control de Calidad" Font-Bold="True"
                Font-Size="18px"></asp:Label>
            </div>
            <div class="hr">
            </div>
            <div>
              <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="odsAjustesControlCalidad"
                AllowPaging="True" AllowSorting="True" PageSize="20" Width="966px" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                  <asp:BoundField DataField="nombre" HeaderText="Tipo Informe" SortExpression="nombre" />
                  <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado" />
                  <asp:BoundField DataField="siniestro" HeaderText="Siniestro" SortExpression="siniestro" />
                  <asp:BoundField DataField="fsiniestro" HeaderText="Fecha Siniestro" SortExpression="fsiniestro" />
                  <asp:BoundField DataField="Aseguradora" HeaderText="Aseguradora" SortExpression="Aseguradora" />
                  <asp:BoundField DataField="numAjustePASA" HeaderText="N&#176; Ajuste PA" SortExpression="numAjustePASA" />
                  <asp:BoundField DataField="numeroPoliza" HeaderText="N&#176; P&#243;liza" SortExpression="numeroPoliza" />
                  <asp:BoundField DataField="Ramo" HeaderText="Ramo" SortExpression="Ramo" />
                  <asp:BoundField DataField="Reserva" HeaderText="Reserva" SortExpression="Reserva" />
                  <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                  <asp:BoundField DataField="observaciones" HeaderText="observaciones" SortExpression="observaciones" />
                  <asp:BoundField DataField="Broker" HeaderText="Broker" SortExpression="Broker" />
                </Columns>
                <RowStyle CssClass="ItemStyle" HorizontalAlign="Center" />
                <HeaderStyle CssClass="HeaderStyle" Height="20px" />
              </asp:GridView>
              <br />
              <asp:ObjectDataSource ID="odsAjustesControlCalidad" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsInformesTableAdapters.InformeListaControlTableAdapter">
              </asp:ObjectDataSource>
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
  </div>
</body>
</html>
