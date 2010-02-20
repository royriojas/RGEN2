<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroClausula.aspx.cs"
  Inherits="vRegistroClausula" %>

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
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 680px;
    left: 0px; top: 0px;">
    <form id="formRegistroClausulas" runat="server">
      <div id="ContenidoClausula" style="display: none;">
        <table class="DataTable" border="0" cellspacing="0" cellpadding="0" style="width: 676px">
          <tr>
            <td width="16">
              &nbsp;</td>
            <td style="width: 120px">
              &nbsp;</td>
            <td style="width: 480px">
              &nbsp;</td>
            <td style="width: 18px">
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 120px">
              <span style="height: 31px">Nombre</span></td>
            <td style="width: 480px">
              <span style="height: 31px"><span style="width: 314px">
                <asp:TextBox ID="txtNombre" runat="server" CssClass="FormText" Width="350px"></asp:TextBox>
                <asp:Button ID="btnAsociarClausulas" runat="server" CssClass="FormButton" Text="Seleccionar Cláusulas"
                  OnClick="btnAsociarClausulas_Click" Width="133px" /></span></span></td>
            <td style="width: 18px">
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 120px">
              <span style="height: 31px"><span style="width: 314px"><span style="height: 89px">Cláusula</span></span></span></td>
            <td style="width: 480px">
              <span style="height: 89px">
                <asp:TextBox ID="txtClausulas" runat="server" CssClass="FormText" TextMode="MultiLine"
                  Width="487px" Height="90px"></asp:TextBox>
              </span>
            </td>
            <td style="width: 18px">
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 120px">
              &nbsp;</td>
            <td style="width: 480px">
              &nbsp;</td>
            <td style="width: 18px">
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 120px">
              &nbsp;</td>
            <td style="width: 480px">
              <span style="height: 17px"><span style="width: 605px; height: 18px;">
                <asp:Button ID="btnRegistrarClausula" runat="server" CssClass="FormButton" Text="Agregar"
                  OnClick="btnRegistrarClausula_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<span style="height: 31px; width: 123px;"> </span>
              </span></span>
            </td>
            <td style="width: 18px">
              &nbsp;</td>
          </tr>
          <tr>
            <td>
              &nbsp;</td>
            <td style="width: 120px">
              &nbsp;</td>
            <td style="width: 480px">
              &nbsp;</td>
            <td style="width: 18px">
              &nbsp;</td>
          </tr>
        </table>
      </div>
      <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;
        background-color: #4582bb;">
        &nbsp;
        <asp:Label ID="lblListaClausulas" runat="server" Font-Bold="True" Font-Size="18px">Lista Cl&aacute;usulas </asp:Label>
        <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Clausula" title="Agregar Cláusula"
          style="position: absolute; left: 658px; top: 5px;" id="nuevoClausula" />
      </div>
      <div id="ListaClausulas" style="margin-left: auto; margin-right: auto; position: relative">
        <div>
          <asp:GridView ID="gridClausulas" runat="server" AutoGenerateColumns="False" DataSourceID="sdsClausulasXPolizaSelect"
            OnRowCommand="gridClausulas_RowCommand" CssClass="DataTable" AllowPaging="True"
            Width="677px" OnRowDataBound="gridClausulas_RowDataBound" OnDataBound="gridClausulas_DataBound">
            <Columns>
              <asp:TemplateField HeaderText="N&#186;">
                <ItemStyle Width="10px" />
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
                <ItemStyle Width="300px" />
              </asp:BoundField>
              <asp:BoundField DataField="contenido" HeaderText="Cl&#225;usula" SortExpression="contenido"
                Visible="False">
                <ItemStyle Width="300px" />
              </asp:BoundField>
              <asp:TemplateField HeaderText="Visible">
                <ItemStyle HorizontalAlign="Center" Width="10px" />
                <ItemTemplate>
                  <asp:CheckBox ID="CheckClausula" runat="server" />
                  <asp:Label ID="lblClausula" runat="server" Style="display: none;" Text='<%# Eval("clausulasId") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField>
                <ItemTemplate>
                  <asp:ImageButton ID="ImageButton2" runat="server" CommandArgument='<%# Bind("clausulasId") %>'
                    CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" CausesValidation="False" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="20px" />
              </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="HeaderStyle" />
            <EmptyDataTemplate>
              No hay clausulas registradas
            </EmptyDataTemplate>
          </asp:GridView>
          <br />
          <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/imgRGen/btnSave.gif"
            OnClick="btnGuardar_Click" TabIndex="26" ToolTip="Insertar en el Ajuste" />
          <asp:TextBox ID="txtClausulaId" runat="server" Visible="False" Width="64px"></asp:TextBox>
          <asp:SqlDataSource ID="sdsClausulasXPolizaSelect" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
            SelectCommand="sp_rgen_ClausulasSelectById" SelectCommandType="StoredProcedure"
            DeleteCommand="sp_Rgen_ClausulasDelete" DeleteCommandType="StoredProcedure" InsertCommand="sp_rgen_ClausulasInsert"
            InsertCommandType="StoredProcedure">
            <SelectParameters>
              <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" />
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
      <asp:ObjectDataSource ID="odsInsertClausulasAjuste" runat="server" InsertMethod="Insert"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPolizaTableAdapters.ClausulasAjusteTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
      &nbsp;
    </form>
  </div>
</body>
</html>
