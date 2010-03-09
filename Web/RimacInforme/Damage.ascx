<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Damage.ascx.cs" Inherits="RimacInforme_Damage" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<div id="divDanos" runat="server">
  <%--<cc1:Repeater ID="Repeater1" runat="server" DataSourceID="odsOcurrenciaDetalle" OnItemDataBound="Repeater1_ItemDataBound">
        <HeaderTemplate>
            <table  border="0" cellpadding="0" cellspacing="0" class="GridView Grid" >
                <tr class="header">
                    <th width="4%">
                        Nº
                    </th>
                    <th width="28%">
                        BIENES Y/O PERSONAS AFECTADAS
                    </th>
                    <th width="24%">
                        DESCRIPCIÓN DE LOS DAÑOS, PERDIDAS Y/O HERIDAS
                    </th>
                    <th width="26%">
                        LOCAL
                    </th>
                    <th width="18%">
                        ESTIMACIÓN DE DAÑO Y/O PERDIDA
                    </th>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td valign="top">
                    <div align="center">
                        <asp:Label ID="itemLabel" runat="server" Text='<%# this.Num++ %>'></asp:Label>
                    </div>
                </td>
                <td valign="top">
                    <%#R3M.Common.Util.ReplaceASBR(Eval("Bienes"))%>
                </td>
                <td valign="top">
                    <%#R3M.Common.Util.ReplaceASBR(Eval("descripcion"))%>
                </td>
                <td valign="top">
                    <%#(Eval("LocalDelBien"))%>
                </td>
                <td valign="top">
                    <div style="text-align: right;">
                        <%#Eval("estimacion", "{0:#,###.00}")%>
                    </div>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            <tr>
                <td colspan="4" valign="top">
                    <div class="Negrita" align="right">
                        TOTAL PÉRDIDAS ESTIMADAS US$
                    </div>
                </td>
                <td valign="top">
                    <div style="text-align: right;">
                        <%#  SumaDetalleOcurrencia.ToString("#,###.00")%>
                    </div>
                </td>
            </tr>
            </table>
        </FooterTemplate>
    </cc1:Repeater>--%>
  <cc1:Repeater ID="Repeater1" runat="server" DataSourceID="odsOcurrenciaDetalle" OnItemDataBound="Repeater1_ItemDataBound">
    <HeaderTemplate>
      
    </HeaderTemplate>
    <ItemTemplate>
      
        <%#R3M.Common.Util.ReplaceASBR(Eval("Bienes"))%>
      
    </ItemTemplate>
    <FooterTemplate>
      
    </FooterTemplate>
  </cc1:Repeater>
  <asp:ObjectDataSource ID="odsOcurrenciaDetalle" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoOcurrenciaDetalleTableAdapter"
    OnSelecting="odsOcurrenciaDetalle_Selecting" OnSelected="odsOcurrenciaDetalle_Selected">
    <SelectParameters>
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
    </SelectParameters>
  </asp:ObjectDataSource>
</div>
