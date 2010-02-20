<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vInformacionRelevante.aspx.cs"
  Inherits="vInformacionRelevante" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Registro de Informacion Relevante</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>

  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" language="javascript">
		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('nuevoClausula',
						 'ContenidoClausula',						 
						 false,
						 null);
		}
		window.onload = function () {
			seteaOcultadoresDeDivs();
		}
  </script>

</head>
<body style="background-image: none; background-color: #4C96C9;">
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 699px;
    left: 0px; top: 0px; background-color: #4C96C9;">
    <form id="formRegistroClausulas" runat="server">
      <div style="position: relative;">
        <div id="ContenidoClausula" style="display: none;" runat="server">
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="DataTable">
            <tr>
              <td width="10">
                &nbsp;</td>
              <td width="120">
                &nbsp;</td>
              <td width="200">
                &nbsp;</td>
              <td width="50">
                &nbsp;</td>
              <td width="150">
                &nbsp;</td>
              <td width="222">
                &nbsp;</td>
              <td style="width: 10px">
                &nbsp;</td>
            </tr>
            <tr>
              <td width="10">
                &nbsp;</td>
              <td width="120" height="20">
                Título<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitulo"
                  ErrorMessage="Ingrese el título">(*)</asp:RequiredFieldValidator></td>
              <td width="200" height="20">
                <span style="width: 314px">
                  <asp:TextBox ID="txtTitulo" runat="server" CssClass="FormText" Width="195px"></asp:TextBox>
                </span>
              </td>
              <td width="50" height="20">
                &nbsp;</td>
              <td width="150" height="20">
                &nbsp;</td>
              <td width="222" height="20">
                &nbsp;</td>
              <td style="width: 10px">
                &nbsp;</td>
            </tr>
            <tr>
              <td>
                &nbsp;</td>
              <td width="120" height="20">
                Contenido<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                  ControlToValidate="txtDescripcion" ErrorMessage="Ingrese el contenido de la información">(*)</asp:RequiredFieldValidator></td>
              <td height="20" colspan="4">
                <span style="width: 314px">
                  <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" TextMode="MultiLine"
                    Width="500px" Height="70px"></asp:TextBox>
                </span>
              </td>
              <td style="width: 10px">
                &nbsp;</td>
            </tr>
            <tr>
              <td>
                &nbsp;</td>
              <td width="120">
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td width="50">
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
              </td>
              <td style="width: 10px">
              </td>
            </tr>
            <tr>
              <td style="height: 17px">
                &nbsp;</td>
              <td style="height: 17px">
                &nbsp;</td>
              <td style="height: 17px">
                <span style="width: 605px; height: 18px;">
                  <asp:Button ID="btnRegistrar" runat="server" CssClass="FormButton" Text="Agregar"
                    OnClick="btnRegistrar_Click" />
                </span>
              </td>
              <td style="height: 17px">
                &nbsp;</td>
              <td style="height: 17px">
                &nbsp;</td>
              <td style="height: 17px">
              </td>
              <td style="height: 17px; width: 10px;">
              </td>
            </tr>
            <tr>
              <td>
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
              </td>
              <td style="width: 10px">
              </td>
            </tr>
          </table>
        </div>
        <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;
          width: 701px; background-color: #4582bb; left: 0px; top: 0px;">
          &nbsp;&nbsp;
          <asp:Label ID="lblListaClausulas" runat="server" Font-Bold="True" Font-Size="18px">Lista de Información relevante</asp:Label>
          <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Información Relevante" title="Agregar Información Relevante"
            style="position: absolute; left: 674px; top: 5px;" id="nuevoClausula" />
        </div>
        <div id="ListaClausulas" style="margin-left: auto; margin-right: auto; position: relative">
          <div>
            <asp:GridView ID="gridInformacionRelevante" runat="server" AutoGenerateColumns="False"
              DataSourceID="odsInformacionRelevante" Width="700px" OnRowCommand="gridInformacionRelevante_RowCommand"
              CssClass="DataTable" AllowPaging="True">
              <Columns>
                <asp:TemplateField HeaderText="Nro.">
                  <ItemStyle HorizontalAlign="Center" Width="10px" />
                  <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="fcrea" HeaderText="Fecha" SortExpression="fcrea" DataFormatString="{0:MM-dd-yyyy}" />
                <asp:BoundField DataField="titulo" HeaderText="T&#237;tulo" SortExpression="titulo">
                  <ItemStyle HorizontalAlign="Center" Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="contenido" HeaderText="Contenido" SortExpression="contenido">
                  <ItemStyle HorizontalAlign="Center" Width="250px" />
                </asp:BoundField>
                <asp:TemplateField>
                  <ItemTemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" CommandArgument='<%# Bind("informacionId") %>'
                      CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" CausesValidation="False" />
                  </ItemTemplate>
                  <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="informacionId" HeaderText="informacionId" InsertVisible="False"
                  ReadOnly="True" SortExpression="informacionId" Visible="False" />
                <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" ReadOnly="True" SortExpression="ajusteId"
                  Visible="False" />
                <asp:BoundField DataField="fupdate" HeaderText="fupdate" SortExpression="fupdate"
                  Visible="False" />
                <asp:BoundField DataField="estado" HeaderText="estado" SortExpression="estado" Visible="False" />
                <asp:BoundField DataField="ucrea" HeaderText="ucrea" SortExpression="ucrea" Visible="False" />
                <asp:BoundField DataField="uupdate" HeaderText="uupdate" SortExpression="uupdate"
                  Visible="False" />
              </Columns>
              <HeaderStyle CssClass="HeaderStyle" />
            </asp:GridView>
          </div>
        </div>
      </div>
      <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" />
    </form>
  </div>
  <asp:TextBox ID="txtInformacionRelevanteId" runat="server" Visible="False" Width="64px"></asp:TextBox>
  <asp:ObjectDataSource ID="odsInformacionRelevante" runat="server" DeleteMethod="Delete"
    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
    TypeName="dsInformacionRelevanteTableAdapters.InformacionRelevanteTableAdapter">
    <DeleteParameters>
      <asp:Parameter Name="informacionId" Type="Decimal" />
    </DeleteParameters>
    <SelectParameters>
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
    </SelectParameters>
    <InsertParameters>
      <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
      <asp:ControlParameter ControlID="txtTitulo" Name="titulo" PropertyName="Text" Type="String" />
      <asp:ControlParameter ControlID="txtDescripcion" Name="contenido" PropertyName="Text"
        Type="String" />
    </InsertParameters>
  </asp:ObjectDataSource>
</body>
</html>
