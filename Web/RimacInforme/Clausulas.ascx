<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Clausulas.ascx.cs" Inherits="RimacInforme_Clausulas" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<div id="divClausulas" runat="server">
    <cc1:Repeater ID="repeaterClausulas" runat="server" DataSourceID="odsClausulas">
        <ItemTemplate>
            <ul>
                <li>
                    <asp:Label ID="clausulaLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("nombre"))%>'></asp:Label></li>
            </ul>
        </ItemTemplate>
    </cc1:Repeater>
    <asp:ObjectDataSource ID="odsClausulas" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoClausulasTableAdapter"
        OnSelected="odsClausulas_Selected">
        <SelectParameters>
            <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>
