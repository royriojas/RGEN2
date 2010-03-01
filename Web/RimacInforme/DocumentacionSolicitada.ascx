<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DocumentacionSolicitada.ascx.cs"
  Inherits="RimacInforme_DocumentacionSolicitada" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<div id="divDocumentacionSolicitada" runat="server">  
  <cc1:Repeater ID="repeaterDocumentosSolicitados" runat="server" DataSourceID="odsDocumentosSolicitados">
    <HeaderTemplate>
      <ul class="List">
    </HeaderTemplate>
    <ItemTemplate>
      <li>
        <asp:Label ID="documentoLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("nombre")) %>'></asp:Label></li>
    </ItemTemplate>
    <FooterTemplate>
      </ul>
    </FooterTemplate>
  </cc1:Repeater>
  <asp:ObjectDataSource ID="odsDocumentosSolicitados" runat="server" OldValuesParameterFormatString="{0}"
    SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoDocumentacionSolicitadaTableAdapter"
    OnSelected="odsDocumentosSolicitados_Selected">
    <SelectParameters>
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
    </SelectParameters>
  </asp:ObjectDataSource>
</div>
