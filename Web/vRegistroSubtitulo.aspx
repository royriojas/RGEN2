<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroSubtitulo.aspx.cs"
  ValidateRequest="false" Inherits="vRegistroSubtitulo" %>

<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
  <title>Registro de Secciones</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript">
    if(<%=deboCerrar %>)
    {
      window.top.hidePopWin(true);
      var registroFinal = window.top.frames['ifrmInformeFinal'];
      var seccionFinal  = registroFinal.frames['iframeSeccionesAdicionales'];
      registroFinal.reload();
      seccionFinal.document.location.href = "vSeccionesInformeFinal.aspx?AjusteId=<%=AjusteId %>";
    }
  </script>

  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-image: none; background-color: #4C96C9;">
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 590px;
    left: 0px; top: 0px;">
    <form id="formRegistroClausulas" runat="server">
      <div style="position: relative">
        <div id="ContenidoClausula">
          <asp:FormView ID="FormView1" runat="server" DataKeyNames="ajusteId,seccionId" DataSourceID="SqlDataSource1"
            DefaultMode="Insert" OnItemInserted="FormView1_ItemInserted">
            <InsertItemTemplate>
              <table width="635" border="0" cellpadding="0" cellspacing="0" class="DataTable">
                <tr>
                  <td width="10">
                    &nbsp;</td>
                  <td width="200" style="width: 100px">
                    &nbsp;</td>
                  <td width="50">
                    &nbsp;</td>
                </tr>
                <tr>
                  <td width="10" style="height: 20px">
                    &nbsp;</td>
                  <td width="200" style="height: 20px">
                    <span>Título</span></td>
                  <td style="height: 20px" colspan="1">
                    <asp:TextBox ID="txtTitulo" runat="server" CssClass="FormText" Width="329px" Text='<%# Bind("TituloSeccion") %>'></asp:TextBox></td>
                </tr>
                <tr>
                  <td style="height: 20px" width="10">
                  </td>
                  <td style="height: 20px" width="200">
                    Contenido</td>
                  <td style="height: 20px" width="50">
                  </td>
                </tr>
                <tr>
                  <td>
                    &nbsp;</td>
                  <td height="20" colspan="2">
                    <span>
                      <FTB:FreeTextBox ID="txtDescripcion" AutoGenerateToolbarsFromString="True" runat="Server"
                        Width="600px" Height="250px" Language="es-ES" SupportFolder="aspnet_client/FreeTextBox/"
                        ToolbarStyleConfiguration="Office2003" ToolbarLayout="Bold, Italic, Underline,&#13;&#10; RemoveFormat, JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, &#13;&#10; NumberedList, Indent, Outdent, Cut, Copy, Paste, Delete, Undo, Redo, Print, Save &#13;&#10; ,ieSpellCheck,InsertTable, EditTable, InsertTableRowBefore, &#13;&#10; InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter, &#13;&#10; DeleteTableColumn" RenderMode="Rich" DownLevelRows="50" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                        AutoConfigure="" AutoHideToolbar="True" AutoParseStyles="True" BackColor="158, 190, 245"
                        BaseUrl="" BreakMode="Paragraph" ButtonDownImage="False" ButtonFileExtention="gif"
                        ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource"
                        ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged=""
                        ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass="" DesignModeCss=""
                        DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea"
                        EditorBorderColorDark="128, 128, 128" EditorBorderColorLight="128, 128, 128" EnableHtmlMode="True"
                        EnableSsl="False" EnableToolbars="True" Focus="False" FormatHtmlTagsToXhtml="True"
                        GutterBackColor="129, 169, 226" GutterBorderColorDark="128, 128, 128" GutterBorderColorLight="255, 255, 255"
                        HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True"
                        ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}"
                        InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource"
                        PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True"
                        ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode" StripAllScripting="False"
                        TabIndex="-1" TabMode="InsertSpaces" Text='<%# Bind("ContenidoSeccion") %>' TextDirection="LeftToRight"
                        ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                        UpdateToolbar="True" UseToolbarBackGroundImage="True">
                      </FTB:FreeTextBox>
                    </span>
                  </td>
                </tr>
                <tr>
                  <td style="height: 13px">
                    &nbsp;</td>
                  <td style="height: 13px">
                    &nbsp;<asp:Button ID="btnRegistrar" runat="server" CssClass="FormButton" Text="Agregar"
                      CommandName="Insert" /></td>
                  <td width="50" style="text-align: right;">
                  </td>
                </tr>
                <tr>
                  <td style="height: 17px">
                    &nbsp;</td>
                  <td style="height: 17px">
                    <span style="height: 18px;">&nbsp;</span></td>
                  <td style="height: 17px">
                    &nbsp;</td>
                </tr>
              </table>
            </InsertItemTemplate>
          </asp:FormView>
        </div>
      </div>
    </form>
  </div>
  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
    InsertCommand="sp_rgen_SeccionesSubtituloInsert" InsertCommandType="StoredProcedure"
    SelectCommand="SELECT seccionPadreId, TituloSeccion, SubtituloSeccion, ContenidoSeccion, ajusteId, uupdate, seccionId FROM RGN_SECCIONESAJUSTE WHERE (seccionId = @seccionId) AND (ajusteId = @ajusteid)">
    <SelectParameters>
      <asp:QueryStringParameter Name="seccionId" QueryStringField="sid" />
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" />
    </SelectParameters>
    <InsertParameters>
      <asp:SessionParameter Name="usuario" SessionField="usuario" Type="String" />
      <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
      <asp:Parameter Name="tituloSeccion" Type="String" />
      <asp:Parameter Name="subtituloSeccion" Type="String" />
      <asp:Parameter Name="contenidoSeccion" Type="String" />
      <asp:QueryStringParameter Name="seccionPadreid" QueryStringField="sid" Type="Decimal" />
    </InsertParameters>
  </asp:SqlDataSource>
</body>
</html>
