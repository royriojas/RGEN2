<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vClausulasComunes.aspx.cs"
    Inherits="vClausulasComunes" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
			btn_ocultar = new CollapsibleDiv('ContenidoClausulaTrigger',
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

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; width: 880px; position: relative;
            left: 0px; top: 0px;">
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="libreria" />
            <br />
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight">
                    <div style="position: relative;">
                        <div style="height: 125px; position: relative; left: 0px; top: 0px;">
                            <asp:Label ID="lblNotificar" runat="server" Font-Size="18px" Font-Bold="True">Búsqueda de Cláusulas</asp:Label>&nbsp;
                            <div class="hr">
                            </div>
                            <div class="DataTable" style="position: relative;">
                                <asp:ImageButton Style="position: absolute; left: 458px; top: 13px;" ID="ibtnBuscar"
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
                                        </td>
                                        <td height="20" width="154">
                                        </td>
                                        <td height="20" width="250">
                                        </td>
                                        <td height="20" width="18">
                                        </td>
                                        <td height="20" width="24">
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="DataBottom" style="height: 8px" id="DIV1">
                <div class="DataBottomLeft">
                </div>
                <div class="DataBottomRight">
                </div>
            </div>
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight">
                    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="18px">Lista de Cláusulas</asp:Label>
                    <div class="hr">
                    </div>
                    <asp:GridView ID="gridClausulas" runat="server" AutoGenerateColumns="False" DataSourceID="odsClausulasComunesSelect"
                        Width="854px" CssClass="DataTable" AllowSorting="True" OnRowDataBound="gridClausulas_RowDataBound"
                        AllowPaging="True" OnRowCommand="gridClausulas_RowCommand" CellPadding="2" >
                        <Columns>
                            <asp:TemplateField HeaderText="N&#186;" Visible="False">
                                <ItemStyle Width="10px" />
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ClausulaId" HeaderText="ClausulaId" InsertVisible="False"
                                SortExpression="ClausulaId" Visible="False" />
                            <asp:TemplateField HeaderText="Cl&#225;usula" SortExpression="Nombre">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Nombre") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td style="width: 70px; padding-top: 2px;" valign="top">
                                                Ramo
                                            </td>
                                            <td style="padding-top: 2px; width: 10px;" valign="top">
                                                :</td>
                                            <td style="padding-top: 2px" valign="top">
                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Ramo") %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 70px; padding-top: 2px;" valign="top">
                                                Nombre</td>
                                            <td style="padding-top: 2px" valign="top">
                                                :</td>
                                            <td style="padding-top: 2px" valign="top">
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Nombre") %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 70px; padding-top: 2px;" valign="top">
                                                Cláusula</td>
                                            <td style="padding-top: 2px" valign="top">
                                                :</td>
                                            <td style="padding-top: 2px" valign="top">
                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("contenido") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Contenido" HeaderText="Cl&#225;usula" SortExpression="Contenido"
                                Visible="False" />
                            <asp:TemplateField HeaderText="Descargar">
                                <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemTemplate>
                                    <div align="center" style="text-align: center;">
                                        <asp:HyperLink ID="descargaHyperLink" runat="server" Font-Bold="True" ForeColor="Maroon">Descargar</asp:HyperLink>
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
                        <EmptyDataTemplate>                        
                            <div style="padding: 5px;">
                                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="12pt"
                                    Text="No hay resultados para mostrar"></asp:Label>
                                <br />
                                <asp:Label ID="Label8" runat="server" Text="No se han Encontrado Resultados con los criterios especificados, pruebe con otros criterios"></asp:Label>
                            </div>
                        </EmptyDataTemplate>
                        <EmptyDataRowStyle BorderStyle="None" BorderWidth="0px" />
                    </asp:GridView>
                    <br />
                </div>
            </div>
            <div class="DataBottom">
                <div class="DataBottomLeft">
                </div>
                <div class="DataBottomRight">
                </div>
            </div>
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight">
                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="18px">Nueva Cláusula</asp:Label>
                    <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Clausula" title="Agregar Cláusula"
                        style="position: absolute; left: 840px; top: 5px;" id="ContenidoClausulaTrigger" />
                    <div class="hr">
                    </div>
                    <div id="ContenidoClausula" class="PanelStyle" style="position: relative">
                        <div class="DataTable">
                            <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="width: 648px"
                                id="TABLE1">
                                <tr>
                                    <td style="height: 13px; width: 11px;">
                                        &nbsp;</td>
                                    <td style="height: 13px; width: 122px;">
                                        &nbsp;</td>
                                    <td width="200" style="height: 13px">
                                        &nbsp;</td>
                                    <td width="50" style="height: 13px">
                                        &nbsp;</td>
                                    <td style="width: 213px; height: 13px">
                                        &nbsp;</td>
                                    <td style="height: 13px; width: 10px;">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width: 11px; height: 30px">
                                    </td>
                                    <td style="width: 122px; height: 30px">
                                        Ramo</td>
                                    <td colspan="3" style="height: 30px">
                                        <asp:DropDownList ID="cbxRamo" runat="server" CssClass="FormSelect" DataSourceID="odsRamo"
                                            DataTextField="nombre" DataValueField="ramoId" Width="369px">
                                        </asp:DropDownList></td>
                                    <td style="height: 30px; width: 10px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 25px; width: 11px;">
                                        &nbsp;</td>
                                    <td style="height: 20px; width: 122px;">
                                        Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNombre"
                                            ErrorMessage="Ingrese el nombre de la Cláusula" ValidationGroup="NuevaClausula">(*)</asp:RequiredFieldValidator></td>
                                    <td colspan="3" style="height: 25px">
                                        <span style="width: 314px">
                                            <asp:TextBox ID="txtNombre" runat="server" CssClass="FormText" Width="366px"></asp:TextBox>
                                        </span>
                                    </td>
                                    <td style="height: 25px; width: 10px;">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="height: 76px; width: 11px;">
                                        &nbsp;</td>
                                    <td style="padding-top: 2px; width: 122px;" valign="top">
                                        Cláusula</td>
                                    <td colspan="3" style="height: 76px">
                                        <span style="width: 314px">
                                            <asp:TextBox ID="txtClausulas" runat="server" CssClass="FormText" TextMode="MultiLine"
                                                Width="365px" Height="70px"></asp:TextBox>
                                        </span>
                                    </td>
                                    <td style="height: 76px; width: 10px;">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="height: 26px; width: 11px;">
                                        &nbsp;</td>
                                    <td style="height: 26px; width: 122px;">
                                        &nbsp;Archivo<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ControlToValidate="fupArchivo" ErrorMessage="Es encesario Anexar el PDF" ValidationGroup="NuevaClausula">(*)</asp:RequiredFieldValidator></td>
                                    <td colspan="3" style="height: 26px">
                                        <asp:FileUpload ID="fupArchivo" runat="server" CssClass="FormText" Width="366px" />&nbsp;</td>
                                    <td style="height: 26px; width: 10px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 11px">
                                    </td>
                                    <td style="width: 122px; height: 20px">
                                    </td>
                                    <td>
                                    </td>
                                    <td width="50">
                                    </td>
                                    <td style="width: 213px">
                                    </td>
                                    <td style="width: 10px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 17px; width: 11px;">
                                        &nbsp;</td>
                                    <td style="height: 20px; width: 122px;">
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
                                    <td style="height: 17px; width: 10px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 4px; width: 11px;">
                                        &nbsp;</td>
                                    <td style="height: 4px; width: 122px;">
                                        &nbsp;</td>
                                    <td style="height: 4px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 4px">
                                        &nbsp;</td>
                                    <td style="width: 213px; height: 4px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 4px; width: 10px;">
                                    </td>
                                </tr>
                            </table>
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
                </div>
            </div>
            <div class="DataBottom">
                <div class="DataBottomLeft">
                </div>
                <div class="DataBottomRight">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
