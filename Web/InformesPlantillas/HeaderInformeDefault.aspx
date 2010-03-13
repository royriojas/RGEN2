<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HeaderInformeDefault.aspx.cs"
  Inherits="InformesPlantillas_HeaderInformeDefault" %>

<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Header</title>
  <link href="inf.css?nc=<%= DateTime.Now.ToString() %>" rel="stylesheet" type="text/css" />
  <style type="text/css">
    body { line-height:100%; }
    .ReportCellHeader { font-size:17px; }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <table class="ReportCellHeader" border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
        <td style="width: 50%">
          <div class="logo">
            <img alt="" src="~/img/LogoPasa.jpg" width="276" height="235" runat="server" />
          </div>
        </td>
        <td valign="top" style="width: 52%">
          <asp:FormView ID="frmDatosCabecera" runat="server" DataSourceID="odsCabecera" OnDataBound="frmDatosCabecera_DataBound">
            <ItemTemplate>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td colspan="3" valign="top">
                    <h1 class="TitInforme">
                      <asp:Label ID="lblTipoInforme" runat="server" Text="INFORME BÁSICO"></asp:Label></h1>
                  </td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    FECHA DE INFORME</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="lblFechaSiniestro" runat="server" Text="Label"></asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    Nº SIN ASEG</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="numsiniestroLabel" runat="server" Text='<%# Bind("numsiniestro") %>'>
                    </asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    Nº SIN BROKER</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="numsiniestroBrokerLabel" runat="server" Text='<%# Bind("numsiniestroBroker") %>'>
                    </asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    Nº DE AJUSTE</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="numajusteLabel" runat="server" Text='<%# Bind("numajuste") %>'></asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    RAMO</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="tipopolizaLabel" runat="server" Text='<%# Bind("tipopoliza") %>'>
                    </asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    Nº DE PÓLIZA</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="numpolizaLabel" runat="server" Text='<%# Bind("numpoliza") %>'></asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    TIPO DE SINIESTRO</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="tiposiniestroLabel" runat="server" Text='<%# Bind("tiposiniestro") %>'>
                    </asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    AJUSTADOR</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="ajustadorLabel" runat="server" Text='<%# Bind("ajustador") %>'></asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px" valign="top">
                    FECHA DE SINIESTRO</td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="fsiniestroLabel" runat="server" Text='<%# Eval("fsiniestro", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label></td>
                </tr>
                <tr>
                  <td class="Negrita" style="width: 231px;" valign="top">
                    <asp:Label ID="lblTipoMonto" runat="server" Text="RESERVA NETA"></asp:Label></td>
                  <td class="Negrita" style="width: 15px">
                    :</td>
                  <td style="text-align: left">
                    <asp:Label ID="monedaLabel" runat="server" Text='<%# Bind("moneda") %>'></asp:Label>
                    <asp:Label ID="reservaLabel" runat="server" Text='<%# Eval("reserva", "{0:#,##0.00}") %>'></asp:Label></td>
                </tr>
              </table>
            </ItemTemplate>
          </asp:FormView>    
        </td>
      </tr>
    </table>
    <div class="line">
    </div>
          <asp:ObjectDataSource ID="odsCabecera" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoCabeceraTableAdapter">
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId"
                Type="Int32" />
            </SelectParameters>
          </asp:ObjectDataSource>
  </form>
</body>
</html>
