<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroActividades.aspx.cs"
  Inherits="vRegistroActividades" %>

<%@ Register TagPrefix="Custom" Namespace="ASB" Assembly="AutoSuggestBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title></title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/calendar/calendar.js"></script>

  <link rel="stylesheet" type="text/css" href="Scripts/calendar/calendar-blue2.css" />

  <script type="text/javascript">
	// ** I18N

// Calendar ES (spanish) language
// Author: Mihai Bazon, <mihai_bazon@yahoo.com>
// Updater: Servilio Afre Puentes <servilios@yahoo.com>
// Updated: 2004-06-03
// Encoding: utf-8
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.

// full day names
Calendar._DN = new Array
("Domingo",
 "Lunes",
 "Martes",
 "Miércoles",
 "Jueves",
 "Viernes",
 "Sábado",
 "Domingo");

// Please note that the following array of short day names (and the same goes
// for short month names, _SMN) isn't absolutely necessary.  We give it here
// for exemplification on how one can customize the short day names, but if
// they are simply the first N letters of the full name you can simply say:
//
//   Calendar._SDN_len = N; // short day name length
//   Calendar._SMN_len = N; // short month name length
//
// If N = 3 then this is not needed either since we assume a value of 3 if not
// present, to be compatible with translation files that were written before
// this feature.

// short day names
Calendar._SDN = new Array
("Dom",
 "Lun",
 "Mar",
 "Mié",
 "Jue",
 "Vie",
 "Sáb",
 "Dom");

// First day of the week. "0" means display Sunday first, "1" means display
// Monday first, etc.
Calendar._FD = 1;

// full month names
Calendar._MN = new Array
("Enero",
 "Febrero",
 "Marzo",
 "Abril",
 "Mayo",
 "Junio",
 "Julio",
 "Agosto",
 "Septiembre",
 "Octubre",
 "Noviembre",
 "Diciembre");

// short month names
Calendar._SMN = new Array
("Ene",
 "Feb",
 "Mar",
 "Abr",
 "May",
 "Jun",
 "Jul",
 "Ago",
 "Sep",
 "Oct",
 "Nov",
 "Dic");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "Acerca del calendario";

Calendar._TT["ABOUT"] =
"Selector DHTML de Fecha/Hora\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"Para conseguir la última versión visite: http://www.dynarch.com/projects/calendar/\n" +
"Distribuido bajo licencia GNU LGPL. Visite http://gnu.org/licenses/lgpl.html para más detalles." +
"\n\n" +
"Selección de fecha:\n" +
"- Use los botones \xab, \xbb para seleccionar el año\n" +
"- Use los botones " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " para seleccionar el mes\n" +
"- Mantenga pulsado el ratón en cualquiera de estos botones para una selección rápida.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"Selección de hora:\n" +
"- Pulse en cualquiera de las partes de la hora para incrementarla\n" +
"- o pulse las mayúsculas mientras hace clic para decrementarla\n" +
"- o haga clic y arrastre el ratón para una selección más rápida.";

Calendar._TT["PREV_YEAR"] = "Año anterior (mantener para menú)";
Calendar._TT["PREV_MONTH"] = "Mes anterior (mantener para menú)";
Calendar._TT["GO_TODAY"] = "Ir a hoy";
Calendar._TT["NEXT_MONTH"] = "Mes siguiente (mantener para menú)";
Calendar._TT["NEXT_YEAR"] = "Año siguiente (mantener para menú)";
Calendar._TT["SEL_DATE"] = "Seleccionar fecha";
Calendar._TT["DRAG_TO_MOVE"] = "Arrastrar para mover";
Calendar._TT["PART_TODAY"] = " (hoy)";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "Hacer %s primer día de la semana";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = "Cerrar";
Calendar._TT["TODAY"] = "Hoy";
Calendar._TT["TIME_PART"] = "(Mayúscula-)Clic o arrastre para cambiar valor";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%d/%m/%Y";
Calendar._TT["TT_DATE_FORMAT"] = "%A, %e de %B de %Y";

Calendar._TT["WK"] = "sem";
Calendar._TT["TIME"] = "Hora:";

 
  </script>

  <script type="text/javascript" language="javascript" src="Scripts/calendar/calendar-setup.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" language="javascript">
		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('nuevaActividad',
						 'ContenidoActividad',						 
						 false,
						 null);
		}
		window.onload = function () {
			seteaOcultadoresDeDivs();
		}
  </script>

  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-image: none;">
  <form id="formRegistroActividades" runat="server">
    <div id="ContenidoActividad" style="display: none;" runat="server">
      <div style="margin-top: 10px; margin-bottom: 5px; width: 700px;padding:1%;">
        <asp:Label ID="Label1" runat="server" Font-Size="18px" Font-Bold="True" ForeColor="White">Nueva Actividad</asp:Label>
        <asp:FormView ID="actividadFormView" runat="server" DataKeyNames="ajusteId,actividadId"
          DataSourceID="odsActividadEditor" DefaultMode="Insert" OnItemInserted="actividadFormView_ItemInserted"
          Width="674px">
          <InsertItemTemplate>
            <table width="700" border="0" cellpadding="0" cellspacing="0" class="DataTable">
              <tr>
                <td width="26" style="height: 20px;">
                  &nbsp;</td>
                <td width="121">
                  &nbsp;</td>
                <td width="179">
                  &nbsp;</td>
                <td width="37">
                  &nbsp;</td>
                <td style="width: 137px">
                  &nbsp;</td>
                <td width="191">
                  &nbsp;</td>
                <td width="9">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="height: 24px">
                  &nbsp;</td>
                <td valign="top" style="height: 24px">
                  Fecha y Hora
                  <asp:RequiredFieldValidator ID="rfvFechaCoordinacion" runat="server" ControlToValidate="txtFechaCoordinacion"
                    ErrorMessage="Ingrese la Fecha de Coordinación" ValidationGroup="actividades">(*)</asp:RequiredFieldValidator></td>
                <td valign="top" style="height: 24px; color: #541c01;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="30" style="height: 18px">
                        <button style="width: 17px; height: 17px;" class="FormButton" id="btnFechaAviso">
                          <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                            alt="Escoja una fecha" /></button>
                      </td>
                      <td style="height: 18px">
                        <asp:TextBox ID="txtFechaCoordinacion" runat="server" TabIndex="1" CssClass="FormText"
                          Width="145px" Text='<%# Bind("FechaHoraReunion") %>'></asp:TextBox>

                        <script type="text/javascript">                           
                            Calendar.setup({
                                inputField     :    'actividadFormView_txtFechaCoordinacion',
                                ifFormat       :    '%d/%m/%Y',
                                button         :    'btnFechaAviso',
                                showsTime      :    true,
                                timeFormat     :    '24',
                                singleClick    :    false
                             
                           }); 
                        </script>

                      </td>
                    </tr>
                  </table>
                </td>
                <td valign="top" style="height: 24px; color: #541c01;">
                  &nbsp;</td>
                <td valign="top" style="height: 24px; width: 137px;">
                  Tipo Actividad
                </td>
                <td valign="top" style="height: 24px">
                  <span style="width: 314px">
                    <Custom:AutoSuggestBox ID="AutoSuggestBox1" runat="server" CssClass="FormText" DataType="TipoActividad"
                      ResourcesDir="./asb_includes" Width="175px" IncludeMoreMenuItem="False" KeyPressDelay="300"
                      MaxSuggestChars="5" MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..."
                      NumMenuItems="10" SelectedValue='<%# Bind("tipoActividadId") %>' SelMenuItemCSSClass="asbSelMenuItem"
                      UseIFrame="True" Text='<%# Bind("tipoActividad") %>'></Custom:AutoSuggestBox></span></td>
                <td style="height: 24px">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="height: 24px">
                  &nbsp;</td>
                <td valign="top" style="height: 24px">
                  Lugar y/o Direcci&oacute;n</td>
                <td valign="top" style="height: 24px">
                  <span style="width: 314px">
                    <asp:TextBox ID="txtDireccion" TabIndex="2" runat="server" CssClass="FormText" Width="175px"
                      Text='<%# Bind("lugarDeReunion") %>'></asp:TextBox>
                  </span>
                </td>
                <td valign="top" style="height: 24px">
                  &nbsp;</td>
                <td valign="top" style="height: 24px; width: 137px;">
                  Persona Contactada</td>
                <td valign="top" style="height: 24px">
                  <span style="width: 314px">
                    <asp:TextBox ID="txtPersonaContacto" runat="server" CssClass="FormText" Width="175px"
                      TabIndex="5" Text='<%# Bind("personaContacto") %>'></asp:TextBox>
                  </span>
                </td>
                <td style="height: 24px">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="height: 24px">
                  &nbsp;</td>
                <td valign="top" style="height: 24px">
                  Distrito
                </td>
                <td valign="top" style="height: 24px">
                  <Custom:AutoSuggestBox ID="asbDistrito" runat="server" CssClass="FormText" DataType="Distrito"
                    ResourcesDir="./asb_includes" Width="175px" IncludeMoreMenuItem="False" KeyPressDelay="300"
                    MaxSuggestChars="5" MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..."
                    NumMenuItems="10" SelectedValue='<%# Bind("ubigeoId") %>' SelMenuItemCSSClass="asbSelMenuItem"
                    UseIFrame="True"></Custom:AutoSuggestBox></td>
                <td valign="top" style="height: 24px">
                  &nbsp;</td>
                <td valign="top" style="height: 24px; width: 137px;">
                  Telefono Contacto
                </td>
                <td valign="top" style="height: 24px">
                  <span style="width: 314px">
                    <asp:TextBox ID="txtTelefonoPersona" runat="server" CssClass="FormText" Width="175px"
                      TabIndex="6" Text='<%# Bind("telefonoPersonaContacto") %>'></asp:TextBox>
                  </span>
                </td>
                <td style="height: 24px">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="height: 12px">
                  &nbsp;</td>
                <td valign="top" style="height: 12px">
                  &nbsp;</td>
                <td valign="top" style="height: 12px">
                  &nbsp;</td>
                <td valign="top" style="height: 12px">
                  &nbsp;</td>
                <td valign="top" style="height: 12px; width: 137px;">
                  &nbsp;</td>
                <td valign="top" style="height: 12px">
                  &nbsp;</td>
                <td style="height: 12px">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="height: 24px">
                  &nbsp;</td>
                <td colspan="2" valign="top" style="height: 24px">
                  Personas Entrevistadas&nbsp;
                </td>
                <td valign="top" style="height: 24px">
                  &nbsp;</td>
                <td colspan="2" valign="top" style="height: 24px">
                  Detalles
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescripcion"
                    ErrorMessage="Ingrese los Detalles" ValidationGroup="actividades">(*)</asp:RequiredFieldValidator></td>
                <td style="height: 24px; color: #541c01;">
                  &nbsp;</td>
              </tr>
              <tr>
                <td>
                  &nbsp;</td>
                <td colspan="2" valign="top">
                  <span style="height: 24px"><span style="width: 314px">
                    <asp:TextBox ID="txtPersonasEntrevistadas" runat="server" CssClass="FormText" TextMode="MultiLine"
                      Width="293px" Height="70px" TabIndex="7" Text='<%# Bind("personaEntrevistada") %>'></asp:TextBox>
                  </span></span>
                </td>
                <td valign="top">
                  &nbsp;</td>
                <td colspan="2" valign="top">
                  <span style="width: 314px">
                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" TextMode="MultiLine"
                      Width="311px" Height="70px" TabIndex="8" Text='<%# Bind("descripcion") %>'></asp:TextBox>
                  </span>
                </td>
                <td>
                  &nbsp;</td>
              </tr>
              <tr>
                <td>
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top" style="width: 137px">
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td>
                </td>
              </tr>
              <tr>
                <td>
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top" style="width: 137px">
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td>
                </td>
              </tr>
              <tr>
                <td>
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top">
                  &nbsp;<asp:TextBox ID="txtEstadoCoordinacion" runat="server" CssClass="FormText"
                    Width="123px" Style="display: none"></asp:TextBox>
                </td>
                <td valign="top">
                  &nbsp;</td>
                <td valign="top" style="width: 137px">
                  &nbsp;</td>
                <td valign="top">
                  <div align="right">
                    <asp:Button ID="btnAgregar" runat="server" CssClass="FormButton" Text="Agregar" ValidationGroup="actividades"
                      CommandName="Insert" />
                  </div>
                </td>
                <td>
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
                <td style="width: 137px">
                  &nbsp;</td>
                <td>
                </td>
                <td>
                </td>
              </tr>
            </table>
          </InsertItemTemplate>
        </asp:FormView>
      </div>
    </div>
    <div style="height: 30px; margin-top: 10px; margin-bottom: 5px; width: 700px;">
      &nbsp;&nbsp;&nbsp;<asp:Label ID="lblListaActividades" runat="server" Font-Bold="True"
        Font-Size="18px" ForeColor="White">Lista Actividades</asp:Label>
      &nbsp;<asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif"
        NavigateUrl="~/vBitacoras.aspx" onclick="return separar();" Width="22px"></asp:HyperLink>
      &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
      <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Actividad" title="Agregar Actividades"
        id="nuevaActividad" /></div>
    <div id="ListaActividades">
      <div>
        <asp:GridView ID="gwListaActividad" runat="server" AutoGenerateColumns="False" CssClass="DataTable"
          DataSourceID="odsListaActividad" AllowPaging="True" Width="700px" DataKeyNames="actividadId">
          <Columns>
            <asp:TemplateField HeaderText="N&#176;">
              <ItemStyle Width="10px" HorizontalAlign="Center" />
              <HeaderStyle HorizontalAlign="Center" Width="10px" />
            </asp:TemplateField>
            <asp:BoundField DataField="tipoActividad" HeaderText="Tipo Actividad" SortExpression="tipoActividad" />
            <asp:BoundField DataField="FechaHoraReunion" HeaderText="Fecha y Hora" SortExpression="FechaHoraReunion">
              <ItemStyle HorizontalAlign="Center" Width="150px" />
              <HeaderStyle HorizontalAlign="Center" Width="150px" />
            </asp:BoundField>
            <asp:BoundField DataField="descripcion" HeaderText="Actividad" SortExpression="actividad">
              <ItemStyle HorizontalAlign="Center" Width="255px" />
              <HeaderStyle HorizontalAlign="Center" Width="255px" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaHoraCoordinacion" HeaderText="FechaHoraCoordinacion"
              SortExpression="FechaHoraCoordinacion" Visible="False" />
            <asp:BoundField DataField="lugarDeReunion" HeaderText="Lugar" SortExpression="lugarDeReunion" />
            <asp:BoundField DataField="actividadId" HeaderText="actividadId" InsertVisible="False"
              ReadOnly="True" SortExpression="actividadId" Visible="False" />
            <asp:BoundField DataField="personaContacto" HeaderText="Persona Contactada" SortExpression="personaContacto">
              <ItemStyle HorizontalAlign="Center" Width="255px" />
              <HeaderStyle HorizontalAlign="Center" Width="255px" />
            </asp:BoundField>
            <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" ReadOnly="True" SortExpression="ajusteId"
              Visible="False" />
            <asp:BoundField DataField="referencia" HeaderText="referencia" SortExpression="referencia"
              Visible="False" />
            <asp:BoundField DataField="estado" HeaderText="Estado" SortExpression="estado" Visible="False" />
            <asp:BoundField DataField="descripcion" HeaderText="descripcion" SortExpression="descripcion"
              Visible="False" />
            <asp:BoundField DataField="telefonoPersonaContacto" HeaderText="telefonoPersonaContacto"
              SortExpression="telefonoPersonaContacto" Visible="False" />
            <asp:BoundField DataField="personaEntrevistada" HeaderText="personaEntrevistada"
              SortExpression="personaEntrevistada" Visible="False" />
            <asp:BoundField DataField="ubigeoId" HeaderText="ubigeoId" SortExpression="ubigeoId"
              Visible="False" />
            <asp:BoundField DataField="ubicacion" HeaderText="ubicacion" ReadOnly="True" SortExpression="ubicacion"
              Visible="False" />
            <asp:BoundField DataField="tipoActividadId" HeaderText="tipoActividadId" SortExpression="tipoActividadId"
              Visible="False" />
            <asp:TemplateField>
              <ItemTemplate>
                <asp:ImageButton ID="imgBtnEliminar" runat="server" CausesValidation="False" CommandName="Delete"
                  ImageUrl="~/imgRGen/deleteItem.gif" />
              </ItemTemplate>
              <ItemStyle HorizontalAlign="Center" Width="20px" />
            </asp:TemplateField>
          </Columns>
          <HeaderStyle CssClass="HeaderStyle" />
          <EmptyDataTemplate>
            No hay Actividades registradas
          </EmptyDataTemplate>
        </asp:GridView>
      </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
      ShowSummary="False" />
    <asp:ObjectDataSource ID="odsListaActividad" runat="server" SelectMethod="GetData"
      TypeName="dsCoordinacionTableAdapters.ActividadListaTableAdapter" DeleteMethod="Delete">
      <SelectParameters>
        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
      </SelectParameters>
      <DeleteParameters>
        <asp:Parameter Name="actividadId" Type="Decimal" />
      </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsActividadEditor" runat="server" InsertMethod="Insert"
      SelectMethod="GetData" TypeName="dsCoordinacionTableAdapters.ActividadEditorTableAdapter"
      DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}">
      <DeleteParameters>
        <asp:Parameter Name="actividadId" Type="Decimal" />
      </DeleteParameters>
      <SelectParameters>
        <asp:Parameter Name="actividadId" Type="Decimal" />
        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
        <asp:Parameter Name="lugarDeReunion" Type="String" />
        <asp:Parameter Name="personaContacto" Type="String" />
        <asp:Parameter Name="personaEntrevistada" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="FechaHoraReunion" Type="DateTime" />
        <asp:Parameter Name="ubigeoId" Type="String" />
        <asp:Parameter Name="telefonoPersonaContacto" Type="String" />
        <asp:Parameter Name="tipoActividadId" Type="Decimal" />
        <asp:Parameter Name="tipoActividad" Type="String" />
        <asp:SessionParameter Name="uupdate" SessionField="usuario" Type="String" />
      </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoCoordinacion" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoActividadListaTableAdapter">
    </asp:ObjectDataSource>
  </form>
</body>
</html>
