<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vReportes.aspx.cs" Inherits="vReportes" %>

<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
    TagPrefix="uc2" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <script language="javascript" type="text/javascript" src="scripts/calendar/datetimepicker.js"></script>

    <title>Riesgos Generales | Lista de Ajustes</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/calendar/calendar-blue2.css" rel="Stylesheet" type="text/css" />

    <script type='text/javascript' src="Scripts/lib/x_core.js"></script>

    <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

    <script type="text/javascript" src="Scripts/calendar/calendar.js"></script>

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
"Para conseguir la última versi&oacute;n visite: http://www.dynarch.com/projects/calendar/\n" +
"Distribuido bajo licencia GNU LGPL. Visite http://gnu.org/licenses/lgpl.html para más detalles." +
"\n\n" +
"Selecci&oacute;n de fecha:\n" +
"- Use los botones \xab, \xbb para seleccionar el año\n" +
"- Use los botones " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " para seleccionar el mes\n" +
"- Mantenga pulsado el rat&oacute;n en cualquiera de estos botones para una selecci&oacute;n rápida.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"Selecci&oacute;n de hora:\n" +
"- Pulse en cualquiera de las partes de la hora para incrementarla\n" +
"- o pulse las mayúsculas mientras hace clic para decrementarla\n" +
"- o haga clic y arrastre el rat&oacute;n para una selecci&oacute;n más rápida.";

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

    <script type="text/javascript" language="javascript" src="Scripts/calendar/calendar-setup.js">
    </script>

    <script type="text/javascript" language="javascript">
	window.onload = function () {
	
	btn_mostrar_Ocultar = new CollapsibleDiv('img_hide_cabecera',
						 'cabecera_collapsible',						 
						 true,
						 null);
	btn_agregarNuevoArchivo = new CollapsibleDiv('img_hide_grpBusqueda',
						 'grupoBusqueda',						 
						 true,
						 null);
	
}

window.onunload= function () {
	if (btn_mostrar_Ocultar) btn_mostrar_Ocultar.UnLoad();
}
    </script>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr>
            <td>
                <div >
                    <form id="form1" runat="server">
                        <div id="cabecera_collapsible" style="position: relative;">
                            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="reportes" />
                        </div>
                        <div style="position: relative;">
                            &nbsp;
                        </div>
                        <!-- aqui -->
                        <div id="grupoBusqueda">
                            <div class="DataTop">
                                <div class="DataTopLeft">
                                </div>
                                <div class="DataTopRight">
                                </div>
                            </div>
                            <div class="DataContent">
                                <div class="DataContentRight">
                                    <div style="height:16px">
                                        <asp:Label ID="lblNotificar" runat="server" Font-Bold="True" Font-Size="18px" style="float:left">Filtros</asp:Label>
                                        <img alt="" src="imgRGen/openCloseCollapse.jpg" id="img_hide_cabecera" title="Ocultar/Mostrar Cabecera"
                                            style="float: right; margin-top: 3px"/>
                                    </div>
                                    <div class="hr">
                                        </div>
                                    <div align="right" style="position: absolute; left: 816px; top: 48px; z-index: 500;
                                        height: 118px;">
                                        <asp:ImageButton ID="ibtnBuscar" runat="server" ImageUrl="~/imgRGen/btnBuscar.gif"
                                            TabIndex="17" OnClick="ibtnBuscar_Click" /><br />
                                        <br />
                                        <asp:ImageButton ID="ibtnExportar" runat="server" ImageUrl="~/imgRGen/btnExportar.jpg"
                                            TabIndex="17" OnClick="ibtnExportar_Click2" /><br />
                                    </div>
                                    <div style="position: relative;">
                                        <table width="850" border="0" cellspacing="0" cellpadding="0" runat="server" id="myTable">
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    <span style="width: 119px; height: 24px;">Asegurado</span></td>
                                                <td height="20" style="width: 251px">
                                                    <span style="width: 57px; height: 24px;">
                                                        <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" Width="203px" TabIndex="1"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    Ramo</td>
                                                <td width="209" height="20">
                                                    <span style="width: 158px; height: 24px">
                                                        <asp:DropDownList ID="cbxRamo" runat="server" CssClass="FormSelect" Width="207px"
                                                            TabIndex="14" AppendDataBoundItems="True" DataSourceID="odsRamo" DataTextField="nombre"
                                                            DataValueField="ramoId">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    Aseguradora</td>
                                                <td height="20" style="width: 251px">
                                                    <span style="width: 57px; height: 24px;">
                                                        <asp:DropDownList ID="cbxCia" runat="server" CssClass="FormSelect" Width="207px"
                                                            TabIndex="2" AppendDataBoundItems="True" DataSourceID="odsCia" DataTextField="persona"
                                                            DataValueField="personaid" OnDataBound="cbxCia_DataBound">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    Tipo de Ajuste
                                                </td>
                                                <td width="209" height="20">
                                                    <span style="width: 158px; height: 24px;">
                                                        <asp:DropDownList ID="cbxLiquidacion" runat="server" CssClass="FormSelect" Width="207px"
                                                            TabIndex="15" AppendDataBoundItems="True" DataSourceID="odsTipoLiquidacion" DataTextField="tajuste"
                                                            DataValueField="tajusteid">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    <span style="width: 119px; height: 24px">Broker</span></td>
                                                <td height="20" style="width: 251px">
                                                    <span style="width: 57px; height: 24px">
                                                        <asp:DropDownList ID="cbxBroker" runat="server" AppendDataBoundItems="True" CssClass="FormSelect"
                                                            DataSourceID="odsBroker" DataTextField="persona" DataValueField="personaId" Width="207px"
                                                            TabIndex="3" OnDataBound="cbxBroker_DataBound">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    Tipo de Siniestro
                                                </td>
                                                <td width="209" height="20">
                                                    <span style="width: 57px; height: 24px;">
                                                        <asp:TextBox ID="txtSiniestro" runat="server" CssClass="FormText" Width="202px" TabIndex="16"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    Encargado Aseguradora
                                                </td>
                                                <td height="20" style="width: 251px">
                                                    <span style="width: 158px; height: 24px">
                                                        <asp:TextBox ID="txtEjecutivo" runat="server" CssClass="FormText" Width="203px" TabIndex="4"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    Status</td>
                                                <td width="209" height="20">
                                                    <span style="width: 158px; height: 24px">
                                                        <asp:DropDownList ID="cbxEstatus" runat="server" CssClass="FormSelect" Width="207px"
                                                            TabIndex="17" AppendDataBoundItems="True" DataSourceID="odsEstatus" DataTextField="estadoajuste"
                                                            DataValueField="estadoajusteid">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    Encargado Broker
                                                </td>
                                                <td height="20" style="width: 251px">
                                                    <span style="width: 158px; height: 24px">
                                                        <asp:TextBox ID="txtEjecutivoBroker" runat="server" CssClass="FormText" Width="203px"
                                                            TabIndex="5"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    N&deg; Siniestro
                                                </td>
                                                <td width="209" height="20">
                                                    <span style="width: 57px; height: 24px">
                                                        <asp:TextBox ID="txtNroSiniestroCia" runat="server" CssClass="FormText" Width="203px"
                                                            TabIndex="18"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    Encargado Ajustador
                                                </td>
                                                <td height="20" style="width: 251px">
                                                    <span style="width: 57px; height: 24px">
                                                        <asp:DropDownList ID="cbxAjustador" runat="server" CssClass="FormSelect" Width="207px"
                                                            TabIndex="6" AppendDataBoundItems="True" DataSourceID="odsAjustador" DataTextField="persona"
                                                            DataValueField="personaid" OnDataBound="cbxAjustador_DataBound">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    N&deg; Broker
                                                </td>
                                                <td width="209" height="20">
                                                    <span style="width: 57px; height: 24px">
                                                        <asp:TextBox ID="txtNroSiniestroBroker" runat="server" CssClass="FormText" Width="203px"
                                                            TabIndex="19"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    <span style="width: 128px; height: 24px;">Nro. Poliza</span></td>
                                                <td height="20" style="width: 251px">
                                                    <span style="width: 158px; height: 24px;">
                                                        <asp:TextBox ID="txtPoliza" runat="server" CssClass="FormText" Width="203px" TabIndex="7"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    N&deg; Ajuste
                                                </td>
                                                <td width="209" height="20">
                                                    <span style="width: 158px; height: 24px;">
                                                        <asp:TextBox ID="txtNroAjuste" runat="server" CssClass="FormText" Width="203px" TabIndex="20"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    <span style="width: 143px; height: 12px">Fecha de Siniestro</span></td>
                                                <td height="20" style="width: 251px">
                                                    <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td width="24">
                                                                del</td>
                                                            <td width="19">
                                                                <button tabindex="7" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaInicio">
                                                                    <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                                                        width="16" /></button>
                                                            </td>
                                                            <td width="67">
                                                                <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="FormText" TabIndex="7"
                                                                    Width="50px"></asp:TextBox>

                                                                <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'txtFechaInicio',
                                                                        ifFormat       :    '%d/%m/%Y',
                                                                        button         :    'btnFechaInicio',
                                                                        showsTime      :    false,                                                                        
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                                                                </script>

                                                            </td>
                                                            <td width="22">
                                                                <div align="center">
                                                                    al</div>
                                                            </td>
                                                            <td width="21">
                                                                <button tabindex="9" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaFin">
                                                                    <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                                                        width="16" /></button>
                                                            </td>
                                                            <td>
                                                                <span style="height: 12px">
                                                                    <asp:TextBox ID="txtFechaFin" runat="server" CssClass="FormText" TabIndex="9" Width="50px"></asp:TextBox>
                                                                </span>

                                                                <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'txtFechaFin',
                                                                        ifFormat       :    '%d/%m/%Y' ,
                                                                        button         :    'btnFechaFin',
                                                                        showsTime      :    false,                                                                        
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                                                                </script>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    Reserva Neta</td>
                                                <td width="209" height="20">
                                                    <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td width="24">
                                                                de</td>
                                                            <td width="19">
                                                                <span style="width: 207px; height: 12px">
                                                                    <img alt="Escoja una fecha" border="0" height="16" onclick="NewCal('txtFechaInicio','ddmmyyyy',true,24)"
                                                                        style="visibility: hidden;" src="img/cal.gif" width="16" /></span></td>
                                                            <td width="67">
                                                                <asp:TextBox ID="txtReservaEntre" runat="server" CssClass="FormText" TabIndex="21"
                                                                    Width="50px"></asp:TextBox></td>
                                                            <td width="22">
                                                                <div align="center">
                                                                    a</div>
                                                            </td>
                                                            <td width="21">
                                                                <span style="height: 12px">
                                                                    <img style="visibility: hidden;" alt="Escoja una fecha" border="0" height="16" onclick="NewCal('txtFechaFin','ddmmyyyy',true,12)"
                                                                        src="img/cal.gif" width="16" /></span></td>
                                                            <td>
                                                                <asp:TextBox ID="txtReservaHasta" runat="server" CssClass="FormText" TabIndex="22"
                                                                    Width="50px"></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20" height="20">
                                                    &nbsp;</td>
                                                <td width="154" height="20">
                                                    D&iacute;as de asignado
                                                </td>
                                                <td height="20" style="width: 251px">
                                                    <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td width="24" style="height: 20px">
                                                                de</td>
                                                            <td width="19" style="height: 20px">
                                                                &nbsp;</td>
                                                            <td width="67" style="height: 20px">
                                                                <asp:TextBox ID="txtDiasEntre" runat="server" CssClass="FormText" TabIndex="11" Width="50px"></asp:TextBox></td>
                                                            <td width="22" style="height: 20px">
                                                                <div align="center">
                                                                    a</div>
                                                            </td>
                                                            <td width="21" style="height: 20px">
                                                                &nbsp;</td>
                                                            <td style="height: 20px">
                                                                <asp:TextBox ID="txtDiasHasta" runat="server" CssClass="FormText" TabIndex="13" Width="50px"></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="18" height="20">
                                                    &nbsp;</td>
                                                <td width="175" height="20">
                                                    D&iacute;as desde el último Cambio de Estado</td>
                                                <td width="209" height="20">
                                                    <table width="250" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td width="24">
                                                                de</td>
                                                            <td width="19">
                                                                <span style="width: 207px; height: 12px">
                                                                    <img alt="Escoja una fecha" border="0" height="16" onclick="NewCal('txtFechaInicio','ddmmyyyy',true,24)"
                                                                        style="visibility: hidden;" src="img/cal.gif" width="16" /></span></td>
                                                            <td width="67">
                                                                <asp:TextBox ID="txtEntre" runat="server" CssClass="FormText" TabIndex="23" Width="50px"></asp:TextBox></td>
                                                            <td width="22">
                                                                <div align="center">
                                                                    a</div>
                                                            </td>
                                                            <td width="21">
                                                                <span style="height: 12px">
                                                                    <img style="visibility: hidden;" alt="Escoja una fecha" border="0" height="16" onclick="NewCal('txtFechaFin','ddmmyyyy',true,12)"
                                                                        src="img/cal.gif" width="16" /></span></td>
                                                            <td>
                                                                <asp:TextBox ID="txtFin" runat="server" CssClass="FormText" TabIndex="24" Width="50px"></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td height="20" style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    Producto</td>
                                                <td style="width: 251px">
                                                    <asp:DropDownList ID="cbxProducto" runat="server" CssClass="FormSelect" Width="207px"
                                                        TabIndex="14" AppendDataBoundItems="True" DataSourceID="odsProducto" DataTextField="descripcion"
                                                        DataValueField="productoid" OnDataBound="cbxProducto_DataBound">
                                                    </asp:DropDownList></td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    Cobertura&nbsp;</td>
                                                <td>
                                                    <asp:DropDownList ID="cbxCobertura" runat="server" CssClass="FormSelect" Width="207px"
                                                        TabIndex="14" AppendDataBoundItems="True" DataSourceID="odsCobertura" DataTextField="nombre"
                                                        DataValueField="riesgoId" OnDataBound="cbxCobertura_DataBound">
                                                    </asp:DropDownList></td>
                                                <td style="width: 24px">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td style="width: 251px">
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td style="width: 24px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td style="width: 251px">
                                                    <asp:TextBox Style="display: none;" ID="txtFechaIniTemp" runat="server" CssClass="FormText"
                                                        TabIndex="1"></asp:TextBox></td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:TextBox Style="display: none;" ID="txtFechaFinTemp" runat="server" CssClass="FormText"></asp:TextBox></td>
                                                <td style="width: 24px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td style="width: 251px">
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td style="width: 24px">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="DataBottom">
                                <div class="DataBottomLeft">
                                </div>
                                <div class="DataBottomRight">
                                </div>
                            </div>
                        </div>
                        <br />
                        <!-- tabControl for Sytled -->
                        <div id="grilla">
                            <div class="DataTop">
                                <div class="DataTopLeft">
                                </div>
                                <div class="DataTopRight">
                                </div>
                            </div>
                            <div class="DataContent">
                                <div class="DataContentRight">
                                    <div style="height:16px">
                                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="18px" style="float:left">Lista de Ajustes</asp:Label>
                                        <img src="imgRGen/openCloseCollapse.jpg" id="img_hide_grpBusqueda" title="Ocultar/Mostrar filtros de Búsqueda"
                                            style="float: right; margin-top: 3px"/>
                                    </div>
                                    <div class="hr">
                                        </div>
                                    <div style="position: relative;">
                                        <asp:GridView ID="gViewReporte" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound" AllowPaging="True"
                                            CellPadding="0" PageSize="20" style="left: 0px; top: 0px">
                                            <Columns>
                                                <asp:BoundField DataField="Aseguradora" HeaderText="Aseguradora" SortExpression="Aseguradora" />
                                                <asp:BoundField DataField="Broker" HeaderText="Broker" SortExpression="Broker" />
                                                <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado" />
                                                <asp:BoundField DataField="numeroPoliza" HeaderText="N&#186; P&#243;liza" SortExpression="numeroPoliza" />
                                                <asp:BoundField DataField="Ramo" HeaderText="Ramo" SortExpression="Ramo" />
                                                <asp:BoundField DataField="fsiniestro" DataFormatString="{0:MM-dd-yyyy}" HeaderText="F. Siniestro"
                                                    HtmlEncode="False" SortExpression="fsiniestro">
                                                    <ItemStyle Width="75px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="NroDias" HeaderText="D&#237;as" SortExpression="NroDias" />
                                                <asp:BoundField DataField="siniestro" HeaderText="Tipo Siniestro" SortExpression="siniestro" />
                                                <asp:BoundField DataField="numeroSiniestroCia" HeaderText="N&#186; Siniestro" SortExpression="numeroSiniestroCia">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="numAjustePASA" HeaderText="N&#186; Ajuste" SortExpression="numAjustePASA" />
                                                <asp:BoundField DataField="Ajustador" HeaderText="Ajustador" SortExpression="Ajustador" />
                                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                                <asp:BoundField DataField="Dias" HeaderText="D&#237;as" SortExpression="Dias" />
                                                <asp:TemplateField HeaderText="Reserva Neta" SortExpression="EstimadoReserva">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("EstimadoReserva") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemStyle Width="90px" Font-Bold="True" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                      <asp:Label ID="Label1" runat="server" Text='<%# muestraSimbolo((Eval("aseguradoraId")),(Eval("brokerId")),Eval("simbolo"),Eval("EstimadoReserva")) %>'></asp:Label>
                                                      <br />
                                                      <asp:Label
                                                        ID="Label2" runat="server" Text='<%# muestraReserva((Eval("aseguradoraId")),(Eval("brokerId")),Eval("EstimadoReserva","{0:#,###.00}")) %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                              <asp:BoundField DataField="aseguradoraId" HeaderText="aseguradoraId" SortExpression="aseguradoraId"
                                                Visible="False" />
                                              <asp:BoundField DataField="brokerId" HeaderText="brokerId" SortExpression="brokerId"
                                                Visible="False" />
                                                <asp:BoundField DataField="observaciones" HeaderText="Observaciones" SortExpression="observaciones">
                                                    <ItemStyle Width="80px" />
                                                </asp:BoundField>
                                            </Columns>
                                            <RowStyle CssClass="ItemStyle" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="HeaderStyle" Height="30px" />
                                            <EmptyDataTemplate>
                                                No hay Ajustes para mostrar que cumplan con esos criterios de búsqueda
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                        <asp:Repeater ID="GrillaRepeater" runat="server" DataSourceID="ObjectDataSource1"
                                            Visible="False">
                                            <HeaderTemplate>
                                                <tr height="20" style='height: 15.0pt'>
                                                    <td height="20" class="xl1516917" style='height: 15.0pt'>
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                    <td class="xl1516917">
                                                    </td>
                                                </tr>
                                                <tr height="30" style='mso-height-source: userset; height: 22.5pt'>
                                                    <td height="30" class="xl1516917" style='height: 22.5pt'>
                                                    </td>
                                                    <td class="xl7016917" width="26" style='width: 20pt'>
                                                        No.</td>
                                                    <td class="xl7116917" width="180" style='width: 135pt'>
                                                        Aseguradora</td>
                                                    <td class="xl7116917" width="180" style='width: 135pt'>
                                                        Broker</td>
                                                    <td class="xl7116917" width="180" style='width: 135pt'>
                                                        Asegurado</td>
                                                    <td class="xl7116917" width="82" style='width: 62pt'>
                                                        No. P&oacute;liza</td>
                                                    <td class="xl7116917" width="91" style='width: 68pt'>
                                                        Ramo</td>
                                                    <td class="xl7116917" width="81" style='width: 61pt'>
                                                        F.Siniestro</td>
                                                    <td class="xl7116917" width="39" style='width: 29pt'>
                                                        D&iacute;as</td>
                                                    <td class="xl7116917" width="143" style='width: 107pt'>
                                                        Tipo</td>
                                                    <td class="xl7116917" width="143" style='width: 107pt'>
                                                        No. Siniestro</td>
                                                    <td class="xl7116917" width="81" style='width: 61pt'>
                                                        No. Ajuste</td>
                                                    <td class="xl7116917" width="97" style='width: 73pt'>
                                                        Ajustador</td>
                                                    <td class="xl7116917" width="143" style='width: 107pt'>
                                                        Status</td>
                                                    <td class="xl7116917" width="39" style='width: 29pt'>
                                                        D&iacute;as</td>
                                                    <td class="xl7116917" width="61" style='width: 46pt'>
                                                        Moneda</td>
                                                    <td class="xl7116917" width="98" style='width: 74pt'>
                                                        Reserva Neta</td>
                                                    <td class="xl7116917" width="120" style='width: 120pt'>
                                                        Observaciones</td>
                                                </tr>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr height="30" style='mso-height-source: userset; height: 22.5pt'>
                                                    <td height="30" class="xl1516917" style='height: 22.5pt'>
                                                    </td>
                                                    <td class="xl7216917" width="26" style='width: 20pt'>
                                                        <%=++num%>
                                                    </td>
                                                     <td class="xl7316917" width="180" style='width: 135pt'>
                                                        <%#DataBinder.Eval(Container.DataItem, "Aseguradora")%>
                                                    </td>
                                                    <td class="xl7316917" width="180" style='width: 135pt'>
                                                        <%#DataBinder.Eval(Container.DataItem, "Broker")%>
                                                    </td>
                                                    <td class="xl7316917" width="180" style='width: 135pt'>
                                                        <%#DataBinder.Eval(Container.DataItem, "Asegurado")%>
                                                    </td>
                                                    <td class="xl7416917" width="82" style='width: 62pt'>
                                                        <%# DataBinder.Eval(Container.DataItem, "numeroPoliza")%>
                                                    </td>
                                                    <td class="xl7316917" width="91" style='width: 68pt'>
                                                        <%# DataBinder.Eval(Container.DataItem, "Ramo")%>
                                                    </td>
                                                    <td class="xl7516917" width="81" style='width: 61pt'>
                                                        <%# DataBinder.Eval(Container.DataItem, "fsiniestro", "{0:dd/MM/yyyy}")%>
                                                    </td>
                                                    <td class="xl657722" width="39" style='width: 29pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "NroDias")%>
                                                    </td>
                                                    <td class="xl7316917" width="143" style='width: 107pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "siniestro")%>
                                                    </td>
                                                    <td class="xl7416917" width="143" style='width: 107pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "numeroSiniestroCia")%>
                                                    </td>
                                                    <td class="xl7416917" width="81" style='width: 61pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "numAjustePASA")%>
                                                    </td>
                                                    <td class="xl7316917" width="97" style='width: 73pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "Ajustador")%>
                                                    </td>
                                                    <td class="xl7316917" width="143" style='width: 107pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "Status")%>
                                                    </td>
                                                    <td class="xl657722" width="39" style='width: 29pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "Dias")%>
                                                    </td>
                                                    <td class="xl7616917" width="61" style='width: 46pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "simbolo")%>
                                                    </td>
                                                    <td class="xl8116917" width="98" style='width: 74pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "EstimadoReserva","{0:#,###.##}")%>
                                                    </td>
                                                     <td class="xl7416917" width="98" style='width: 74pt'>
                                                        <%#  DataBinder.Eval(Container.DataItem, "observaciones")%>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <![if supportMisalignedColumns]>
                                                <tr height="0" style='display: none'>
                                                    <td width="18" style='width: 14pt'>
                                                    </td>
                                                    <td width="26" style='width: 20pt'>
                                                    </td>
                                                    <td width="180" style='width: 135pt'>
                                                    </td>
                                                    <td width="180" style='width: 135pt'>
                                                    </td>
                                                    <td width="180" style='width: 135pt'>
                                                    </td>
                                                    <td width="82" style='width: 62pt'>
                                                    </td>
                                                    <td width="91" style='width: 68pt'>
                                                    </td>
                                                    <td width="81" style='width: 61pt'>
                                                    </td>
                                                    <td width="39" style='width: 29pt'>
                                                    </td>
                                                    <td width="143" style='width: 107pt'>
                                                    </td>
                                                    <td width="143" style='width: 107pt'>
                                                    </td>
                                                    <td width="81" style='width: 61pt'>
                                                    </td>
                                                    <td width="97" style='width: 73pt'>
                                                    </td>
                                                    <td width="143" style='width: 107pt'>
                                                    </td>
                                                    <td width="39" style='width: 29pt'>
                                                    </td>
                                                    <td width="61" style='width: 46pt'>
                                                    </td>
                                                    <td width="98" style='width: 74pt'>
                                                    </td>
                                                </tr>
                                                <![endif]> </table> </div>
                                                <!----------------------------->
                                                <!--FINAL DE LOS RESULTADOS DEL ASISTENTE PARA PUBLICAR COMO PÁGINA WEB DE
EXCEL-->
                                                <!----------------------------->
                                                </body> </html>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetDataByFiltrosReporte" TypeName="dsAjusteTableAdapters.ListaAjusteTableAdapter"
                                        OnSelected="ObjectDataSource1_Selected">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtAsegurado" Name="asegurado" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtFechaInicio" Name="fInicio" PropertyName="Text"
                                                Type="DateTime" />
                                            <asp:ControlParameter ControlID="txtFechaFin" Name="fFin" PropertyName="Text" Type="DateTime" />
                                            <asp:ControlParameter ControlID="cbxCia" Name="Idcia" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="cbxLiquidacion" Name="Idliquidacion" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="txtSiniestro" Name="siniestro" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="cbxAjustador" Name="Idajustador" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="cbxRamo" Name="Idramo" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="cbxProducto" Name="IdProducto" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="cbxCobertura" Name="IdCobertura" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="cbxEstatus" Name="Idestado" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="cbxBroker" Name="Idbroker" PropertyName="SelectedValue"
                                                Type="Decimal" />
                                            <asp:ControlParameter ControlID="txtNroSiniestroCia" Name="numsiniestroCia" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtNroSiniestroBroker" Name="numsiniestroBroker"
                                                PropertyName="Text" Type="String" />
                                            <asp:ControlParameter ControlID="txtNroAjuste" Name="numAjuste" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtPoliza" Name="numpoliza" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtEjecutivo" Name="ejecutivo" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtReservaEntre" Name="minreserva" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtReservaHasta" Name="maxreserva" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtDiasEntre" Name="mindia" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtDiasHasta" Name="maxdia" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtEjecutivoBroker" Name="ejecutivoBroker" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtEntre" Name="mindiaCambioEstado" PropertyName="Text"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="txtFin" Name="maxdiaCambioEstado" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.AjustadorComboTableAdapter">
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.BrokerComboTableAdapter"></asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsCia" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsTipoLiquidacion" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoAjusteComboTableAdapter">
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsEstatus" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.EstadoAjusteComboTableAdapter">
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsRamo" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.RamoComboTableAdapter"></asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsProducto" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.ProductoComboTableAdapter">
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="odsCobertura" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.RiesgoComboTableAdapter"></asp:ObjectDataSource>
                                    <br />
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
                </div>
            </td>
        </tr>
    </table>
</body>
</html>
