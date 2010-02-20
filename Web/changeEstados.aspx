<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changeEstados.aspx.cs" Inherits="changeEstados" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Administrar estados del Ajuste</title>
    <link rel='stylesheet' type='text/css' href='css/layout.css' />
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin: 5px; padding: 5px; background: #0099CC;">
            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="14px" Text="Administración de Estados"></asp:Label>
        </div>
        <div style="margin: 5px; padding: 5px; background: #0099CC;">
            &nbsp;<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="odsAdministraEstados"
                Height="140px" Width="525px">
                <Columns>
                    <asp:BoundField DataField="estadoajuste" HeaderText="Estado" ReadOnly="True" SortExpression="estadoajuste">
                        <ItemStyle Width="350px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="codigo" HeaderText="codigo" ReadOnly="True" SortExpression="codigo"
                        Visible="False" />
                    <asp:TemplateField HeaderText="Fecha De Cambio" SortExpression="FechaDeCambio">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" MaxLength="10" Text='<%# Bind("FechaDeCambio", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox1"
                                Display="None" ErrorMessage="La fecha debe estar en el formato dd/mm/yyyy" ValidationExpression="^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$">(*)</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                Display="None" ErrorMessage="no puede dejar el campo en blanco">(*)</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="200px" />
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaDeCambio", "{0:dd-MM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="estadoajusteid" InsertVisible="False" SortExpression="estadoajusteid">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("estadoajusteid") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemStyle CssClass="invisible" />
                        <HeaderStyle CssClass="invisible" />
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("estadoajusteid") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterStyle CssClass="invisible" />
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update"
                                ImageUrl="~/imgRGen/IconSave16.gif" Text="Update" />&nbsp;<asp:ImageButton ID="ImageButton2"
                                    runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/imgRGen/iconCancel.gif"
                                    Text="Cancel" />
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="40px" />
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="~/imgRGen/IconEdit.gif" Text="Edit" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="ItemStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
            </asp:GridView>
            <asp:Panel style="margin-top:15px;padding-top:10px; text-align:center;vertical-align:middle;" ID="pnlMsg" runat="server" Height="26px" Width="524px" BackColor="#579ACC" HorizontalAlign="Center" Visible="False">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="12px" Text="El Estado fue cambiado con Éxito"></asp:Label></asp:Panel>
        </div>
        <asp:ObjectDataSource ID="odsAdministraEstados" runat="server" OldValuesParameterFormatString="original_{0}"
            OnUpdated="odsAdministraEstados_Updated" SelectMethod="GetData" TypeName="dsEstadoTableAdapters.administraEstadosTableAdapter"
            UpdateMethod="cambiaEstadoAjuste">
            <UpdateParameters>
                <asp:Parameter Name="FechaDeCambio" Type="DateTime" />
                <asp:QueryStringParameter DefaultValue="185" Name="ajusteId" QueryStringField="AjusteId"
                    Type="Decimal" />
                <asp:Parameter Name="estadoAjusteId" Type="Decimal" />
                <asp:SessionParameter DefaultValue="SYSTEM" Name="u_ucrea" SessionField="user" Type="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="185" Name="ajusteId" QueryStringField="AjusteId"
                    Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" />
    </form>
</body>
</html>
