<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaClausulasComunes.aspx.cs"
    Inherits="vListaClausulasComunes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Lista de Cláusulas Comunes</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.invisible {
	    display:none;
	    
	}
	</style>
</head>
<body style="background-image: none; background-color: #4C96C9; color: #ffffff;">
    <div style="margin-left: auto; margin-right: auto; position: relative; width: 700px;
        left: 0px; top: 0px;">
        <form id="formClausulasComunes" runat="server">
            <div style="position: relative">
                <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;">
                    <div style="margin-top: 5px; left: 0px; margin-bottom: 5px; width: 700px; position: relative;
                        top: 0px; height: 30px; background-color: #4582bb">
                        &nbsp;<asp:Label ID="lblListaClausulas" runat="server" Font-Bold="True" Font-Size="18px">Lista de Cláusulas Comunes</asp:Label>&nbsp;
                    </div>
                    <div style="padding: 10px; width: 680px; margin-bottom: 10px;" class="DataTable">
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 650px">
                            <tr>
                                <td style="width: 100px; height: 18px;">
                                    Ramo</td>
                                <td style="width: 574px; height: 18px;">
                                    <asp:DropDownList ID="cbxRamo" runat="server" DataSourceID="odsRamo" DataTextField="nombre"
                                        DataValueField="ramoId" AutoPostBack="True" OnSelectedIndexChanged="cbxRamo_SelectedIndexChanged"
                                        CssClass="FormText" OnDataBound="cbxRamo_DataBound" Width="301px">
                                    </asp:DropDownList>
                                    <asp:Button Style="position: absolute; left: 643px; top: 12px;" ID="btnVolver" runat="server"
                                        CssClass="FormButton" Text="Volver" ToolTip="Volver a la Página Anterior" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="ListaDocumentos" style="margin-left: auto; margin-right: auto; position: relative">
                        <div>
                            <asp:GridView ID="gridListaClausulas" runat="server" CssClass="DataTable" AutoGenerateColumns="False"
                                DataSourceID="sqlClausulasComunes" Width="700px">
                                <HeaderStyle CssClass="HeaderStyle" />
                                <Columns>
                                    <asp:TemplateField HeaderText="N&#186;">
                                        <ItemStyle HorizontalAlign="Center" Width="10px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ClausulaId" HeaderText="ClausulaId" InsertVisible="False"
                                        ReadOnly="True" SortExpression="ClausulaId" Visible="False" />
                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Contenido" HeaderText="Contenido" SortExpression="Contenido">
                                        <ItemStyle Width="250px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fcrea" HeaderText="fcrea" SortExpression="fcrea" Visible="False" />
                                    <asp:BoundField DataField="fupdate" HeaderText="fupdate" SortExpression="fupdate"
                                        Visible="False" />
                                    <asp:BoundField DataField="ucrea" HeaderText="ucrea" SortExpression="ucrea" Visible="False" />
                                    <asp:BoundField DataField="uupdate" HeaderText="uupdate" SortExpression="uupdate"
                                        Visible="False" />
                                    <asp:BoundField DataField="ramoId" HeaderText="ramoId" SortExpression="ramoId" Visible="False" />
                                    <asp:TemplateField>
                                        <ItemStyle Width="10px" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkClausulas" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div>
                        &nbsp;
                        <asp:SqlDataSource ID="sqlClausulasComunes" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                            SelectCommand="sp_rgen_ClausulasComunes_RamoId" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
                                    Type="Decimal" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                            InsertCommand="sp_rgen_ClausulasInsert" InsertCommandType="StoredProcedure" OnInserting="SqlDataSource1_Inserting1"
                            SelectCommand="SELECT RGN_CLAUSULAS.* FROM RGN_CLAUSULAS">
                            <InsertParameters>
                                <asp:Parameter Direction="InputOutput" Name="ClausulasId" Type="Decimal" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <br />
                    </div>
                    <div style="width: 300px; height: 80px; position: relative; left: 0px; top: 0px;"
                        id="Div1">
                        <div style="position: absolute; left: 15px; top: 17px;">
                            &nbsp;
                            <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/imgRGen/save.gif" ToolTip="Guardar El Registro"
                                TabIndex="26" OnClick="btnGuardar_Click" Style="z-index: 100; left: 0px; position: absolute;
                                top: 0px" />
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <asp:ObjectDataSource ID="odsRamo" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsComboTableAdapters.RamoComboTableAdapter"></asp:ObjectDataSource>
</body>
</html>
