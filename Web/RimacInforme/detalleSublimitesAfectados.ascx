<%@ Control Language="C#" AutoEventWireup="true" CodeFile="detalleSublimitesAfectados.ascx.cs"
    Inherits="RimacInforme_detalleSublimitesAfectados" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<div id="divSublimitesAfectados" runat="server">
    <cc1:Repeater ID="repeaterSublimites" runat="server" 
        OnItemCreated="repeaterSublimites_ItemCreated1" OnItemDataBound="repeaterSublimites_ItemDataBound">
        <EmptyDataTemplate>
        </EmptyDataTemplate>
        <HeaderTemplate>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Grid">
                <tr class="header">
                    <th width="4%">
                        Nº
                    </th>
                    <th width="28%">
                        DETALLE
                    </th>
                    <th width="24%">
                        LOCAL
                    </th>
                    <th width="22%">
                        <asp:Label ID="concepto1Label" runat="server" Text=''></asp:Label>
                    </th>
                    <th width="22%">
                        <asp:Label ID="concepto2Label" runat="server" Text=''></asp:Label>
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
                    <asp:Label ID="detalleLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("detalle"))%>'></asp:Label>
                </td>
                <td valign="top">
                    <asp:Label ID="localLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("localItem"))%>'></asp:Label>
                </td>
                <td valign="top">
                    <div style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("monto")) %>; text-align: right;'>
                        <asp:Label ID="simboloLabel" runat="server" Text='<%# Eval("simbolo")%>'></asp:Label>
                        <asp:Label ID="montoLabel" runat="server" Text='<%# Eval("monto", "{0:#,###.00}")%>'></asp:Label>
                    </div>
                </td>
                <td valign="top">
                    <div style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("montoAsegurado2")) %> text-align: right;'>
                        <asp:Label ID="simbolo2Label" runat="server" Text='<%# Eval("simbolo")%>'></asp:Label>
                        <asp:Label ID="montoAsegurado2" runat="server" Text='<%# Eval("montoAsegurado2", "{0:#,###.00}")%>'></asp:Label>
                    </div>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </cc1:Repeater>
    <asp:ObjectDataSource ID="odsPolizaDetalle" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoPolizaDetalleTableAdapter"
        OnSelecting="odsPolizaDetalle_Selecting" OnSelected="odsPolizaDetalle_Selected">
        <SelectParameters>
            <%--<asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />--%>            
            <asp:Parameter Name="ajusteid"  />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>
