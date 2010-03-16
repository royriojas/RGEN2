<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeFile="vSeccionesInformeFinal.aspx.cs"
  Inherits="vSeccionesInformeFinal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="RimacInforme/initTinyMCE.ascx" TagName="initTinyMCE" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Registro de Secciones</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <!--script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script-->

  <script language="javascript" type="text/javascript" src="./RimacInforme/scripts/jquery.js"></script>

  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-image: none; background-color: #4C96C9;">
  <form id="formRegistroClausulas" runat="server">
  <uc1:initTinyMCE ID="initTinyMCE1" runat="server" />
  <div style="margin-left: 10px; margin-right: 10px; margin-top: 10px; position: relative;
    left: 0px; top: 0px;">
    <div style="position: relative">
      <div id="SeccionNew" runat="server">
        <div style="padding: 10px;" class="DataTable">
          <table class="DataTable" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td style="width: 10%; height: 16px;">
                &nbsp; &nbsp; T&iacute;tulo
              </td>
              <td width="79%" style="height: 16px">
                <asp:TextBox ID="txtTitulo" runat="server" CssClass="FormText" Width="329px"></asp:TextBox>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Button ID="btnRegistrar" runat="server" CssClass="FormButton" OnClick="btnRegistrar_Click"
                  Text="Agregar" Width="78px" />
                &nbsp; &nbsp;&nbsp;
                <asp:Button Style="position: absolute; right: 22px; top: 11px;" ID="btnVolver" runat="server"
                  CssClass="FormButton" OnClick="btnVolver_Click" Text="Volver" />
              </td>
            </tr>
          </table>
          <div style="padding: 10px; position: relative; margin: 10px;" class="DataTable">
            <asp:TextBox CssClass="FormText tinymce-simple" Text='' TextMode="MultiLine" ID="txtDescripcion"
              runat="server"></asp:TextBox>
            <%--<FTB:FreeTextBox ID="txtDescripcion" AutoGenerateToolbarsFromString="true" runat="Server"
              Width="100%" Height="400px" Language="es-ES" SupportFolder="aspnet_client/FreeTextBox/"
              ToolbarStyleConfiguration="Office2003" ToolbarLayout="Bold, Italic, Underline,
 RemoveFormat, JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, 
 NumberedList, Indent, Outdent, Cut, Copy, Paste, Delete, Undo, Redo, Print, Save 
 ,ieSpellCheck,InsertTable, EditTable, InsertTableRowBefore, 
 InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter, 
 DeleteTableColumn" RenderMode="Rich" DownLevelRows="50">
            </FTB:FreeTextBox>--%>
          </div>
        </div>
      </div>
      <div style="height: 30px; margin-top: 15px; margin-bottom: 5px; position: relative;
        left: 0px; top: 0px;">
        <asp:Label ID="lblListaSecciones" runat="server" Font-Bold="True" Font-Size="18px">Lista de Secciones</asp:Label>&nbsp;
      </div>
      <div>
        <asp:GridView ID="gridSeccionesAjuste" runat="server" AutoGenerateColumns="False"
          CssClass="DataTable" DataKeyNames="seccionId,ajusteId" DataSourceID="odsTituloNew"
          OnRowCommand="gridInformacionRelevante_RowCommand" OnRowDataBound="gridSeccionesAjuste_RowDataBound"
          OnRowUpdating="gridSeccionesAjuste_RowUpdating" ShowHeader="False" Width="100%"
          OnRowEditing="gridSeccionesAjuste_RowEditing" OnRowUpdated="gridSeccionesAjuste_RowUpdated"
          OnRowCancelingEdit="gridSeccionesAjuste_RowCancelingEdit">
          <Columns>
            <asp:TemplateField>
              <EditItemTemplate>
                <table border="0" cellpadding="5" cellspacing="0" width="100%">
                  <tr>
                    <td colspan="2">
                      <asp:TextBox ID="txtTitulo" runat="server" CssClass="FormText" Text='<%# Bind("TituloSeccion") %>'
                        Width="320px"></asp:TextBox>&nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td colspan="2">
                      <%-- <FTB:FreeTextBox ID="txtDescripcion" runat="Server" AutoGenerateToolbarsFromString="true"
                        DownLevelRows="50" Height="300px" Language="es-ES" RenderMode="Rich" SupportFolder="aspnet_client/FreeTextBox/"
                        Text='<%# Bind("ContenidoSeccion") %>' ToolbarLayout="Bold, Italic, Underline,&#13;&#10;                                     RemoveFormat, JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, &#13;&#10;                                     NumberedList, Indent, Outdent, Cut, Copy, Paste, Delete, Undo, Redo, Print, Save &#13;&#10;                                     ,ieSpellCheck,InsertTable, EditTable, InsertTableRowBefore, &#13;&#10;                                     InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter, &#13;&#10;                                     DeleteTableColumn"
                        ToolbarStyleConfiguration="Office2003" Width="100%">
                      </FTB:FreeTextBox>--%>
                      <asp:TextBox CssClass="FormText tinymce-simple" Text='<%# Bind("ContenidoSeccion") %>'
                        TextMode="MultiLine" ID="txtDescripcion" runat="server"></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                        Text=""><img  width="19" height="19" style="border:none;" alt="" src="imgRGen/button_ok.gif" /></asp:LinkButton>
                      <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text=""><img width="19" height="19" style="border:none;" alt="" src="imgRGen/btnExitForm.jpg" /></asp:LinkButton>&nbsp;
                    </td>
                    <td align="right">
                      <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("visible") %>' Text="Visible"
                        TextAlign="Left" />
                    </td>
                  </tr>
                </table>
              </EditItemTemplate>
              <ItemTemplate>
                <table border="0" cellpadding="5" cellspacing="0" width="100%">
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
                      <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif"
                        CommandArgument='<%# Eval("seccionId") %>' />
                      <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                        Text=""><img alt="edit" style="border:0px;" src="imgRGen/button_edit.gif" width="19" height="19" /></asp:LinkButton>&nbsp;
                    </td>
                    <td align="right">
                      <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("visible") %>' Enabled="False"
                        Text="Visible" TextAlign="Left" />
                    </td>
                  </tr>
                </table>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
          <HeaderStyle CssClass="HeaderStyle" />
        </asp:GridView>
        &nbsp;<asp:ObjectDataSource ID="odsTituloNew" runat="server" DeleteMethod="Delete"
          SelectMethod="GetFinal" TypeName="dsSecInformeTableAdapters.SeccionesAdicionalesAjusteTableAdapter"
          UpdateMethod="Update">
          <DeleteParameters>
            <asp:Parameter Name="seccionId" Type="Decimal" />
          </DeleteParameters>
          <UpdateParameters>
            <asp:Parameter Name="TituloSeccion" Type="String" />
            <asp:Parameter Name="ContenidoSeccion" Type="String" />
            <asp:Parameter Name="uupdate" Type="String" />
            <asp:Parameter Name="visible" Type="Boolean" />
            <asp:Parameter Name="ajusteId" Type="Decimal" />
            <asp:Parameter Name="seccionId" Type="Decimal" />
          </UpdateParameters>
          <SelectParameters>
            <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
          </SelectParameters>
        </asp:ObjectDataSource>
      </div>
    </div>
  </div>
  <asp:ObjectDataSource ID="odsSeccionesAjuste" runat="server" DeleteMethod="Delete"
    InsertMethod="Insert" SelectMethod="GetData" TypeName="dsInformesTableAdapters.SeccionesFinalTableAdapter"
    OldValuesParameterFormatString="original_{0}" OnSelected="odsSeccionesAjuste_Selected"
    UpdateMethod="Update">
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
      <asp:Parameter Name="subtituloSeccion" Type="String" />
      <asp:ControlParameter ControlID="txtDescripcion" Name="contenidoSeccion" PropertyName="Text"
        Type="String" />
    </InsertParameters>
    <UpdateParameters>
      <asp:Parameter Name="TituloSeccion" Type="String" />
      <asp:Parameter Name="ContenidoSeccion" Type="String" />
      <asp:Parameter Name="uupdate" Type="DateTime" />
      <asp:Parameter Name="visible" Type="Boolean" />
      <asp:Parameter Name="ajusteId" Type="Decimal" />
      <asp:Parameter Name="seccionId" Type="Decimal" />
    </UpdateParameters>
  </asp:ObjectDataSource>
  &nbsp;
  </form>
</body>
</html>
