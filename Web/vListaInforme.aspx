<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaInforme.aspx.cs" Inherits="vListaInforme" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Lista de Informes Aprobados</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>

  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript">
    function VerInforme(ajusteId, informeId)
    {
      ShowReport('vViewPdf.aspx?AjusteId='+ ajusteId + '&InformeId=' + informeId);
    }
  </script>

</head>
<body>
  <div style="width: 695px; overflow: auto; position: relative; height: 350px;">
    <div id="contenedor" style="width: 675px; position: relative;" runat="server">
      <div class="DataTop">
        <div class="DataTopLeft">
        </div>
        <div class="DataTopRight">
        </div>
      </div>
      <div class="DataContent">
        <div class="DataContentRight" style="padding: 1%;">
          <div class="PanelEncabezado">
            <asp:Label ID="lblListaClausulas" runat="server" Font-Bold="True" Font-Size="18px">Lista de Informes</asp:Label></div>
          <div class="hr">
          </div>
          <form id="formRegistroClausulas" runat="server">
            <div style="position: relative">
              <div id="ListaClausulas" style="margin-left: auto; margin-right: auto; position: relative">
                <div>
                  <asp:GridView ID="gridInformacionRelevante" runat="server" AutoGenerateColumns="False"
                    DataSourceID="informesAprobados" Width="651px" OnRowDataBound="gridInformacionRelevante_RowDataBound">
                    <Columns>
                      <asp:BoundField DataField="nombre" HeaderText="Tipo Informe" SortExpression="nombre" />
                      <asp:BoundField DataField="fcrea" DataFormatString="{0:dd/MM/yy HH:mm}" HeaderText="Fecha de Creaci&#243;n"
                        HtmlEncode="False" SortExpression="fcrea" />
                      <asp:TemplateField HeaderText="Acci&#243;n">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle Width="80px" />
                        <ItemTemplate>
                          <asp:HyperLink ID="informeHyperLink" runat="server" ImageUrl="~/images/IconPdf16.gif"
                            ToolTip="Ver informe">Ver informe</asp:HyperLink>&nbsp;&nbsp;
                          <asp:ImageButton ID="enviaMail" runat="server" ImageUrl="~/images/IconUbigeo16.gif"
                            PostBackUrl='<%# "vEnviaMail.aspx?informeId="+Eval("informeId")+"&AjusteId="+Eval("ajusteId")+"&UrlAnterior="+UrlAnterior %>' />
                        </ItemTemplate>
                      </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="HeaderStyle" />
                    <RowStyle CssClass="ItemStyle" />
                    <EmptyDataTemplate>
                      <asp:Label ID="Label1" runat="server" Text="No hay ningún Informe Publicado a la fecha"
                        Width="270px"></asp:Label>
                    </EmptyDataTemplate>
                  </asp:GridView>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="DataBottom">
        <div class="DataBottomLeft">
        </div>
        <div class="DataBottomRight">
        </div>
      </div>
    </div>
  </div>
  <asp:ObjectDataSource ID="informesAprobados" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetDataAprobado" TypeName="dsInformesTableAdapters.InformeListaTableAdapter">
    <SelectParameters>
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
</body>
</html>
