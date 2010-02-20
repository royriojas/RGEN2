<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroComunicacion.aspx.cs"
  Inherits="vRegistroComunicacion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Comunicaciones</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

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

  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <style type="text/css">
<!--
body {
	
}
#Layer1 {
	position:absolute;
	left:668px;
	top:1px;
	width:26px;
	height:12px;
	z-index:1;
}
-->
</style>

  <script language="javascript" type="text/javascript">
	
	
var btn_mostrar_Ocultar;
window.onload = function () {
	
	btn_mostrar_Ocultar = new CollapsibleDiv('imgInicial',
						 'ContenidoComunicacion',						 
						 null,
						 null);
}

window.onunload= function () {
	if (btn_mostrar_Ocultar) btn_mostrar_Ocultar.UnLoad();
}
  </script>

</head>
<body style="background-image: none;">
  <div style="width: 699px;">
    <form id="formRegistroComunicaciones" runat="server">
      <div id="ContenidoComunicacion" style="display: none;" runat="server">
        <div style="margin-top: 5px; margin-bottom: 5px; position: relative; height: 24px;
          left: 0px; top: 0px;">
          <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="18px" ForeColor="White">Nueva Comunicación</asp:Label>
        </div>
        <div class="DataTable" style="padding: 5px;">
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td style="width: 150px">
                &nbsp;Dirigida a:</td>
              <td>
                <asp:DropDownList ID="cbxDirigidoa" runat="server" CssClass="FormText" Width="160px">
                  <asp:ListItem Value="Compa&#241;ia de Seguros">Compa&#241;ia de Seguros</asp:ListItem>
                  <asp:ListItem>Broker</asp:ListItem>
                  <asp:ListItem>Asegurado</asp:ListItem>
                  <asp:ListItem>Ajustadores</asp:ListItem>
                </asp:DropDownList></td>
              <td style="width: 51px">
                &nbsp;Tipo</td>
              <td>
                <asp:DropDownList ID="cbxTipoComunicacion" runat="server" CssClass="FormText" DataSourceID="odsTipoComunicaicon"
                  DataTextField="nombre" DataValueField="tcomunicacionId" Width="170px">
                </asp:DropDownList></td>
            </tr>
            <tr>
              <td style="width: 150px">
                &nbsp;De:</td>
              <td>
                <asp:DropDownList ID="cbxDe" runat="server" CssClass="FormText" Width="160px">
                  <asp:ListItem Value="Compa&#241;ia de Seguros">Compa&#241;ia de Seguros</asp:ListItem>
                  <asp:ListItem>Broker</asp:ListItem>
                  <asp:ListItem>Asegurado</asp:ListItem>
                </asp:DropDownList></td>
              <td style="width: 51px">
                &nbsp;Fecha</td>
              <td>
                <button style="width: 17px; height: 17px;" class="FormButton" id="btnFechaAviso">
                  <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                    alt="Escoja una fecha" /></button>
                <asp:TextBox ID="txtFechaCom" runat="server" CssClass="FormText" Width="145px"></asp:TextBox>

                <script type="text/javascript">
                            function getFoco(cal) {
                                p = cal.params;
                                p.inputField.focus();
                                p.inputField.select();
                                cal.hide();                  
                                
                            }
                            Calendar.setup({
                                inputField     :    'txtFechaCom',
                                ifFormat       :    '%d/%m/%Y %H:%M',
                                button         :    'btnFechaAviso',
                                showsTime      :    true,
                                timeFormat     :    '24',
                                singleClick    :    false
                             
                           }); 
                </script>

                <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red" Text="(*)"
                  Visible="False"></asp:Label>
              </td>
            </tr>
            <tr>
              <td style="width: 150px">
                &nbsp;Asunto:<asp:RequiredFieldValidator ID="rfvAsunto" runat="server" ControlToValidate="txtAsunto"
                  ErrorMessage="Ingrese Asunto de la Comunicación">(*)</asp:RequiredFieldValidator></td>
              <td colspan="3">
                <asp:TextBox ID="txtAsunto" runat="server" CssClass="FormText" Width="377px"></asp:TextBox></td>
            </tr>
            <tr>
              <td style="width: 150px">
                &nbsp;Descripción:<asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
                  ControlToValidate="txtDescripcion" ErrorMessage="Ingrese Descripción Comunicación">(*)</asp:RequiredFieldValidator></td>
              <td colspan="3" style="height: 13px">
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" TextMode="MultiLine"
                  Width="377px" Rows="4"></asp:TextBox></td>
            </tr>
            <tr>
              <td style="width: 150px">
                &nbsp;Archivo Adjunto:</td>
              <td colspan="3">
                <asp:FileUpload ID="fupArchivo" runat="server" CssClass="FormText" Width="381px" /></td>
            </tr>
            <tr>
              <td style="width: 150px">
                &nbsp;Cuerpo de Correo:</td>
              <td colspan="3">
                <asp:TextBox ID="txtCuerpoCorreo" runat="server" CssClass="FormText" TextMode="MultiLine"
                  Width="377px" Rows="4"></asp:TextBox></td>
            </tr>
            <tr>
              <td style="width: 150px">
                &nbsp;</td>
              <td>
                <asp:TextBox ID="txtNombreArchivo" runat="server" CssClass="FormText" Width="80px"
                  Visible="False"></asp:TextBox></td>
              <td style="width: 51px">
                &nbsp;</td>
              <td>
                &nbsp;</td>
            </tr>
            <tr>
              <td style="width: 150px">
                &nbsp;</td>
              <td>
                <asp:Button ID="btnAgregar" runat="server" CssClass="FormButton" Text="Agregar" OnClick="btnAgregar_Click" /></td>
              <td style="width: 51px">
                &nbsp;</td>
              <td>
                &nbsp;</td>
            </tr>
          </table>
        </div>
      </div>
      <div style="margin-top: 10px; left: 0px; margin-bottom: 5px; position: relative;
        top: 0px; height: 31px; width: 699px;">
        &nbsp;<asp:Label ID="lblListaComunicacion" runat="server" Font-Bold="True" Font-Size="18px"
          ForeColor="White">Lista Comunicaciones</asp:Label>&nbsp;
        <asp:HyperLink runat="server" ID="lnkSeparar" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
          onclick="return separar();" Width="1px" />
        <img alt="openClose" style="position: absolute; left: 671px; top: 6px;" runat="server"
          id="imgInicial" src="imgRGen/openCloseCollapse.jpg" />
      </div>
      <div id="ListaComunicaciones" style="margin-left: auto; margin-right: auto; position: relative">
        <div>
          <asp:GridView ID="gwListaComunicacion" runat="server" AutoGenerateColumns="False"
            CssClass="DataTable" DataKeyNames="ajusteId,comunicacionid" DataSourceID="odsComunicacionLista"
            OnRowCommand="gwListaComunicacion_RowCommand" Width="700px">
            <Columns>
              <asp:TemplateField HeaderText="N&#176;">
                <ItemTemplate>
                  <asp:Label ID="lblNumComunicacion" runat="server" Text="<%# num++ %>"></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="15px" HorizontalAlign="Center" />
              </asp:TemplateField>
              <asp:BoundField DataField="nombre" HeaderText="Tipo" SortExpression="nombre" />
              <asp:BoundField DataField="fechaRegistro" HeaderText="Fecha" SortExpression="fechaRegistro" />
              <asp:BoundField DataField="Emisor" HeaderText="Emisor" SortExpression="Emisor" />
              <asp:BoundField DataField="Receptor" HeaderText="Receptor" SortExpression="Receptor" />
              <asp:BoundField DataField="asunto" HeaderText="Asunto" SortExpression="asunto" />
              <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" ReadOnly="True" SortExpression="ajusteId"
                Visible="False" />
              <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" SortExpression="descripcion"
                Visible="False" />
              <asp:BoundField DataField="nombreArchivo" HeaderText="Nombre Archivo" SortExpression="nombreArchivo"
                Visible="False" />
              <asp:BoundField DataField="tcomunicacionId" HeaderText="tcomunicacionId" SortExpression="tcomunicacionId"
                Visible="False" />
              <asp:BoundField DataField="cuerpoCorreo" HeaderText="Cuerpo Correo" SortExpression="cuerpoCorreo"
                Visible="False" />
              <asp:BoundField DataField="nombre" HeaderText="Tipo Comunicaci&#243;n" SortExpression="nombre"
                Visible="False" />
              <asp:BoundField DataField="comunicacionid" HeaderText="comunicacionid" InsertVisible="False"
                ReadOnly="True" SortExpression="comunicacionid" Visible="False" />
              <asp:TemplateField>
                <ItemTemplate>
                  <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument='<%# Bind("comunicacionid") %>'
                    CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
              </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="HeaderStyle" />
            <RowStyle CssClass="ItemStyle" />
            <EmptyDataTemplate>
              No hay comunicaciones registradas
            </EmptyDataTemplate>
          </asp:GridView>
        </div>
      </div>
      <asp:ObjectDataSource ID="odsTipoComunicaicon" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsComunicacionTableAdapters.TipoComunicacionListaTableAdapter">
      </asp:ObjectDataSource>
      <asp:ObjectDataSource ID="odsComunicacionEditor" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="dsComunicacionTableAdapters.ComunicacionEditorTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
          <asp:ControlParameter ControlID="txtAjusteId" Name="Original_ajusteId" PropertyName="Text"
            Type="Decimal" />
          <asp:ControlParameter ControlID="txtComunicacionId" Name="Original_comunicacionid"
            PropertyName="Text" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
          <asp:Parameter Name="ajusteId" Type="Decimal" />
          <asp:Parameter Name="descripcion" Type="String" />
          <asp:Parameter Name="nombreArchivo" Type="String" />
          <asp:Parameter Name="fechaRegistro" Type="DateTime" />
          <asp:Parameter Name="tcomunicacionId" Type="Decimal" />
          <asp:Parameter Name="asunto" Type="String" />
          <asp:Parameter Name="archivoFisico" Type="Object" />
          <asp:Parameter Name="cuerpoCorreo" Type="String" />
          <asp:Parameter Name="Emisor" Type="String" />
          <asp:Parameter Name="Receptor" Type="String" />
          <asp:Parameter Name="Original_ajusteId" Type="Decimal" />
          <asp:Parameter Name="Original_comunicacionid" Type="Decimal" />
          <asp:Parameter Name="comunicacionid" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
          <asp:ControlParameter ControlID="txtAjusteId" Name="ajusteId" PropertyName="Text"
            Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
          <asp:ControlParameter ControlID="txtAjusteId" Name="ajusteId" PropertyName="Text"
            Type="Decimal" />
          <asp:ControlParameter ControlID="txtDescripcion" Name="descripcion" PropertyName="Text"
            Type="String" />
          <asp:ControlParameter ControlID="txtNombreArchivo" Name="nombreArchivo" PropertyName="Text"
            Type="String" />
          <asp:ControlParameter ControlID="cbxTipoComunicacion" Name="tcomunicacionId" PropertyName="SelectedValue"
            Type="Decimal" />
          <asp:ControlParameter ControlID="txtAsunto" Name="asunto" PropertyName="Text" Type="String" />
          <asp:ControlParameter ControlID="fupArchivo" Name="archivoFisico" PropertyName="FileBytes"
            Type="Object" />
          <asp:ControlParameter ControlID="txtCuerpoCorreo" Name="cuerpoCorreo" PropertyName="Text"
            Type="String" />
          <asp:ControlParameter ControlID="cbxDe" Name="Emisor" PropertyName="SelectedValue"
            Type="String" />
          <asp:ControlParameter ControlID="cbxDirigidoa" Name="Receptor" PropertyName="SelectedValue"
            Type="String" />
        </InsertParameters>
      </asp:ObjectDataSource>
      <asp:TextBox ID="txtAjusteId" runat="server" Visible="False"></asp:TextBox>
      <asp:TextBox ID="txtComunicacionId" runat="server" Visible="False"></asp:TextBox>
      <asp:ObjectDataSource ID="odsComunicacionLista" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsComunicacionTableAdapters.ComunicacionListaTableAdapter">
        <SelectParameters>
          <asp:ControlParameter ControlID="txtAjusteId" Name="ajusteId" PropertyName="Text"
            Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
      <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" />
    </form>
  </div>
</body>
</html>
