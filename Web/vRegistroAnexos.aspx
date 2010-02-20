<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroAnexos.aspx.cs"
  Inherits="vRegistroAnexos" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Anexos</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" language="javascript">
		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('nuevoAnexo',
						 'ContenidoAnexo',						 
						 false,
						 null);
		}
		window.onload = function () {
			seteaOcultadoresDeDivs();
		}
		function alertaAlSubir() {
		    var mensaje = 'Los Archivos que se suben automáticamente son todos aquellos del tipo ".jpg"\n\n';		    
		    mensaje += 'Debe tener en cuenta que posteriormente a subir los archivos\n';
		    mensaje += 'estos serán borrados de esa ubicación\n\n';
		    mensaje += 'NUNCA coloque los archivos originales en este directorio!!!';
		    
		    if (confirm(mensaje)) {
		        $('loading').style.display = "block";
		        return true;
		    }
			else {
				return false;
			}
		}
		function GetBinary(url)
		{
		  window.location.href = url;
		}
  </script>

</head>
<body style="background-image: none;">
  <div style="margin-left: auto; margin-right: auto; position: relative; width: 700px;
    left: 0px; top: 0px;">
    <form id="formRegistroAnexos" runat="server">
      <div style="position: relative;">
        <div id="ContenidoAnexo" style="padding: 5px; display: none;">
          <table style="margin-top: 10px; width: 663px;" border="0" cellpadding="0" cellspacing="0"
            class="DataTable">
            <tr>
              <td width="20">
                &nbsp;</td>
              <td width="120">
                &nbsp;</td>
              <td width="200">
                &nbsp;</td>
              <td style="width: 50px">
                &nbsp;</td>
              <td width="150">
                &nbsp;</td>
              <td style="width: 164px">
                &nbsp;</td>
              <td width="20">
                &nbsp;</td>
            </tr>
            <tr>
              <td width="20" style="height: 31px">
                &nbsp;</td>
              <td width="120" style="height: 31px">
                Archivo<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="fupArchivo"
                  ErrorMessage="Especifique el Archivo" ValidationGroup="insertar">(*)</asp:RequiredFieldValidator></td>
              <td colspan="4" style="height: 31px">
                <asp:FileUpload ID="fupArchivo" runat="server" Width="402px" CssClass="FormText" />
                &nbsp;&nbsp;
              </td>
              <td width="20" style="height: 31px">
                &nbsp;</td>
            </tr>
            <tr>
              <td width="20">
                &nbsp;</td>
              <td width="120" height="20" valign="top">
                Descripci&oacute;n<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                  ControlToValidate="txtDescripcion" ErrorMessage="Ingrese una breve descripción del anexo"
                  ValidationGroup="insertar">(*)</asp:RequiredFieldValidator></td>
              <td height="20" colspan="4">
                <span style="width: 314px">
                  <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Width="397px"
                    MaxLength="200" Height="59px" TextMode="MultiLine"></asp:TextBox>
                </span>
              </td>
              <td width="20">
                &nbsp;</td>
            </tr>
            <tr>
              <td width="20" style="height: 13px">
                &nbsp;</td>
              <td width="120" style="height: 13px">
                &nbsp;</td>
              <td style="height: 13px">
                &nbsp;</td>
              <td style="width: 50px; height: 13px;">
                &nbsp;</td>
              <td style="height: 13px">
                &nbsp;</td>
              <td style="width: 164px; height: 13px;">
              </td>
              <td width="20" style="height: 13px">
              </td>
            </tr>
            <tr>
              <td width="20" style="height: 20px">
                &nbsp;</td>
              <td style="height: 20px">
                Usar Compresión</td>
              <td style="height: 20px">
                <span style="width: 605px; height: 18px;">
                  <asp:CheckBox ID="chkCompress" runat="server" /></span></td>
              <td style="width: 50px; height: 20px;">
                &nbsp;</td>
              <td colspan="2" style="height: 20px">
                &nbsp;
              </td>
              <td width="20" style="height: 20px">
              </td>
            </tr>
            <tr>
              <td width="20">
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td style="width: 50px">
                &nbsp;</td>
              <td>
                &nbsp;</td>
              <td style="width: 164px">
              </td>
              <td width="20">
              </td>
            </tr>
            <tr>
              <td width="20">
              </td>
              <td>
              </td>
              <td>
                <asp:Button ID="btnAnexar" runat="server" CssClass="FormButton" Text="Agregar" OnClick="btnAnexar_Click"
                  ValidationGroup="insertar" /></td>
              <td style="width: 50px">
              </td>
              <td>
                <asp:Button ID="btnAgregarImg" runat="server" CssClass="FormButton" OnClientClick="return alertaAlSubir();"
                  Text="Cargar en Bloque" OnClick="btnAgregarImg_Click" Width="122px" /></td>
              <td style="width: 164px">
              </td>
              <td width="20">
              </td>
            </tr>
            <tr>
              <td width="20">
              </td>
              <td>
                &nbsp;</td>
              <td>
              </td>
              <td style="width: 50px">
              </td>
              <td>
              </td>
              <td style="width: 164px">
              </td>
              <td width="20">
              </td>
            </tr>
            <tr>
              <td width="20">
              </td>
              <td>
              </td>
              <td>
              </td>
              <td style="width: 50px">
              </td>
              <td>
              </td>
              <td style="width: 164px">
              </td>
              <td width="20">
              </td>
            </tr>
          </table>
        </div>
        <div style="height: 28px; margin-top: 5px; margin-bottom: 5px; position: relative;
          width: 667px; left: 0px; top: 0px;">
          &nbsp;<asp:Label ID="lblListaAnexos" runat="server" Font-Bold="True" Font-Size="18px"
            ForeColor="White">Lista Anexos</asp:Label>&nbsp;
          <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Anexo" title="Agregar Anexo"
            style="position: absolute; left: 644px; top: 5px;" id="nuevoAnexo" />
          &nbsp;&nbsp;&nbsp;
          <asp:HyperLink onclick="return separar();" Style="position: absolute; left: 135px;
            top: 1px;" ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
            Width="22px"></asp:HyperLink>
          &nbsp;
          <div id="loading" style="display: none; width: 200px; height: 19px; position: absolute;
            left: 434px; top: 5px; color: white;">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/img/loading.gif" Style="position: absolute;
              left: 8px; top: 0px;" />
            &nbsp; &nbsp; &nbsp; &nbsp; Procesando los Archivos</div>
        </div>
        <asp:Panel Style="margin-top: 5px; padding: 10px; text-align: center; vertical-align: middle;
          background-color: Red;" ID="Panel1" runat="server" Height="1px" Width="646px" Visible="False">
          <img alt="importante" src="imgRGen/important.jpg" style="float: left;" />
          <asp:Label ID="Label1" runat="server" Text="No ha sido posible borrar los archivos, no tiene los permisos suficientes, Por favor elimine los archivos manualmente"
            Font-Bold="True" Width="530px" ForeColor="White"></asp:Label>
        </asp:Panel>
        <div id="ListaAnexos" class="DataTable" style="margin-left: auto; margin-right: auto; position: relative">
          <div>
            <asp:GridView ID="gwAnexos" runat="server" AutoGenerateColumns="False" DataKeyNames="ajusteId,archivoId"
              DataSourceID="odsAnexoEditor" OnRowCommand="gwAnexos_RowCommand" Width="667px"
              OnRowDataBound="gwAnexos_RowDataBound" CellPadding="1" OnRowUpdating="gwAnexos_RowUpdating">
              <Columns>
                <asp:TemplateField HeaderText="N&#176;">
                  <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text="<%# num++ %>"></asp:Label>
                  </ItemTemplate>
                  <ItemStyle HorizontalAlign="Center" Width="15px" />
                </asp:TemplateField>
                <asp:BoundField DataField="fechaRegistro" HeaderText="Fecha Registro" SortExpression="fechaRegistro"
                  DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" ReadOnly="True">
                  <ItemStyle HorizontalAlign="Center" Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="nombrearchivo" HeaderText="Nombre Archivo" SortExpression="nombrearchivo"
                  Visible="False" ReadOnly="True">
                  <ItemStyle Width="255px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Descripci&#243;n" SortExpression="descripcion">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Height="59px" Text='<%# Bind("descripcion") %>'
                      TextMode="MultiLine" Width="343px"></asp:TextBox>
                    <br />
                    <asp:CheckBox ID="chkMostrar" runat="server" Checked='<%# Bind("mostrarEnInformes") %>'
                      Text="Mostrar en Informes" />&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox1"
                      ErrorMessage="Ingrese una descripción" ValidationGroup="AnexoUpdateVG"></asp:RequiredFieldValidator>
                  </EditItemTemplate>
                  <ItemStyle Width="350px" />
                  <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("descripcion") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" ReadOnly="True" SortExpression="ajusteId"
                  Visible="False" />
                <asp:BoundField DataField="archivoId" HeaderText="archivoId" InsertVisible="False"
                  ReadOnly="True" SortExpression="archivoId" Visible="False" />
                <asp:TemplateField HeaderText="Descargar">
                  <ItemTemplate>
                    <div style="text-align: center;">
                      <asp:HyperLink ID="descargaHyperLink" runat="server" ForeColor="#000040" ImageUrl="~/img/files_generico.gif"
                        Width="26px">Descargar</asp:HyperLink></div>
                  </ItemTemplate>
                  <ItemStyle Width="60px" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                  <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update"
                      ImageUrl="~/imgRGen/button_ok.gif" Text="Update" ValidationGroup="AnexoUpdateVG" />&nbsp;<asp:ImageButton
                        ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                        ImageUrl="~/imgRGen/iconCancel.gif" Text="Cancel" />
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Edit"
                      ImageUrl="~/imgRGen/button_edit.gif" Text="Edit" />&nbsp;<asp:ImageButton ID="ImageButton3"
                        runat="server" CausesValidation="False" CommandArgument='<%# Bind("archivoId") %>'
                        CommandName="Eliminar" ImageUrl="~/imgRGen/button_cancel.gif" Text="Delete" />
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <HeaderStyle CssClass="HeaderStyle" />
              <RowStyle CssClass="ItemStyle" />
              <EmptyDataTemplate>
                No hay Anexos registrados
              </EmptyDataTemplate>
            </asp:GridView>
          </div>
        </div>
        <asp:ObjectDataSource ID="odsAnexoEditor" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
          OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsAnexoTableAdapters.AnexoEditorTableAdapter"
          UpdateMethod="Update" OnUpdating="odsAnexoEditor_Updating">
          <DeleteParameters>
            <asp:ControlParameter ControlID="txtAjusteId" Name="Original_ajusteId" PropertyName="Text"
              Type="Decimal" />
            <asp:ControlParameter ControlID="txtAnexoId" Name="Original_archivoId" PropertyName="Text"
              Type="Decimal" />
          </DeleteParameters>
          <SelectParameters>
            <asp:ControlParameter ControlID="txtAjusteId" Name="ajusteId" PropertyName="Text"
              Type="Decimal" />
          </SelectParameters>
          <InsertParameters>
            <asp:Parameter Name="ajusteId" Type="Decimal" />
            <asp:Parameter Name="nombrearchivo" Type="String" />
            <asp:Parameter Name="descripcion" Type="String" />
            <asp:Parameter Name="archivoFisico" Type="Object" />
            <asp:Parameter Name="imagen" Type="Boolean" />
            <asp:Parameter Name="imagenthumb" Type="Object" />
          </InsertParameters>
          <UpdateParameters>
            <asp:Parameter Name="archivoid" Type="Decimal" />
            <asp:Parameter Name="descripcion" Type="String" />
            <asp:Parameter Name="mostrarEninformes" Type="Boolean" />
            <asp:Parameter Name="original_ajusteId" Type="Decimal" />
            <asp:Parameter Name="original_archivoId" Type="Decimal" />
            <asp:Parameter Name="uupdate" Type="String" />
          </UpdateParameters>
        </asp:ObjectDataSource>
        <asp:TextBox ID="txtAjusteId" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="txtAnexoId" runat="server" Visible="False"></asp:TextBox>
        &nbsp;&nbsp; &nbsp;&nbsp;
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
          ShowSummary="False" ValidationGroup="insertar" />
      </div>
    </form>
  </div>
</body>
</html>
