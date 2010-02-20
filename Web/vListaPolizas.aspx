<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaPolizas.aspx.cs" Inherits="vListaPolizas" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="linksPoliza.ascx" TagName="linksPoliza" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

  <script language="javascript" type="text/javascript" src="scripts/calendar/datetimepicker.js"></script>

  <title>Riesgos Generales | Lista de Pólizas</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />

  <script type='text/javascript' src="Scripts/lib/x_core.js"></script>

  <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" language="javascript">
	window.onload = function () {
	
	btn_mostrar_Ocultar = new CollapsibleDiv('img_hide_cabecera',
						 'cabecera_collapsible',						 
						 true,
						 null);
	btn_agregarNuevoArchivo = new CollapsibleDiv('img_hide_grpBusqueda',
						 'grupoBusqueda',						 
						 true,
						 null);
	
}

window.onunload= function () {
	if (btn_mostrar_Ocultar) btn_mostrar_Ocultar.UnLoad();
}
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 960px;">
    <form id="form1" runat="server">
      <div id="cabecera_collapsible" style="position: relative;">
        <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="poliza" />
        <uc2:linksPoliza ID="LinksPoliza1" runat="server" />
      </div>
      <div style="position: relative;">
        &nbsp;
      </div>
      <ajax:AjaxPanel ID="AjaxPanel1" runat="server">
        <!-- aqui -->
        <div id="grupoBusqueda">
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
          <div class="DataContent">
            <div class="DataContentRight">
              <div style="position: relative;">
                <asp:Label ID="lblBusqueda" runat="server" Font-Bold="True" Font-Size="18px">Búsqueda</asp:Label>
                <img alt="" src="imgRGen/openCloseCollapse.jpg" id="img_hide_cabecera" title="Ocultar/Mostrar Cabecera"
                  style="position: absolute; left: 925px; top: 1px;" />
                <div class="hr">
                </div>
              </div>                              
              <div style="position: relative;">
                <table width="450" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td style="height: 10px; width: 20px;">
                      &nbsp;</td>
                    <td width="154">
                      &nbsp;</td>
                    <td width="250">
                      <span style="width: 182px; height: 12px">&nbsp;</span></td>
                    <td width="18">
                      &nbsp;</td>
                    <td width="24">
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td style="width: 20px; height: 20px;">
                      &nbsp;</td>
                    <td width="154" style="height: 20px">
                      <span style="width: 119px; height: 24px;">Asegurado</span></td>
                    <td width="250" style="height: 20px">
                      <span style="width: 57px; height: 24px;">
                        <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" Width="203px" TabIndex="1"></asp:TextBox>
                      </span>
                    </td>
                    <td width="18" style="height: 20px">
                      &nbsp;</td>
                    <td width="24" rowspan="2">
                      &nbsp;<asp:ImageButton ID="ibtnBuscar" runat="server" ImageUrl="~/imgRGen/btnBuscar.gif"
                  TabIndex="17" OnClick="ibtnBuscar_Click" />&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="20" style="width: 20px">
                      &nbsp;</td>
                    <td width="154" height="20">
                      Aseguradora</td>
                    <td width="250" height="20">
                      <span style="width: 57px; height: 24px;">
                        <asp:DropDownList ID="cbxCia" runat="server" CssClass="FormSelect" Width="207px"
                          TabIndex="2" AppendDataBoundItems="True" DataSourceID="odsCia" DataTextField="persona"
                          DataValueField="personaid" OnDataBound="cbxCia_DataBound">
                        </asp:DropDownList>
                      </span>
                    </td>
                    <td width="18" height="20">
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td height="20" style="width: 20px">
                      &nbsp;</td>
                    <td width="154" height="20">
                      <span style="width: 128px; height: 24px;">Nro. Poliza</span></td>
                    <td width="250" height="20">
                      <span style="width: 158px; height: 24px;">
                        <asp:TextBox ID="txtPoliza" runat="server" CssClass="FormText" Width="203px" TabIndex="7"></asp:TextBox>
                      </span>
                    </td>
                    <td width="18" height="20">
                      &nbsp;</td>
                    <td width="24" height="20">
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td style="width: 20px">
                      </td>
                    <td>
                      &nbsp;</td>
                    <td>
                      &nbsp;</td>
                    <td>
                      &nbsp;</td>
                    <td>
                      &nbsp;</td>
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
        <!-- aqui -->
        <br />
        <!-- tabControl for Sytled -->
        <div id="grilla">
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
          <div class="DataContent">
            <div class="DataContentRight">
              <div style="height: 35px;">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="18px">Lista de Pólizas</asp:Label>
                <img alt="" src="imgRGen/openCloseCollapse.jpg" id="img_hide_grpBusqueda" title="Ocultar/Mostrar filtros de Búsqueda"
                  style="position: absolute; left: 926px; top: 4px;" />
                <div class="hr">
                </div>
              </div>
              <div style="position: relative;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="935px"
                  AllowSorting="True" OnRowDataBound="GridView1_RowDataBound" AllowPaging="True"
                  CellPadding="0" PageSize="30" DataSourceID="odsListaPolizas">
                  <RowStyle CssClass="ItemStyle" HorizontalAlign="Center" />
                  <HeaderStyle CssClass="HeaderStyle" Height="30px" />
                  <EmptyDataTemplate>
                    No hay Pólizas para mostrar que cumplan con esos criterios de Búsqueda
                  </EmptyDataTemplate>
                  <Columns>
                    <asp:BoundField DataField="polizaId" HeaderText="polizaId" InsertVisible="False"
                      ReadOnly="True" SortExpression="polizaId" Visible="False" />
                    <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado">
                      <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Aseguradora" HeaderText="Aseguradora" SortExpression="Aseguradora" />
                    <asp:BoundField DataField="numeroPoliza" HeaderText="N&#186; P&#243;liza" SortExpression="numeroPoliza" />
                    <asp:BoundField DataField="Ramo" HeaderText="Ramo" SortExpression="Ramo" />
                    <asp:BoundField DataField="Cobertura" HeaderText="Cobertura" SortExpression="Cobertura" />
                    <asp:BoundField DataField="Producto" HeaderText="Producto" SortExpression="Producto" />
                    <asp:BoundField DataField="finicio" DataFormatString="{0:dd-MM-yyyy}" HeaderText="Inicio"
                      SortExpression="finicio">
                      <ItemStyle Width="70px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ffin" DataFormatString="{0:dd-MM-yyyy}" HeaderText="Fin"
                      SortExpression="ffin">
                      <ItemStyle Width="70px" />
                    </asp:BoundField>
                  </Columns>
                </asp:GridView>
              </div>
              <asp:ObjectDataSource ID="odsCia" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
              <asp:ObjectDataSource ID="odsListaPolizas" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaListaFiltrosTableAdapter">
                <SelectParameters>
                  <asp:ControlParameter ControlID="txtAsegurado" Name="asegurado" PropertyName="Text"
                    Type="String" />
                  <asp:ControlParameter ControlID="cbxCia" Name="Idcia" PropertyName="SelectedValue"
                    Type="String" />
                  <asp:ControlParameter ControlID="txtPoliza" Name="numpoliza" PropertyName="Text"
                    Type="String" />
                </SelectParameters>
              </asp:ObjectDataSource>
              <br />
            </div>
          </div>
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
        </div>
      </ajax:AjaxPanel>
    </form>
  </div>
</body>
</html>
