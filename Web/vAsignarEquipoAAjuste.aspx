<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAsignarEquipoAAjuste.aspx.cs"
  Inherits="vAsignarEquipoAAjuste" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <title>Asignar Equipo </title>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript">  
  </script>

</head>
<body>
  <form id="form2" runat="server">
    <div>
      <div id="ContenidoPagina" style="width: 615px;">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight">
            <div>
              <asp:Label ID="lblAjusteNumero" runat="server" Text='Ajuste Número: ' Font-Bold="True"
                Font-Size="18px"></asp:Label>
            </div>
            <div class="hr">
            </div>
            <div>
              <table width="580" border="0" cellspacing="0" cellpadding="0" style="top: 0px">
                <tr>
                  <td style="width: 119px">
                    Nombre
                    <asp:RequiredFieldValidator ControlToValidate="txtNombre" ID="RequiredFieldValidator1"
                      runat="server" ErrorMessage="Ingrese el Nombre de la persona a agregar al Equipo">(*)</asp:RequiredFieldValidator></td>
                  <td colspan="3">
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="FormText" Width="305px"></asp:TextBox>
                    &nbsp;</td>
                  <td width="134">
                  </td>
                </tr>
                <tr>
                  <td style="width: 119px">
                    Especialidad<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                      ControlToValidate="txtEspecialidad" ErrorMessage="Ingrese la especialidad">(*)</asp:RequiredFieldValidator></td>
                  <td colspan="3">
                    <asp:TextBox ID="txtEspecialidad" runat="server" CssClass="FormText" Width="305px"></asp:TextBox></td>
                  <td width="134">
                    <asp:Button ID="btnAgregar" runat="server" CssClass="FormButton" OnClick="btnAgregar_Click"
                      Text="Agregar" /></td>
                </tr>
                <tr>
                  <td style="width: 119px">
                    &nbsp;</td>
                  <td colspan="3">
                    &nbsp;</td>
                  <td width="134">
                    &nbsp;</td>
                </tr>
              </table>
            </div>
            <div class="hr">
            </div>
            <div>
              <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="DataTable"
                DataSourceID="odsEquipo" OnRowCommand="GridView1_RowCommand" Width="580px" CellPadding="1">
                <Columns>
                  <asp:TemplateField HeaderText="N&#176;">
                    <ItemStyle HorizontalAlign="Center" Width="10px" />
                    <ItemTemplate>
                      &nbsp;<asp:HyperLink ID="LynkGasto" runat="server" Text="<%# num++ %>"></asp:HyperLink>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" ReadOnly="True" SortExpression="ajusteId"
                    Visible="False" />
                  <asp:BoundField DataField="NombrePersona" HeaderText="Nombre" SortExpression="NombrePersona">
                    <ItemStyle HorizontalAlign="Left" Width="255px" />
                  </asp:BoundField>
                  <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" SortExpression="Especialidad">
                    <ItemStyle HorizontalAlign="Center" Width="255px" />
                  </asp:BoundField>
                  <asp:BoundField DataField="equipoId" HeaderText="equipoId" InsertVisible="False"
                    ReadOnly="True" SortExpression="equipoId" Visible="False" />
                  <asp:TemplateField>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                    <ItemTemplate>
                      <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("equipoId") %>'
                        CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" />
                    </ItemTemplate>
                  </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="ItemStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
                <EmptyDataTemplate>
                  No hay miembros asignados al equipo aún
                </EmptyDataTemplate>
              </asp:GridView>
              <div style="height: 20px;">
              </div>
            </div>
            <div class="hr">
            </div>
            <div>
              &nbsp;<div style="height: 20px;">
                <asp:ObjectDataSource ID="odsEquipo" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                  OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsEquipoAjusteTableAdapters.EquipoAjusteTableAdapter">
                  <DeleteParameters>
                    <asp:Parameter Name="equipoId" Type="Decimal" />
                  </DeleteParameters>
                  <SelectParameters>
                    <asp:QueryStringParameter Name="AjusteId" QueryStringField="AjusteId" />
                  </SelectParameters>
                  <InsertParameters>
                    <asp:ControlParameter ControlID="txtNombre" Name="NombrePersona" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtEspecialidad" Name="Especialidad" PropertyName="Text"
                      Type="String" />
                    <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                    <asp:SessionParameter Name="ucrea" SessionField="NombreUsuario" Type="String" />
                    <asp:SessionParameter Name="uupdate" SessionField="NombreUsuario" Type="String" />
                  </InsertParameters>
                </asp:ObjectDataSource>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                  ShowSummary="False" />
              </div>
            </div>
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
  </form>
</body>
</html>
