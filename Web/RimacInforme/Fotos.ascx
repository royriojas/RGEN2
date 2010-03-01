<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Fotos.ascx.cs" Inherits="RimacInforme_Fotos" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<div id="divImagenes" runat="server">
  <cc1:Repeater ID="Repeater2" runat="server" DataSourceID="odsImagenes" OnDataBinding="Repeater2_DataBinding"
    OnItemDataBound="Repeater2_ItemDataBound">
    <HeaderTemplate>
      <table>
        <tr>
    </HeaderTemplate>
    <ItemTemplate>
      <td valign="top" style="width: 460px;">
        <div class="ImgHolder">
          <img alt="" src='<%# R3M.Common.Util.ResolveURL(string.Format("vGetImageGrande.aspx?AjusteId={0}&ArchivoId={1}&imagen=grande", Request.QueryString["ajusteId"], Eval("archivoId")))  %>' />
        </div>
        <div class="txtInfo">
          <%# Eval("descripcion") %>
        </div>
      </td>
      <asp:Literal ID="separator" runat="server" Visible="false">
            </tr><tr>
      </asp:Literal>
      <asp:Literal ID="TableEnd" runat="server" Visible="false">
          </tr>
          </table>
            <div style="page-break-before: always; clear: both">
            </div>
            <table>
            <tr>
      </asp:Literal>
    </ItemTemplate>
    <FooterTemplate>
      </tr></table>
    </FooterTemplate>
  </cc1:Repeater>
  <asp:ObjectDataSource ID="odsImagenes" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" OnSelected="odsImagenes_Selected" TypeName="dsReporteTableAdapters.InformeBasicoImagenesTableAdapter">
    <SelectParameters>
      <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
        Type="Int32" />
    </SelectParameters>
  </asp:ObjectDataSource>
</div>
