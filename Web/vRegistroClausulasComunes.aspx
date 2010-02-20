<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroClausulasComunes.aspx.cs"
    Inherits="vRegistroClausulasComunes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cláusulas</title>
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
		function muestraClausulasComunes() {
            
            showPopWin("vListaClausulasComunes.aspx?PolizaId=", 620, 480, null);
            
	}
	function GetBinaryClausula(url)
		{
		  window.location.href = url;
		}
    </script>

</head>
<body style="background-image: none; background-color: #2d7eb3;">
    <div style="margin-left: auto; margin-right: auto; position: relative; width: 635px;
        left: 0px; top: 0px;">
        <form id="formRegistroClausulas" runat="server">
            <div style="position: relative">
                <div id="ContenidoClausula">
                    <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="width: 648px">
                        <tr>
                            <td style="height: 13px; width: 59px;">
                                &nbsp;</td>
                            <td style="height: 13px; width: 347px;">
                                &nbsp;</td>
                            <td width="200" style="height: 13px">
                                &nbsp;</td>
                            <td width="50" style="height: 13px">
                                &nbsp;</td>
                            <td style="width: 213px; height: 13px">
                                &nbsp;</td>
                            <td width="222" style="height: 13px">
                                &nbsp;</td>
                            <td width="10" style="height: 13px">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 59px; height: 22px">
                            </td>
                            <td style="width: 347px; height: 20px">
                                Ramo</td>
                            <td colspan="3" style="height: 22px">
                                <asp:DropDownList ID="cbxRamo" runat="server" CssClass="FormSelect" DataSourceID="odsRamo"
                                    DataTextField="nombre" DataValueField="ramoId" Width="369px">
                                </asp:DropDownList></td>
                            <td width="222" style="height: 22px">
                            </td>
                            <td width="10" style="height: 22px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 25px; width: 59px;">
                                &nbsp;</td>
                            <td style="height: 20px; width: 347px;">
                                Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNombre"
                                    ErrorMessage="Ingrese el nombre de la Cláusula" ValidationGroup="NuevaClausula">(*)</asp:RequiredFieldValidator></td>
                            <td colspan="3" style="height: 25px">
                                <span style="width: 314px">
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="FormText" Width="366px"></asp:TextBox>
                                </span>
                            </td>
                            <td width="222" style="height: 25px">
                                &nbsp;</td>
                            <td width="10" style="height: 25px">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="height: 76px; width: 59px;">
                                &nbsp;</td>
                            <td style="height: 20px; width: 347px;">
                                Cláusula</td>
                            <td colspan="4" style="height: 76px">
                                <span style="width: 314px">
                                    <asp:TextBox ID="txtClausulas" runat="server" CssClass="FormText" TextMode="MultiLine"
                                        Width="365px" Height="70px"></asp:TextBox>
                                </span>
                            </td>
                            <td style="height: 76px">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td style="height: 26px; width: 59px;">
                                &nbsp;</td>
                            <td style="height: 26px; width: 347px;">
                                &nbsp;Archivo<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="fupArchivo" ErrorMessage="Es encesario Anexar el PDF" ValidationGroup="NuevaClausula">(*)</asp:RequiredFieldValidator></td>
                            <td colspan="4" style="height: 26px">
                                <asp:FileUpload ID="fupArchivo" runat="server" CssClass="FormText" Width="366px" />&nbsp;</td>
                            <td style="height: 26px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 59px">
                            </td>
                            <td style="width: 347px; height: 20px">
                            </td>
                            <td>
                            </td>
                            <td width="50">
                            </td>
                            <td style="width: 213px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 17px; width: 59px;">
                                &nbsp;</td>
                            <td style="height: 20px; width: 347px;">
                                &nbsp;</td>
                            <td style="height: 17px">
                                <span style="width: 605px; height: 18px;">
                                    <asp:Button ID="btnRegistrarClausula" runat="server" CssClass="FormButton" Text="Agregar"
                                        OnClick="btnRegistrarClausula_Click" ValidationGroup="NuevaClausula" />
                                </span>
                            </td>
                            <td style="height: 17px">
                                &nbsp;</td>
                            <td style="height: 17px; width: 213px;">
                                &nbsp;</td>
                            <td style="height: 17px">
                            </td>
                            <td style="height: 17px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 4px; width: 59px;">
                                &nbsp;</td>
                            <td style="height: 4px; width: 347px;">
                                &nbsp;</td>
                            <td style="height: 4px">
                                &nbsp;
                            </td>
                            <td style="height: 4px">
                                &nbsp;</td>
                            <td style="width: 213px; height: 4px">
                                &nbsp;
                            </td>
                            <td style="height: 4px">
                            </td>
                            <td style="height: 4px">
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;
                    left: 0px; width: 650px; top: 0px;">
                    <asp:Label ID="lblBusqueda" runat="server" Font-Bold="True" Font-Size="18px">Búsqueda </asp:Label>
                    <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Clausula" title="Agregar Cláusula"
                        style="position: absolute; left: 630px; top: 5px;" id="nuevoClausula" />
                </div>
                <div style="width: 648px; height: 85px; position: relative;">
                    <div class="DataTable" style="position: relative;">
                        <asp:ImageButton Style="position: absolute; left: 455px; top: 15px;" ID="ibtnBuscar"
                            runat="server" ImageUrl="~/imgRGen/btnBuscar2.gif" TabIndex="17" />
                        <table width="450" border="0" cellspacing="0" cellpadding="0" class="DataTable">
                            <tr>
                                <td style="height: 13px; width: 23px;">
                                    &nbsp;</td>
                                <td width="154" style="height: 13px">
                                    &nbsp;</td>
                                <td width="250" style="height: 13px">
                                    <span style="width: 182px; height: 12px">&nbsp;</span></td>
                                <td width="18" style="height: 13px">
                                    &nbsp;</td>
                                <td width="24" style="height: 13px">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td style="width: 23px; height: 20px;">
                                    &nbsp;</td>
                                <td width="154" style="height: 20px">
                                    <span style="width: 119px; height: 24px;">Nombre</span></td>
                                <td width="250" style="height: 20px">
                                    <span style="width: 57px; height: 24px;">
                                        <asp:TextBox ID="TxtNombreFiltro" runat="server" CssClass="FormText" Width="203px"></asp:TextBox></span></td>
                                <td width="18" style="height: 20px">
                                    &nbsp;</td>
                                <td width="24" style="height: 20px">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td height="20" style="width: 23px">
                                    &nbsp;</td>
                                <td width="154" height="20">
                                    Ramo</td>
                                <td width="250" height="20">
                                    <span style="width: 57px; height: 24px;">
                                        <asp:DropDownList ID="cbxRamoFiltro" runat="server" CssClass="FormSelect" DataSourceID="odsRamo"
                                            DataTextField="nombre" DataValueField="ramoId" Width="206px" OnDataBound="cbxRamoFiltro_DataBound">
                                        </asp:DropDownList></span></td>
                                <td width="18" height="20">
                                    &nbsp;</td>
                                <td width="24" height="20">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td height="20" style="width: 23px">
                                    &nbsp;</td>
                                <td width="154" height="20">
                                    <span style="width: 128px; height: 24px;"></span>
                                </td>
                                <td width="250" height="20">
                                    <span style="width: 158px; height: 24px;">&nbsp;</span></td>
                                <td width="18" height="20">
                                    &nbsp;</td>
                                <td width="24" height="20">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td style="width: 23px">
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;
                    left: 0px; width: 632px; top: 0px;">
                    <asp:Label ID="lblListaClausulas" runat="server" Font-Bold="True" Font-Size="18px">Lista Cl&aacute;usulas </asp:Label>
                </div>
                <div id="ListaClausulas" style="margin-left: auto; margin-right: auto; position: relative">
                    <div>
                        <asp:GridView ID="gridClausulas" runat="server" AutoGenerateColumns="False" DataSourceID="odsClausulasComunesSelect"
                            Width="651px" CssClass="DataTable" AllowSorting="True" OnRowDataBound="gridClausulas_RowDataBound"
                            AllowPaging="True" OnRowCommand="gridClausulas_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="N&#186;" Visible="False">
                                    <ItemStyle Width="10px" />
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ClausulaId" HeaderText="ClausulaId" InsertVisible="False"
                                    SortExpression="ClausulaId" Visible="False" />
                                <asp:BoundField DataField="Ramo" HeaderText="Ramo" SortExpression="Ramo">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                                    <ItemStyle Width="255px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Contenido" HeaderText="Cl&#225;usula" SortExpression="Contenido"
                                    Visible="False" />
                                <asp:TemplateField HeaderText="Descargar">
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <div align="center" style="text-align:center;">
                                            <asp:HyperLink ID="descargaHyperLink" runat="server">Descargar</asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandArgument='<%# Bind("clausulaId") %>'
                                            CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" CausesValidation="False" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="HeaderStyle" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="NuevaClausula" />
            <asp:TextBox ID="txtClausulaId" runat="server" Visible="False" Width="64px"></asp:TextBox>
            &nbsp; &nbsp;&nbsp;&nbsp;
            <asp:ObjectDataSource ID="odsRamo" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsComboTableAdapters.RamoComboTableAdapter"></asp:ObjectDataSource>
            <asp:HiddenField ID="nombreArchivoHiddenField" runat="server" />
            <asp:ObjectDataSource ID="odsClausulasComunesSelect" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsClausulasComunesTableAdapters.ClausulasComunesListaFiltrosTableAdapter">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TxtNombreFiltro" Name="nombre" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="cbxRamoFiltro" Name="IdRamo" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            &nbsp;
            <asp:ObjectDataSource ID="odsClausulasComunesInsert" runat="server" InsertMethod="Insert"
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsClausulasComunesTableAdapters.ClausulasComunesTableAdapter"
                DeleteMethod="Delete">
                <InsertParameters>
                    <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
                        Type="Decimal" />
                    <asp:ControlParameter ControlID="txtNombre" Name="nombre" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtClausulas" Name="contenido" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="fupArchivo" Name="archivo" PropertyName="FileBytes"
                        Type="Object" />
                    <asp:ControlParameter ControlID="nombreArchivoHiddenField" Name="nombreArchivo" PropertyName="Value"
                        Type="String" />
                </InsertParameters>
                <DeleteParameters>
                    <asp:Parameter Name="clausulaId" Type="Decimal" />
                </DeleteParameters>
            </asp:ObjectDataSource>
        </form>
    </div>
</body>
</html>
