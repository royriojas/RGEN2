<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeFile="vSeccionesAdicionales.aspx.cs"
  Inherits="vSeccionesAdicionales" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
  <title>Registro de Secciones</title>
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
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 635px;
    left: 0px; top: 0px;">
    <form id="formRegistroClausulas" runat="server">
      <div style="position: relative">
        <div id="ContenidoClausula" runat="server">
          <table width="635" border="0" cellpadding="0" cellspacing="0" class="DataTable">
            <tr>
              <td width="10">
                &nbsp;</td>
              <td style="width: 23px">
                &nbsp;</td>
              <td width="200">
                &nbsp;</td>
              <td width="50">
                &nbsp;</td>
              <td width="150">
                &nbsp;</td>
              <td width="222">
                &nbsp;</td>
              <td>
                &nbsp;</td>
            </tr>
            <tr>
              <td width="10" style="height: 20px">
                &nbsp;</td>
              <td style="height: 20px; width: 23px;">
              </td>
              <td width="200" style="height: 20px">
                <span style="width: 314px">&nbsp;Título</span></td>
              <td style="height: 20px" colspan="3">
                &nbsp;&nbsp;
                <asp:TextBox ID="txtTitulo" runat="server" CssClass="FormText" Width="320px"></asp:TextBox></td>
              <td style="height: 20px">
                &nbsp;</td>
            </tr>
            <tr>
              <td style="height: 20px" width="10">
              </td>
              <td style="height: 20px; width: 23px;">
              </td>
              <td style="height: 20px" width="200">
                Contenido</td>
              <td style="height: 20px" width="50">
              </td>
              <td colspan="2" style="height: 20px">
              </td>
              <td style="height: 20px">
              </td>
            </tr>
            <tr>
              <td>
                &nbsp;</td>
              <td height="20" style="width: 23px">
              </td>
              <td height="20" colspan="4">
                <span style="width: 314px">
                  <FTB:FreeTextBox HtmlModeCssClass="CssClassForTextBox" ID="txtDescripcion" AutoGenerateToolbarsFromString="true"
                    runat="Server" Width="550px" Height="300px" Language="es-ES" SupportFolder="aspnet_client/FreeTextBox/"   ToolbarLayout="Bold, Italic, Underline,
 RemoveFormat, JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, 
 NumberedList, Indent, Outdent, Cut, Copy, Paste, Delete, Undo, Redo, Print, Save 
 ,ieSpellCheck,InsertTable, EditTable, InsertTableRowBefore, 
 InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter, 
 DeleteTableColumn"
                    RenderMode="Rich" DownLevelRows="50">
                  </FTB:FreeTextBox>
                </span>
              </td>
              <td>
                &nbsp;</td>
            </tr>
            <tr>
              <td style="height: 13px">
                &nbsp;</td>
              <td style="height: 13px; width: 23px;">
                &nbsp;</td>
              <td style="height: 13px">
                &nbsp;</td>
              <td width="50" style="height: 13px">
                &nbsp;</td>
              <td style="height: 13px">
                &nbsp;</td>
              <td style="height: 13px">
              </td>
              <td style="height: 13px">
              </td>
            </tr>
            <tr>
              <td style="height: 17px">
                &nbsp;</td>
              <td style="height: 17px; width: 23px;">
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
              </td>
              <td style="height: 17px">
              </td>
              <td style="height: 17px">
              </td>
            </tr>
            <tr>
              <td>
                &nbsp;</td>
              <td style="width: 23px">
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
              </td>
              <td>
              </td>
            </tr>
          </table>
        </div>
        <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;
          background-color: #2d7eb3;">
          &nbsp;
          <asp:Label ID="lblListaSecciones" runat="server" Font-Bold="True" Font-Size="18px">Lista de Secciones</asp:Label>
          <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Clausula" title="Agregar Cláusula"
            style="position: absolute; left: 606px; top: 5px; z-index: 100;" id="nuevoClausula" />
          <asp:Button ID="Button1" runat="server" CssClass="FormButton" OnClick="Button1_Click"
            Style="z-index: 102; left: 528px; position: absolute; top: 6px" Text="Volver" />
        </div>
        <div id="ListaClausulas" style="margin-left: auto; margin-right: auto; position: relative">
          <div>
            <asp:GridView ID="gridSeccionesAjuste" runat="server" AutoGenerateColumns="False"
              DataSourceID="odsSeccionesAjuste" Width="636px" OnRowCommand="gridInformacionRelevante_RowCommand"
              CssClass="DataTable" ShowHeader="False" DataKeyNames="seccionId" OnRowUpdating="gridSeccionesAjuste_RowUpdating"
              OnRowDataBound="gridSeccionesAjuste_RowDataBound" OnRowUpdated="gridSeccionesAjuste_RowUpdated"
              OnRowCancelingEdit="gridSeccionesAjuste_RowCancelingEdit" OnRowEditing="gridSeccionesAjuste_RowEditing">
              <Columns>
                <asp:TemplateField>
                  <ItemTemplate>
                    <table border="0" cellpadding="5" cellspacing="0">
                      <tr>
                        <td colspan="2">
                          <h2>
                            <asp:Label ID="titulo" runat="server" Text='<%# Eval("TituloSeccion") %>'></asp:Label>&nbsp;</h2>
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2">
                          <div>
                            <asp:Literal ID="contenido" runat="server" Text='<%# Eval("ContenidoSeccion") %>'></asp:Literal>
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Delete" ImageUrl="~/imgRGen/deleteItem.gif" />
                          <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                            Text=""><img alt="edit" style="border:0px;" src="imgRGen/button_edit.gif" width="19" height="19" /></asp:LinkButton>&nbsp;
                        </td>
                        <td align="right">
                          <asp:CheckBox ID="CheckBox2" Text="Visible" TextAlign="Left" runat="server" Checked='<%# Bind("visible") %>'
                            Enabled="False" /></td>
                      </tr>
                    </table>
                  </ItemTemplate>
                  <EditItemTemplate>
                    <table border="0" cellpadding="5" cellspacing="0">
                      <tr>
                        <td colspan="2">
                          <asp:TextBox ID="txtTitulo" runat="server" Text='<%# Bind("TituloSeccion") %>' CssClass="FormText"
                            Width="320px"></asp:TextBox>&nbsp;
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2">
                          <FTB:FreeTextBox ID="txtDescripcion" Text='<%# Bind("ContenidoSeccion") %>' AutoGenerateToolbarsFromString="true"
                            runat="Server" Height="300px" Language="es-ES" SupportFolder="aspnet_client/FreeTextBox/"     ToolbarLayout="Bold, Italic, Underline,
 RemoveFormat, JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, 
 NumberedList, Indent, Outdent, Cut, Copy, Paste, Delete, Undo, Redo, Print, Save 
 ,ieSpellCheck,InsertTable, EditTable, InsertTableRowBefore, 
 InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter, 
 DeleteTableColumn"
                            ToolbarStyleConfiguration="Office2003" 
                            RenderMode="Rich" DownLevelRows="50">
                          </FTB:FreeTextBox>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                            Text=""><img  width="19" height="19" style="border:none;" alt="" src="imgRGen/button_ok.gif" /></asp:LinkButton>
                          <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text=""><img width="19" height="19" style="border:none;" alt="" src="imgRGen/btnExitForm.jpg" /></asp:LinkButton>&nbsp;&nbsp;
                          &nbsp; &nbsp;
                        </td>
                        <td align="right">
                          <asp:CheckBox ID="CheckBox1" Text="Visible" TextAlign="Left" runat="server" Checked='<%# Bind("visible") %>' /></td>
                      </tr>
                    </table>
                  </EditItemTemplate>
                </asp:TemplateField>
              </Columns>
              <HeaderStyle CssClass="HeaderStyle" />
              <EmptyDataTemplate>
                No hay Secciones Registradas
              </EmptyDataTemplate>
            </asp:GridView>
            <br />
          </div>
        </div>
      </div>
    </form>
  </div>
  <asp:ObjectDataSource ID="odsSeccionesAjuste" runat="server" DeleteMethod="Delete"
    InsertMethod="Insert" SelectMethod="GetData" TypeName="dsInformesTableAdapters.SeccionesAjusteTableAdapter"
    OldValuesParameterFormatString="{0}" UpdateMethod="Update">
    <DeleteParameters>
      <asp:Parameter Name="seccionId" Type="Decimal" />
    </DeleteParameters>
    <SelectParameters>
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
    </SelectParameters>
    <InsertParameters>
      <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
      <asp:ControlParameter ControlID="txtTitulo" Name="tituloSeccion" PropertyName="Text"
        Type="String" />
      <asp:ControlParameter ControlID="txtDescripcion" Name="contenidoSeccion" PropertyName="Text"
        Type="String" />
    </InsertParameters>
    <UpdateParameters>
      <asp:Parameter Name="seccionId" Type="Decimal" />
      <asp:Parameter Name="TituloSeccion" Type="String" />
      <asp:Parameter Name="ContenidoSeccion" Type="String" />
      <asp:Parameter Name="uupdate" Type="String" />
      <asp:Parameter Name="visible" Type="Boolean" />
    </UpdateParameters>
  </asp:ObjectDataSource>
</body>
</html>
