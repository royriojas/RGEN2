<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaAjustesPendientes.aspx.cs"
  Inherits="vListaAjustesPendientes" %>

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
              <asp:Label ID="Label1" runat="server" Text="Lista de Ajustes Pendientes" Font-Bold="True"
                Font-Size="18px"></asp:Label>
            </div>
            <div class="hr">
            </div>
            <div>
              <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="odsAjustesDelAjustador"
                  AllowPaging="True" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound">
                  <Columns>
                    <asp:BoundField DataField="Aseguradora" HeaderText="Aseguradora" SortExpression="Aseguradora" />
                    <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado" />
                    <asp:BoundField DataField="Broker" HeaderText="Broker" SortExpression="Broker" />
                    <asp:BoundField DataField="numeroPoliza" HeaderText="N&#176; P&#243;liza" SortExpression="numeroPoliza" />
                    <asp:BoundField DataField="Ramo" HeaderText="Ramo" SortExpression="Ramo" />
                    <asp:BoundField DataField="fsiniestro" HeaderText="F. Siniestro" SortExpression="fsiniestro" />
                    <asp:BoundField DataField="NroDias" HeaderText="N&#176; D&#237;as" SortExpression="NroDias" />
                    <asp:BoundField DataField="siniestro" HeaderText="Tipo" SortExpression="siniestro" />
                    <asp:BoundField DataField="numAjustePASA" HeaderText="N&#176; Ajuste" SortExpression="numAjustePASA" />
                    <asp:BoundField DataField="NumeroAjuste" HeaderText="N&#176; Ajuste" SortExpression="NumeroAjuste"
                      Visible="False" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Dias" HeaderText="N&#176; D&#237;as" SortExpression="Dias" />
                    <asp:BoundField DataField="EstimadoReserva" HeaderText="Reserva" SortExpression="EstimadoReserva" />
                    <asp:BoundField DataField="observaciones" HeaderText="observaciones" SortExpression="observaciones" />
                  </Columns>
                  <RowStyle CssClass="ItemStyle" HorizontalAlign="Center" />
                  <HeaderStyle CssClass="HeaderStyle" Height="20px" />
                  <PagerSettings Position="TopAndBottom" />
                </asp:GridView>
              </ajax:AjaxPanel>
              <asp:ObjectDataSource ID="odsAjustesDelAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsAjusteTableAdapters.ListaAjusteTableAdapter"
                OnSelected="odsAjustesDelAjustador_Selected">
                <SelectParameters>
                  <asp:SessionParameter ConvertEmptyStringToNull="False" DefaultValue="68" Name="ajustadorId"
                    SessionField="UsuarioId" Type="Decimal" />
                </SelectParameters>
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
