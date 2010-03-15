<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TitulosAdicionales.ascx.cs"
  Inherits="InformesPlantillas_TitulosAdicionales" %>
  <%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<div id="divTitulosAdionales" runat="server">
  <cc1:repeater id="repeaterTitulos" runat="server" datasourceid="odsTitulosAdicionales">
        <ItemTemplate>
          <h3>
            <asp:Literal ID="SubtituloSeccionLabel" runat="server" Text='<%# Eval("tituloPadre") %>'></asp:Literal>
          </h3>
          <asp:Literal ID="ContenidoSeccionLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("contenidoPadre")) %>'></asp:Literal>
        </ItemTemplate>
		
      </cc1:repeater>
  <asp:ObjectDataSource ID="odsTitulosAdicionales" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsReporteTableAdapters.SeccionesTotalTableAdapter"
    OnSelected="odsTitulosAdicionales_Selected">
    <SelectParameters>
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
</div>
