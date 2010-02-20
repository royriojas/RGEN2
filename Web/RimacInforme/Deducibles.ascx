<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Deducibles.ascx.cs" Inherits="RimacInforme_Deducibles" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<div id="divDeducibles" runat="server">
    <cc1:Repeater ID="repeaterDeducibles" runat="server" DataSourceID="odsDeducibles">
        <ItemTemplate>
            <ul>
                <li>
                    <asp:Label ID="deducibleLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("condiciones"))%>'></asp:Label></li>
            </ul>
        </ItemTemplate>
    </cc1:Repeater>
    <asp:ObjectDataSource ID="odsDeducibles" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter"
        OnSelected="odsDeducibles_Selected">
        <SelectParameters>
            <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>
