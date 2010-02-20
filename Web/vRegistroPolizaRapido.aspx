<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroPolizaRapido.aspx.cs"
    Inherits="vRegistroPolizaRapido" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
    <title>Registro Rápido de Póliza</title>
    <link href="Scripts/calendar/calendar-blue2.css" rel="Stylesheet" type="text/css" />

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

    <script type="text/javascript" language="javascript" src="Scripts/calendar/calendar-setup.js">
    </script>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>
    <script type="text/javascript" language="javascript"> 
    function valida() {
        
        if ($('chkNuevoAsegurado').checked) {
            if ($('txtNombreRazonSocial').value == "") {
                alert ('El campo Nombre o Razón Social no puede estar vacío cuando ha especificado\nla opción de registrar a un nuevo asegurado ');                   
                $('txtNombreRazonSocial').focus();
                $('txtNombreRazonSocial').className = 'FormTextVacio';
                return false;
            }            
        }
        else {
            if ($('txtAsegurado_SelectedValue').value == "") {
                alert ('Debe elegir uno de los nombres que aparecen en el autocompletado o de lo contrario crear un nuevo usuario haciendo click en nuevo usuario');   
                $('txtAsegurado').className = 'FormTextVacio';
                $('txtAsegurado').focus();
                return false;
            }            
        }
      return true;                
    }
    
	function muestraOcultaPersonaJuridica(elemento) {
		//alert(elemento.value);
		var  divDatosExtraPersona = $('contenedorPersonaNatural');
		divDatosExtraPersona.style.display = (elemento.value == 1)?"none":"block";
		
		var lblNombre = $('lblnombreRazonSocial');
		lblNombre.innerHTML = (elemento.value == 1)?"Razón Social":"Primer Nombre";
		
		var lbltelefono = $('lbltelefonoCasaOficina');
		lbltelefono.innerHTML = (elemento.value == 1)?"Telefono Oficina":"Telefono Casa";
		
		var lbldocIdentidad = $('lblDocumentoIdentidad');
		lbldocIdentidad.innerHTML = (elemento.value == 1)?"RUC":"DNI";
		
	}
	function cargaData() {
	    var datobuscado = $('txtAsegurado_SelectedValue').value;
	    utiles.ajax.gestorAjax.getEstadoAjuste(datobuscado).value;
	}

	function ocultaMuestraNuevoAsegurado() {
	
		var grupoNuevoAsegurado = $('contenedorNuevoAsegurado');
		var chk = $('chkNuevoAsegurado');
		
		grupoNuevoAsegurado.style.visibility = (chk.checked)?"visible":"hidden";
		grupoNuevoAsegurado.style.display = (chk.checked)?"block":"none";
//		grupoNuevoAsegurado.style.height = (chk.checked)?"300px":"0px";
		
		
		var asegurado = $('contenedorAsegurado');
		asegurado.style.visibility = (!chk.checked)?"visible":"hidden";
	//	asegurado.style.height = (!chk.checked)?"60px":"0px";
		asegurado.style.display = (!chk.checked)?"block":"none";
		
		
	}
	window.onload = function () {
	    if (<%=huboPostBack %>) {
	       window.top.reload();
           window.top.hidePopWin(true);
        } else {
              ocultaMuestraNuevoAsegurado();	
              	
        }
	}
    </script>

    

    <script language="javascript" type="text/javascript"> 
    
    function copiaAseguradoAContratante(ele) {
        var chk = $('chkNuevoAsegurado');
        if ((!chk.checked)) {
            var asegurado = $('txtAsegurado');
            var contratante = $('txtContratante')
            contratante.value = asegurado.value;
            contratante.select();
            ele.onfocus = null;
        }
    }
    
    function cierraVentana(polizaid,polizanumero,personaId,personaNombre,contratante,ramo,ramoId) {
        
        if (typeof(window.top.ifrmRegistroInicial) != 'undefined'){
            window.top.ifrmRegistroInicial.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo,ramoId);        
            window.top.ifrmRegistroInicial.hidePopWin(true);
        }
        else {
            window.top.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo,ramoId);          
            window.top.hidePopWin(true);
            
        }
    }        
    function simulaClick() {
        $('chkNuevoAsegurado').click();         
        $('btnNuevoAsegurado').value = (!$('chkNuevoAsegurado').checked)? 'Antiguo Asegurado' : 'Nuevo Asegurado' ;
        return false;
    }
    </script>

  

    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server">
        <div style="width:611px; overflow: auto; position: relative; height: 478px;" >
            <div id="ContenidoPagina" style="width: 540px;">
                <div class="DataTop">
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight">
                        <div>
                            <asp:Label ID="Label1" Text="Registro Rápido de Pólizas" Font-Bold="true" Font-Size="16px"
                                runat="server"></asp:Label>
                        </div>
                        <div class="hr">
                        </div>
                        <div style="position: relative; background-color: #4b92c1;">
                            <div style="position: relative;">
                                <table class="DataTable" width="520" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="height: 20px">
                                            &nbsp;</td>
                                        <td style="width: 127px;">
                                            &nbsp;</td>
                                        <td style="height: 20px">
                                            &nbsp;</td>
                                        <td style="height: 20px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="20">
                                            &nbsp;</td>
                                        <td height="20" style="width: 127px">
                                            N&uacute;mero P&oacute;liza
                                        </td>
                                        <td height="20">
                                            <asp:TextBox ID="txtNumPoliza" runat="server" CssClass="FormText" Width="250px"></asp:TextBox></td>
                                        <td width="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 20px">
                                            &nbsp;</td>
                                        <td style="width: 127px; height: 20px;">
                                            &nbsp;</td>
                                        <td style="height: 20px">
                                            <asp:CheckBox style="display:none;"
                                             onclick="ocultaMuestraNuevoAsegurado();" ID="chkNuevoAsegurado" Text="Nuevo Asegurado"
                                                AccessKey="n" ToolTip="Define si esta registrando a un nuevo Asegurado" TextAlign="right"
                                                runat="server" />
                                            <asp:Button ID="btnNuevoAsegurado" runat="server" Text="Nuevo Asegurado" CssClass="FormButton" OnClick="btnNuevoAsegurado_Click" OnClientClick="return simulaClick();" Width="153px" /></td>
                                        <td style="height: 20px">
                                            &nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                            <div id="contenedorAsegurado" style="position: relative; z-index: 300;">
                                <table class="DataTable" width="520" border="0" cellspacing="0" cellpadding="0" style="left: 0px;
                                    top: 0px">
                                    <tr>
                                        <td style="height: 16px" width="20">
                                        </td>
                                        <td style="width: 151px; height: 16px">
                                        </td>
                                        <td style="height: 16px" width="390">
                                        </td>
                                        <td style="height: 16px" width="20">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20">
                                            &nbsp;</td>
                                        <td style="width: 151px">
                                            &nbsp;Asegurado</td>
                                        <td width="390">
                                            <cc1:AutoSuggestBox ID="txtAsegurado" runat="server" CssClass="FormText" DataType="Asegurado"
                                                MaxSuggestChars="10" ResourcesDir="./asb_includes" Width="250px"></cc1:AutoSuggestBox></td>
                                        <td width="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 20px">
                                            &nbsp;</td>
                                        <td style="width: 151px;">
                                            </td>
                                        <td valign="top">
                                            </td>
                                        <td style="height: 20px">
                                            &nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                            <div id="contenedorNuevoAsegurado" style="z-index: 10;">
                                <table width="520" border="0" cellspacing="0" cellpadding="0" style="left: 0px;
                                    top: 0px">
                                    <tr>
                                        <td width="20">
                                            &nbsp;</td>
                                        <td style="width: 156px">
                                            &nbsp;</td>
                                        <td width="390">
                                            &nbsp;</td>
                                        <td width="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="20">
                                            &nbsp;</td>
                                        <td style="width: 156px">
                                        </td>
                                        <td width="390">
                                            <asp:RadioButtonList ID="rbgrpNaturalJuridica" runat="server" RepeatLayout="table"
                                                RepeatDirection="Horizontal" Font-Bold="True">
                                                <asp:ListItem Selected="True" onclick="muestraOcultaPersonaJuridica(this);"  Value="0">Persona Natural</asp:ListItem>
                                                <asp:ListItem onclick="muestraOcultaPersonaJuridica(this);"  Value="1">Persona Jur&#237;dica</asp:ListItem>
                                            </asp:RadioButtonList></td>
                                        <td width="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="20" style="height: 18px">
                                            &nbsp;</td>
                                        <td style="width: 156px; height: 18px;">
                                            <span id='lblnombreRazonSocial'>Primer Nombre </span>
                                        </td>
                                        <td width="390" style="height: 18px">
                                            <asp:TextBox Width="250px" CssClass="FormText" ID="txtNombreRazonSocial" runat="server"
                                                TextMode="SingleLine" /></td>
                                        <td width="20" style="height: 18px">
                                            &nbsp;</td>
                                    </tr>
                                </table>
                                <div id="contenedorPersonaNatural" style="z-index: 10;">
                                    <table width="520" border="0" cellpadding="0" cellspacing="0" style="left: 0px;
                                        top: 0px">
                                        <tr>
                                            <td width="20" style="height: 20px">
                                                &nbsp;</td>
                                            <td style="width: 154px; height: 20px;">
                                                Segundo Nombre
                                            </td>
                                            <td width="390" style="height: 20px">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtSegundoNombre" runat="server"
                                                    TextMode="SingleLine" /></td>
                                            <td width="20" style="height: 20px">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="20" height="20">
                                                &nbsp;</td>
                                            <td height="20" style="width: 154px">
                                                Apellido Paterno
                                            </td>
                                            <td width="390" height="20">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtApellidoPaterno" runat="server"
                                                    TextMode="SingleLine" /></td>
                                            <td width="20" height="20">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="20" style="height: 20px">
                                                &nbsp;</td>
                                            <td style="width: 154px;">
                                                Apellido Materno
                                            </td>
                                            <td width="390" style="height: 20px">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtApellidoMaterno" runat="server"
                                                    TextMode="SingleLine" /></td>
                                            <td width="20" style="height: 20px">
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="z-index: 10; position: relative;">
                                    <table width="520" border="0" cellpadding="0" cellspacing="0" style="left: 0px;
                                        top: 0px">
                                        <tr>
                                            <td width="20" style="height: 20px">
                                                &nbsp;</td>
                                            <td style="width: 150px;">
                                                <span id="lbltelefonoCasaOficina">Tel&eacute;fono Casa</span>
                                            </td>
                                            <td width="390" style="height: 20px">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtTelefonoCasa" runat="server"
                                                    TextMode="SingleLine" /></td>
                                            <td width="20" style="height: 20px">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="20" height="20">
                                                &nbsp;</td>
                                            <td height="20" style="width: 150px">
                                                Telefono Movil
                                            </td>
                                            <td width="390" height="20">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtTelefonoMovil" runat="server"
                                                    TextMode="SingleLine" /></td>
                                            <td width="20" height="20">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="20" height="20">
                                                &nbsp;</td>
                                            <td height="20" style="width: 150px">
                                                <span id="lblDocumentoIdentidad">DNI/RUC</span>
                                            </td>
                                            <td width="390" height="20">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtDNIRUC" runat="server" TextMode="SingleLine" /></td>
                                            <td width="20" height="20">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td height="20">
                                                &nbsp;</td>
                                            <td height="20" style="width: 150px">
                                                Direcci&oacute;n</td>
                                            <td height="20">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtDireccion" runat="server" TextMode="SingleLine" /></td>
                                            <td height="20">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px">
                                                &nbsp;</td>
                                            <td style="width: 150px;">
                                                Distrito - Prov. - Dpto.
                                            </td>
                                            <td style="height: 20px">
                                                <cc1:AutoSuggestBox ID="txtDistrito" runat="server" CssClass="FormText" DataType="Distrito"
                                                    MaxSuggestChars="18" ResourcesDir="./asb_includes" Width="250px"></cc1:AutoSuggestBox>
                                            </td>
                                            <td style="height: 20px">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px">
                                                &nbsp;
                                            </td>
                                            <td style="width: 150px;">
                                                Referencia</td>
                                            <td style="height: 20px">
                                                <asp:TextBox Width="250px" CssClass="FormText" ID="txtReferencia" runat="server"
                                                    TextMode="SingleLine" /></td>
                                            <td style="height: 20px">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px">
                                            </td>
                                            <td style="width: 150px">
                                            </td>
                                            <td style="height: 20px">
                                            </td>
                                            <td style="height: 20px">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div style="position: relative;">
                                <table class="DataTable" width="520" border="0" cellpadding="0" cellspacing="0" style="left: 0px;
                                    top: 0px">
                                    <tr>
                                        <td width="20" style="height: 33px">
                                            &nbsp;</td>
                                        <td style="width: 150px; height: 33px;">
                                            Contratante</td>
                                        <td style="width: 390px; height: 33px;">
                                            <asp:TextBox Style="z-index: 10;" onfocus="copiaAseguradoAContratante(this);" ID="txtContratante"
                                                runat="server" CssClass="FormText" Width="250px"></asp:TextBox></td>
                                        <td width="20" style="height: 33px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 50px">
                                            &nbsp;</td>
                                        <td style="width: 150px; height: 50px;">
                                            Giro de Negocio
                                        </td>
                                        <td style="width: 390px; height: 50px;">
                                            <asp:TextBox Style="z-index: 10;" ID="txtGiroNegocio" runat="server" CssClass="FormText"
                                                Height="35px" TextMode="MultiLine" Width="250px"></asp:TextBox></td>
                                        <td style="height: 50px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 50px">
                                            &nbsp;
                                        </td>
                                        <td style="width: 150px; height: 50px;">
                                            Grupo Econ&oacute;mico
                                        </td>
                                        <td style="width: 390px; height: 50px;">
                                            <asp:TextBox ID="txtGrupoEconomico" runat="server" CssClass="FormText" Height="35px"
                                                TextMode="MultiLine" Width="250px"></asp:TextBox></td>
                                        <td style="height: 50px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="20">
                                            &nbsp;</td>
                                        <td height="20" style="width: 150px">
                                            Vigencia<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDesde"
                                                ErrorMessage="Debe ingresar la vigencia" ValidationGroup="vlduno">(*)</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDesde"
                                                ErrorMessage="Ingrese el formato de fecha correcto dd/mm/yyyy" ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"
                                                ValidationGroup="vlduno">(*)</asp:RegularExpressionValidator></td>
                                        <td height="20" style="width: 390px">
                                            <table class="DataTable" width="260" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="height: 18px; width: 40px;">
                                                        desde
                                                    </td>
                                                    <td style="height: 18px; width: 29px;">
                                                        <button tabindex="7" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaInicio">
                                                            <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                                                width="16" /></button>
                                                    </td>
                                                    <td width="181" style="height: 18px">
                                                        <asp:TextBox ID="txtDesde" runat="server" CssClass="FormText" Width="173px"></asp:TextBox>

                                                        <script type="text/javascript">
                                                        
                                                        function getFoco(cal) {
                                                            var date = cal.date;
                                                            var time = date.getTime();
                                                            time += Date.YEAR; 
                                                            var date2 = new Date(time);
                                                            
                                                            $('txtHasta').value = date2.print('%d/%m/%Y'); 
                                                            
                                                                                                                          
                                                            p = cal.params;
                                                            p.inputField.focus();
                                                            p.inputField.select();
                                                            cal.hide();
                                                                                                                                          
                                                        }
                                                        
                                                          Calendar.setup({
                                                                inputField     :    'txtDesde',
                                                                ifFormat       :    '%d/%m/%Y',
                                                                button         :    'btnFechaInicio',
                                                                showsTime      :    false,                                                                        
                                                                singleClick    :    false,
                                                                onClose        :    getFoco
                                                            });                                                                                                                                    
                                            
                                                        </script>

                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="20">
                                            &nbsp;</td>
                                        <td height="20" style="width: 150px">
                                            &nbsp;</td>
                                        <td height="20" style="width: 390px">
                                            <table class="DataTable" width="260" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td style="width: 40px">
                                                        Hasta</td>
                                                    <td style="width: 30px">
                                                        <button tabindex="7" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaFin">
                                                            <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                                                width="16" /></button>
                                                    </td>
                                                    <td width="186">
                                                        <asp:TextBox ID="txtHasta" runat="server" CssClass="FormText" Width="173px"></asp:TextBox>

                                                        <script type="text/javascript">
                                          Calendar.setup({
                                                inputField     :    'txtHasta',
                                                ifFormat       :    '%d/%m/%Y',
                                                button         :    'btnFechaFin',
                                                showsTime      :    false,                                                                        
                                                singleClick    :    false
                                            }); 
                                                                                                                                    
                                            
                                                        </script>

                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="20">
                                            &nbsp;</td>
                                        <td height="20" style="width: 150px">
                                            Producto</td>
                                        <td height="20" style="width: 390px">
                                            <asp:DropDownList ID="cbxProducto" runat="server" CssClass="FormSelect" Width="250px"
                                                DataSourceID="odsProducto" DataTextField="descripcion" DataValueField="productoid" OnDataBound="cbxProducto_DataBound" AutoPostBack="True">
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="odsProducto" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetData" TypeName="dsComboTableAdapters.ProductoComboTableAdapter">
                                            </asp:ObjectDataSource>
                                        </td>
                                        <td height="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="20">
                                            &nbsp;</td>
                                        <td height="20" style="width: 150px">
                                            <span style="height: 22px">Ramo</span></td>
                                        <td height="20" style="width: 390px">
                                            <span style="height: 22px">
                                                <asp:DropDownList ID="cbxRamo" runat="server" CssClass="FormSelect" Width="250px"
                                                    DataSourceID="sdsRamos" DataTextField="ramo" DataValueField="ramoId" OnDataBound="cbxRamo_DataBound" AutoPostBack="True">
                                                </asp:DropDownList>&nbsp;
                                            </span>
                                        </td>
                                        <td height="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="20">
                                            &nbsp;</td>
                                        <td height="20" style="width: 150px">
                                            Cobertura</td>
                                        <td height="20" style="width: 390px">
                                            <asp:DropDownList ID="cbxCobertura" runat="server" CssClass="FormSelect" Width="250px"
                                                DataSourceID="Cobertura" DataTextField="nombre" DataValueField="riesgoId" OnDataBound="cbxCobertura_DataBound">
                                            </asp:DropDownList>&nbsp;
                                        </td>
                                        <td height="20">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="20">
                                        </td>
                                        <td height="20" style="width: 150px">
                                            Archivo Adjunto</td>
                                        <td height="20" style="width: 390px">
                                            <asp:FileUpload ID="fupArchivo" runat="server" Width="250px" CssClass="FormText" />
                                            <asp:TextBox ID="fArchivo" Style="display: none" runat="server" Width="1px"></asp:TextBox></td>
                                        <td height="20">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="20">
                                        </td>
                                        <td height="20" style="width: 150px">
                                        </td>
                                        <td height="20" style="width: 390px">
                                        </td>
                                        <td height="20">
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div style="height: 55px; position: relative;">
                                <div style="position: absolute; bottom: 0px; right: 10px;">
                                    <asp:ImageButton OnClientClick="return valida();" ID="imgbtnSave" runat="server" ImageUrl="~/imgRGen/btnSave.gif"
                                        OnClick="imgbtnSave_Click" ValidationGroup="vlduno" />
                                </div>
                                <asp:ObjectDataSource ID="odsNuevaPersonaJuridica" runat="server" InsertMethod="Insert"
                                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaNuevaJuridicaTableAdapter"
                                    OnInserted="odsNuevaPersonaJuridica_Inserted">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:QueryStringParameter Name="aseguradoraid" QueryStringField="AseguradoraId" Type="Decimal" />
                                        <asp:ControlParameter Name="numeroPoliza" Type="String" ControlID="txtNumPoliza"
                                            PropertyName="Text" />
                                        <asp:ControlParameter ControlID="txtNombreRazonSocial" Name="RazonSocial" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtTelefonoCasa" Name="telefonoOficina" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtTelefonoMovil" Name="telefonomovil" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtContratante" Name="contratante" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtGiroNegocio" Name="GirodeNegocio" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtGrupoEconomico" Name="GrupoEconomico" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtDNIRUC" Name="RUC" PropertyName="Text" Type="String" />
                                        <asp:ControlParameter ControlID="txtDireccion" Name="Direccion" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtDistrito" Name="ubigeoid" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtReferencia" Name="referencia" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtDesde" Name="FechaInicio" PropertyName="Text"
                                            Type="DateTime" />
                                        <asp:ControlParameter ControlID="txtHasta" Name="FechaFin" PropertyName="Text" Type="DateTime" />
                                        <asp:ControlParameter ControlID="cbxProducto" Name="Productoid" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="cbxRamo" Name="ramoid" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="cbxCobertura" Name="cobertura" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
                                        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                                        <asp:ControlParameter ControlID="fArchivo" Name="archivo" PropertyName="Text" Type="Object" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                                <asp:ObjectDataSource ID="odsNuevaPersonaNatural" runat="server" InsertMethod="Insert"
                                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaNuevaNaturalTableAdapter"
                                    OnInserted="odsNuevaPersonaJuridica_Inserted">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:QueryStringParameter Name="aseguradoraid" QueryStringField="AseguradoraId" Type="Decimal" />
                                        <asp:ControlParameter ControlID="txtNumPoliza" Name="numeroPoliza" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtNombreRazonSocial" Name="PrimerNombre" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtSegundoNombre" Name="SegundoNombre" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtApellidoPaterno" Name="ApellidoPaterno" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtApellidoMaterno" Name="ApellidoMaterno" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtTelefonoCasa" Name="telefonocasa" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtTelefonoMovil" Name="telefonomovil" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtContratante" Name="contratante" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtGiroNegocio" Name="GirodeNegocio" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtGrupoEconomico" Name="GrupoEconomico" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtDNIRUC" Name="DNI" PropertyName="Text" Type="String" />
                                        <asp:ControlParameter ControlID="txtDireccion" Name="Direccion" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtDistrito" Name="ubigeoid" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtReferencia" Name="referencia" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtDesde" Name="FechaInicio" PropertyName="Text"
                                            Type="DateTime" />
                                        <asp:ControlParameter ControlID="txtHasta" Name="FechaFin" PropertyName="Text" Type="DateTime" />
                                        <asp:ControlParameter ControlID="cbxProducto" Name="Productoid" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="cbxRamo" Name="ramoid" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="cbxCobertura" Name="cobertura" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
                                        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                                        <asp:ControlParameter ControlID="fArchivo" Name="archivo" PropertyName="Text" Type="Object" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                                <asp:SqlDataSource ID="sdsRamos" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                                    SelectCommand="sp_rgenx_RamosSelectByProductoId" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="cbxProducto" Name="productoId" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="Cobertura" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                                    SelectCommand="sp_rgenx_CoberturasByRamoId" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:ObjectDataSource ID="odsNueva" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                                    SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaNuevaTableAdapter"
                                    OnInserted="odsNuevaPersonaJuridica_Inserted">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:QueryStringParameter Name="aseguradoraid" QueryStringField="AseguradoraId" Type="Decimal" />
                                        <asp:ControlParameter ControlID="txtNumPoliza" Name="numeroPoliza" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtAsegurado" Name="aseguradoid" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="txtContratante" Name="contratante" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtGiroNegocio" Name="GirodeNegocio" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtGrupoEconomico" Name="GrupoEconomico" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtDesde" Name="FechaInicio" PropertyName="Text"
                                            Type="DateTime" />
                                        <asp:ControlParameter ControlID="txtHasta" Name="FechaFin" PropertyName="Text" Type="DateTime" />
                                        <asp:ControlParameter ControlID="cbxProducto" Name="Productoid" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="cbxRamo" Name="ramoid" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="cbxCobertura" Name="cobertura" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
                                        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                                        <asp:ControlParameter ControlID="fArchivo" Name="archivo" PropertyName="Text" Type="Object" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </div>
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
        </div>
    </form>
</body>
</html>
