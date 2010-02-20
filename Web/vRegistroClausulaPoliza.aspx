<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroClausulaPoliza.aspx.cs"
  Inherits="vRegistroClausulaPoliza" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Cláusulas</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

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
		function muestraClausulasComunes() {
            
            showPopWin("vListaClausulasComunes.aspx?PolizaId=<%=qStringPolizaId%>", 630, 480, null);
            
	}
  </script>

</head>
<body style="background-image: none; background-color: #4C96C9;">
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 700px;
    left: 0px; top: 0px;">
    <form id="formRegistroClausulas" runat="server">
      <div id="ContenidoClausula">
        <table width="700" border="0" cellpadding="0" cellspacing="0" class="DataTable" style="width: 700px">
          <tr>
            <td width="4">
              &nbsp;</td>
            <td width="93" style="width: 93px">
              &nbsp;</td>
            <td style="width: 401px">
              &nbsp;</td>
            <td width="124">
              &nbsp;</td>
            <td width="15">
              &nbsp;</td>
          </tr>
          <tr>
            <td style="height: 25px">
              &nbsp;</td>
            <td style="width: 93px; height: 25px">
              <span style="height: 31px">Nombre</span></td>
            <td style="width: 401px; height: 25px">
              <span style="height: 31px"><span style="width: 314px">
                <asp:TextBox ID="txtNombre" runat="server" CssClass="FormText" Width="420px"></asp:TextBox>
              </span></span>
            </td>
            <td>
              &nbsp;<asp:Button ID="btnAsociarClausulas" runat="server" CssClass="FormButton" Text="Seleccionar Cláusulas"
                Width="132px" /></td>
            <td style="height: 25px">
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 93px">
              <span style="height: 31px"><span style="width: 314px"><span style="height: 89px">Cláusula</span></span></span></td>
            <td colspan="2" style="width: 556px">
              <span style="height: 89px">
                <asp:TextBox ID="txtClausulas" runat="server" CssClass="FormText" TextMode="MultiLine"
                  Width="566px" Height="90px"></asp:TextBox>
              </span>
            </td>
            <td>
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 93px">
              &nbsp;</td>
            <td colspan="2" style="width: 556px">
              &nbsp;</td>
            <td>
              &nbsp;</td>
          </tr>
          <tr>
            <td style="height: 16px">
              &nbsp;</td>
            <td style="height: 16px; width: 93px;">
              &nbsp;</td>
            <td colspan="2" style="height: 16px; width: 556px;">
              <span style="height: 17px"><span style="width: 605px; height: 18px;">
                <asp:Button ID="btnRegistrarClausula" runat="server" CssClass="FormButton" Text="Agregar"
                  OnClick="btnRegistrarClausula_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<span style="height: 31px; width: 123px;"> </span>
              </span></span>
            </td>
            <td style="height: 16px">
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 93px">
              &nbsp;</td>
            <td colspan="2" style="width: 556px">
              &nbsp;</td>
            <td>
              &nbsp;</td>
          </tr>
        </table>
      </div>
      <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;
        width: 700px; background-color: #4582bb; left: 0px; top: 0px;">
        &nbsp;
        <asp:Label ID="lblListaClausulas" runat="server" Font-Bold="True" Font-Size="18px">Lista Cl&aacute;usulas </asp:Label>
        <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Clausula" title="Agregar Cláusula"
          style="position: absolute; left: 674px; top: 7px;" id="nuevoClausula" />
      </div>
      <div id="ListaClausulas" style="margin-left: auto; margin-right: auto; position: relative">
        <div>
          <asp:GridView ID="gridClausulas" runat="server" AutoGenerateColumns="False" DataSourceID="sdsClausulasXPolizaSelect"
            OnRowCommand="gridClausulas_RowCommand" CssClass="DataTable" AllowPaging="True"
            Width="700px">
            <Columns>
              <asp:TemplateField HeaderText="N&#186;">
                <ItemStyle HorizontalAlign="Center" Width="15px" />
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="clausulasId" HeaderText="clausulasId" InsertVisible="False"
                ReadOnly="True" SortExpression="clausulasId" Visible="False" />
              <asp:BoundField DataField="polizaId" HeaderText="polizaId" ReadOnly="True" SortExpression="polizaId"
                Visible="False" />
              <asp:BoundField DataField="aseguradoraId" HeaderText="aseguradoraId" ReadOnly="True"
                SortExpression="aseguradoraId" Visible="False" />
              <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre">
                <ItemStyle Width="450px" />
              </asp:BoundField>
              <asp:BoundField DataField="contenido" HeaderText="Cl&#225;usula" SortExpression="contenido"
                Visible="False">
                <ItemStyle Width="300px" />
              </asp:BoundField>
              <asp:TemplateField>
                <ItemStyle HorizontalAlign="Center" Width="15px" />
                <ItemTemplate>
                  <asp:ImageButton ID="ImageButton2" runat="server" CommandArgument='<%# Bind("clausulasId") %>'
                    CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" CausesValidation="False" />
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="HeaderStyle" />
            <EmptyDataTemplate>
              No hay cláusulas registradas
            </EmptyDataTemplate>
          </asp:GridView>
          &nbsp;<br />
          <asp:TextBox ID="txtClausulaId" runat="server" Visible="False" Width="64px"></asp:TextBox>
          <asp:SqlDataSource ID="sdsClausulasXPolizaSelect" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
            SelectCommand="sp_rgen_ClausulasSelectById" SelectCommandType="StoredProcedure"
            DeleteCommand="sp_Rgen_ClausulasDelete" DeleteCommandType="StoredProcedure" InsertCommand="sp_rgen_ClausulasInsert"
            InsertCommandType="StoredProcedure">
            <SelectParameters>
              <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
            </SelectParameters>
            <DeleteParameters>
              <asp:Parameter Name="clausulasId" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
              <asp:ControlParameter ControlID="txtClausulaId" Direction="InputOutput" Name="ClausulasId"
                PropertyName="Text" Type="Decimal" />
              <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
              <asp:ControlParameter ControlID="txtNombre" Name="nombre" PropertyName="Text" Type="String" />
              <asp:ControlParameter ControlID="txtClausulas" Name="contenido" PropertyName="Text"
                Type="String" />
            </InsertParameters>
          </asp:SqlDataSource>
        </div>
      </div>
      &nbsp;&nbsp;
    </form>
  </div>
</body>
</html>
