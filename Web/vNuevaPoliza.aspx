<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vNuevaPoliza.aspx.cs" Inherits="vNuevaPoliza" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="linksPoliza.ascx" TagName="linksPoliza" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Registro de Póliza</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <!-- por alguna extraña razon cuando necesito tener una clase CSS de manera dinámica no puedo sacarla del archivo css
        vinculado. Debo ponerla en la pagina -->
    <style type="text/css">
    
        .deshabilitado {                       
	        color: #CCCCCC;
	        background-color: #CCCCCC;	
	        font-family:Verdana;	
	        border-top:1px solid #41778B;
	        border-right:1px solid #D6D3CE;
	        border-bottom:1px solid #D6D3CE;
	        border-left:1px solid #42758C;
	        font-size:10px;
	        background-image:url(../imgRGen/fondo_FormText.gif);
	        background-repeat:repeat-x;	
        }

    </style>

    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

    <script type="text/javascript" language="javascript"> 
		
	function deshabilitaCamposPersonaNatural(key) {
	    var clase = (key==1)? 'deshabilitado': 'FormText';
	    var habilitado = (key==1);
	    $('txtApellidoPaterno').className = clase;
	    $('txtApellidoPaterno').disabled = habilitado;
	    
	    $('txtApellidoMaterno').className = clase;	
	    $('txtApellidoMaterno').disabled = habilitado;
	    
	    $('txtSegundoNombre').className = clase;
	    $('txtSegundoNombre').disabled = habilitado;
	}
	
	function muestraOcultaPersonaJuridica(elemento) {
		
		
		deshabilitaCamposPersonaNatural(elemento.value); 
		
		
		var lblNombre = $('lblnombreRazonSocial');
		lblNombre.innerHTML = (elemento.value == 1)?"Razón Social":"Primer Nombre";
		
		var lbltelefono = $('lbltelefonoCasaOficina');
		lbltelefono.innerHTML = (elemento.value == 1)?"Telefono Oficina":"Telefono Casa";
		
		var lbldocIdentidad = $('lblDocumentoIdentidad');
		lbldocIdentidad.innerHTML = (elemento.value == 1)?"RUC":"DNI";
		
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
		
		//$('divGuardar').style.display = "inline";
		
	}
	window.onload = function () {
		ocultaMuestraNuevoAsegurado();
	}
	
	 function copiaAseguradoAContratante(ele) {
        var chk = document.getElementById('chkNuevoAsegurado');
        if ((!chk.checked)) {
            var asegurado = $('txtAsegurado');
            var contratante = $('txtContratante')
            contratante.value = asegurado.value;
            contratante.select();
            ele.onfocus = null;
        }
    }
	
	
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
                alert ('Debe elegir uno de los nombres que aparecen en el autocompletado o de lo contrario crear un nuevo usuario haciendo click en Registrar un Asegurado Nuevo');   
                $('txtAsegurado').className = 'FormTextVacio';
                $('txtAsegurado').focus();
                return false;
            }            
        }
        if ($('cbxProducto').value == -1) {
            alert('Escoja un Producto');
            return false;
        }
         if ($('cbxRamo').value == -1) {
            alert('Escoja un Ramo');
            return false;
        }
        if ($('cbxCobertura').value == -1) {
            alert('Escoja una Cobertura');
            return false;
        }
        if ($('cbxAseguradora').value == -1) {
            alert('Escoja una Aseguradora');
            return false;
        }
       
        if ($('cbxAseguradora').value == -1) {
            alert('Escoja una Aseguradora');
            return false;
        }       
      return true;                
    }
	   function simulaClick() {
        $('chkNuevoAsegurado').click();         
        $('btnNuevoAsegurado').value = (!$('chkNuevoAsegurado').checked)? 'Registrar un Asegurado Nuevo' : 'Registrar un Asegurado Antiguo' ;
        return false;
    }
    </script>

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

    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />   
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form2" runat="server">
        <div>
            <div id="ContenidoPagina" style="margin-left: auto; margin-right: auto; position: relative;
                width: 999px;">
                <div>
                    <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="poliza"/>
                    <uc2:linksPoliza ID="LinksPoliza" runat="server" />
                </div>
                <div class="DataTop">
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight">
                        <div>
                            <div>
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="18px" Text="Nueva Pólizas"></asp:Label>&nbsp;</div>
                            <div class="hr">
                            </div>
                            <div class="DataTable" style="padding: 10px; padding-bottom: 10px; position: relative;
                                background-color: #4b92c1;">
                                <div style="padding: 5px; position: relative; background-color: #3e76b4;" id="lblTitulo">
                                    <asp:Label ID="lblDatosPoliza" runat="server" Text="Datos de la Póliza" Font-Bold="True"
                                        Font-Size="18px"></asp:Label>
                                </div>
                                <div id="DatosPoliza" style="padding: 10px;" class="DataTable">
                                    &nbsp;<table width="900" border="0" cellspacing="0" cellpadding="0">
                                        <!--DWLayoutTable-->
                                        <tr>
                                            <td width="145" height="19">
                                                Aseguradora<asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="cbxAseguradora"
                                                    ErrorMessage="Elija Una" Operator="NotEqual" ValidationGroup="vlduno" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                                            <td width="265" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                <asp:DropDownList ID="cbxAseguradora" runat="server" DataSourceID="odsAseguradora"
                                                    DataTextField="persona" DataValueField="personaId" Width="248px" CssClass="FormText"
                                                    TabIndex="1" OnDataBound="cbxAseguradora_DataBound">
                                                </asp:DropDownList></td>
                                            <td width="165">
                                                Producto<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cbxProducto"
                                                    ErrorMessage="Elija Uno" Operator="NotEqual" ValueToCompare="-1" ValidationGroup="vlduno">(*)</asp:CompareValidator></td>
                                            <td width="325" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                <asp:DropDownList ID="cbxProducto" runat="server" CssClass="FormSelect" Width="250px"
                                                    DataSourceID="odsProducto" DataTextField="descripcion" DataValueField="productoid"
                                                    OnDataBound="cbxProducto_DataBound" TabIndex="7" OnSelectedIndexChanged="cbxProducto_SelectedIndexChanged" AutoPostBack="True">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                N&deg; de P&oacute;liza
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNumPoliza"
                                                    ErrorMessage="Ingrese el Número de Póliza o Escriba En Emisión" ValidationGroup="vlduno">(*)</asp:RequiredFieldValidator></td>
                                            <td>
                                                <asp:TextBox ID="txtNumPoliza" runat="server" CssClass="FormText" Width="244px" TabIndex="2"></asp:TextBox></td>
                                            <td>
                                                Ramo<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="cbxRamo"
                                                    ErrorMessage="Elija Uno" Operator="NotEqual" ValidationGroup="vlduno" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                                            <td>
                                                <asp:DropDownList ID="cbxRamo" runat="server" CssClass="FormSelect" Width="250px"
                                                    DataSourceID="sdsRamos" DataTextField="ramo" DataValueField="ramoId" OnDataBound="cbxRamo_DataBound"
                                                    TabIndex="8" AutoPostBack="True">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                Vigencia<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                    ControlToValidate="txtDesde" ErrorMessage="Ingrese el formato de fecha correcto dd/mm/yyyy"
                                                    ValidationExpression="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d"
                                                    ValidationGroup="vlduno">(*)</asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDesde"
                                                    ErrorMessage="Debe ingresar la vigencia" ValidationGroup="vlduno">(*)</asp:RequiredFieldValidator></td>
                                            <td>
                                                <table cellspacing="0" cellpadding="0" width="260" border="0">
                                                    <!--DWLayoutTable-->
                                                    <tbody>
                                                        <tr>
                                                            <td width="44" height="19" valign="middle">
                                                                Desde</td>
                                                            <td valign="middle" width="40">
                                                                &nbsp;
                                                                <button id="btnFechaInicio" tabindex="3" type="button" class="FormButton"><img height="16" alt="Escoja una fecha" src="img/cal.gif" width="16" border="0" /></button>
                                                            </td>
                                                            <td valign="middle" width="176">
                                                                <asp:TextBox ID="txtDesde" runat="server" CssClass="FormText" Width="160px" TabIndex="4"></asp:TextBox>

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
                                                        <tr>
                                                            <td height="19" valign="middle">
                                                                Hasta</td>
                                                            <td valign="middle">
                                                                &nbsp;
                                                                <button id="btnFechaFin" tabindex="5" type="button" class="FormButton"><img height="16" alt="Escoja una fecha" src="img/cal.gif" width="16" border="0" /></button>
                                                            </td>
                                                            <td valign="middle">
                                                                <asp:TextBox ID="txtHasta" runat="server" CssClass="FormText" Width="160px" TabIndex="6"></asp:TextBox>

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
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td valign="top" style="padding-top: 1px">
                                                Cobertura
                                                <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="cbxCobertura"
                                                    ErrorMessage="Elija Uno" Operator="NotEqual" ValidationGroup="vlduno" ValueToCompare="-1">(*)</asp:CompareValidator></td>
                                            <td valign="top" style="padding-top: 1px">
                                                <asp:DropDownList ID="cbxCobertura" runat="server" CssClass="FormSelect" Width="250px"
                                                    DataSourceID="Cobertura" DataTextField="nombre" DataValueField="riesgoId"
                                                    OnDataBound="cbxCobertura_DataBound" TabIndex="9">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td height="19">
                                                Giro de Negocio
                                            </td>
                                            <td>
                                                &nbsp;</td>
                                            <td valign="top">
                                                Grupo Econ&oacute;mico
                                            </td>
                                            <td>
                                                &nbsp;<asp:TextBox ID="fArchivo" Style="display: none" runat="server" Width="1px"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td height="19" colspan="2" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                <asp:TextBox Style="z-index: 10;" ID="txtGiroNegocio" runat="server" CssClass="FormText"
                                                    Height="60px" TextMode="MultiLine" Width="388px" TabIndex="10"></asp:TextBox></td>
                                            <td colspan="2" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                <asp:TextBox ID="txtGrupoEconomico" runat="server" CssClass="FormText" Height="60px"
                                                    TextMode="MultiLine" Width="412px" TabIndex="11"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td height="19">
                                                &nbsp;</td>
                                            <td>
                                            </td>
                                            <td valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                            <td>
                                                <asp:CheckBox Style="display: none;" onclick="ocultaMuestraNuevoAsegurado();" ID="chkNuevoAsegurado"
                                                    Text="Nuevo Asegurado" AccessKey="n" ToolTip="Define si esta registrando a un nuevo Asegurado"
                                                    TextAlign="right" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td height="19">
                                                Archivo Adjunto</td>
                                            <td>
                                                <asp:FileUpload ID="fupArchivo" runat="server" Width="245px" CssClass="FormText"
                                                    TabIndex="12" /></td>
                                            <td valign="top">
                                            </td>
                                            <td>
                                                <asp:Button ID="btnNuevoAsegurado" runat="server" Text="Registrar un Asegurado Nuevo"
                                                    CssClass="FormButton" OnClientClick="return simulaClick();" Width="253px" TabIndex="13" /></td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="padding: 5px; position: relative; background-color: #3e76b4;" id="lblDatosAsegurado">
                                    <asp:Label ID="Label2" runat="server" Text="Datos del Asegurado" Font-Bold="True"
                                        Font-Size="18px"></asp:Label>
                                </div>
                                <div id="contenedorNuevoAsegurado" style="padding: 10px; position: relative; z-index: 400;"
                                    class="DataTable">
                                    <table width="900" border="0" cellspacing="0" cellpadding="0">
                                        <!--DWLayoutTable-->
                                        <tr>
                                            <td width="145" style="height: 19px">
                                                Tipo
                                            </td>
                                            <td width="265" valign="top" style="height: 19px">
                                                <asp:RadioButtonList ID="rbgrpNaturalJuridica" runat="server" RepeatLayout="table"
                                                    RepeatDirection="Horizontal" Font-Bold="False" ForeColor="White" TabIndex="13">
                                                    <asp:ListItem Selected="True" onclick="muestraOcultaPersonaJuridica(this);" Value="0">Persona Natural</asp:ListItem>
                                                    <asp:ListItem Value="1" onclick="muestraOcultaPersonaJuridica(this);">Persona Jur&#237;dica</asp:ListItem>
                                                </asp:RadioButtonList></td>
                                            <td width="165" style="height: 19px">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                            <td width="325" valign="top" style="height: 19px">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="145" height="19">
                                                <span id="lblnombreRazonSocial">Primer Nombre </span>
                                            </td>
                                            <td width="265" valign="top">
                                                <asp:TextBox Width="244px" CssClass="FormText" ID="txtNombreRazonSocial" runat="server"
                                                    TextMode="SingleLine" TabIndex="14" /><!--DWLayoutEmptyCell--></td>
                                            <td width="165">
                                                Apellido Paterno
                                            </td>
                                            <td width="325" valign="top">
                                                <asp:TextBox Width="245px" CssClass="FormText" ID="txtApellidoPaterno" runat="server"
                                                    TextMode="SingleLine" TabIndex="16" /><!--DWLayoutEmptyCell--></td>
                                        </tr>
                                        <tr>
                                            <td width="145">
                                                Segundo Nombre
                                            </td>
                                            <td>
                                                <asp:TextBox Width="244px" CssClass="FormText" ID="txtSegundoNombre" runat="server"
                                                    TextMode="SingleLine" TabIndex="15" /></td>
                                            <td>
                                                Apellido Materno
                                            </td>
                                            <td>
                                                <asp:TextBox Width="245px" CssClass="FormText" ID="txtApellidoMaterno" runat="server"
                                                    TextMode="SingleLine" TabIndex="17" /></td>
                                        </tr>
                                        <tr>
                                            <td width="145">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                            <td>
                                                &nbsp;</td>
                                            <td>
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td width="145" height="19" style="height: 19px">
                                                <span id="lblDocumentoIdentidad">DNI/RUC</span></td>
                                            <td style="height: 19px">
                                                <asp:TextBox Width="244px" CssClass="FormText" ID="txtDNIRUC" runat="server" TextMode="SingleLine"
                                                    TabIndex="18" /></td>
                                            <td valign="top" style="height: 19px">
                                                <span id="lbltelefonoCasaOficina">Tel&eacute;fono Casa</span></td>
                                            <td style="height: 19px">
                                                <asp:TextBox Width="245px" CssClass="FormText" ID="txtTelefonoCasa" runat="server"
                                                    TextMode="SingleLine" TabIndex="21" /></td>
                                        </tr>
                                        <tr>
                                            <td width="145" height="19" style="height: 19px">
                                                Direcci&oacute;n</td>
                                            <td style="height: 19px">
                                                <asp:TextBox Width="244px" CssClass="FormText" ID="txtDireccion" runat="server" TextMode="SingleLine"
                                                    TabIndex="19" /></td>
                                            <td valign="top" style="height: 19px">
                                                Telefono Movil
                                            </td>
                                            <td style="height: 19px">
                                                <asp:TextBox Width="245px" CssClass="FormText" ID="txtTelefonoMovil" runat="server"
                                                    TextMode="SingleLine" TabIndex="22" /></td>
                                        </tr>
                                        <tr>
                                            <td width="145" height="19" style="height: 19px">
                                                Distrito - Prov. - Dpto.
                                            </td>
                                            <td style="height: 19px">
                                                <cc1:AutoSuggestBox ID="txtDistrito" runat="server" CssClass="FormText" DataType="Distrito"
                                                    MaxSuggestChars="18" ResourcesDir="./asb_includes" Width="244px" TabIndex="20"></cc1:AutoSuggestBox></td>
                                            <td valign="top" style="height: 19px">
                                                Referencia</td>
                                            <td style="height: 19px">
                                                <asp:TextBox Width="245px" CssClass="FormText" ID="txtReferencia" runat="server"
                                                    TextMode="SingleLine" TabIndex="23" /></td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="contenedorAsegurado" style="padding-left: 10px; padding-right: 10px; padding-top: 10px;
                                    position: relative; z-index: 400;" class="DataTable">
                                    <table width="900" border="0" cellspacing="0" cellpadding="0">
                                        <!--DWLayoutTable-->
                                        <tr>
                                            <td width="145" height="19">
                                                Asegurado</td>
                                            <td width="265" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                <cc1:AutoSuggestBox ID="txtAsegurado" runat="server" CssClass="FormText" DataType="Asegurado"
                                                    MaxSuggestChars="10" ResourcesDir="./asb_includes" Width="244px" TabIndex="14"></cc1:AutoSuggestBox></td>
                                            <td width="165">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                            <td width="325" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="padding-left: 10px; padding-right: 10px; padding-bottom: 10px; position: relative;"
                                    class="DataTable">
                                    <table width="900" border="0" cellspacing="0" cellpadding="0">
                                        <!--DWLayoutTable-->
                                        <tr>
                                            <td width="145" height="19">
                                                Contratante</td>
                                            <td width="265" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                <asp:TextBox Style="z-index: 10;" onfocus="copiaAseguradoAContratante(this);" ID="txtContratante"
                                                    runat="server" CssClass="FormText" Width="244px" TabIndex="25"></asp:TextBox></td>
                                            <td width="165">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                            <td width="325" valign="top">
                                                <!--DWLayoutEmptyCell-->
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div id="divGuardar" style="height: 81px; padding:10px;">
                        &nbsp;
                            <asp:ImageButton ToolTip="Guardar" 
                                OnClientClick="return valida();" ID="imgbtnSave" runat="server" ImageUrl="~/imgRGen/btnSave.gif"
                                OnClick="imgbtnSave_Click" ValidationGroup="vlduno" TabIndex="30" />
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
        <asp:ObjectDataSource ID="odsAseguradora" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsProducto" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsComboTableAdapters.ProductoComboTableAdapter">
        </asp:ObjectDataSource>
        &nbsp;
        <asp:ObjectDataSource ID="odsNueva" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaNuevaTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="cbxAseguradora" Name="aseguradoraid" PropertyName="SelectedValue"
                    Type="Decimal" />
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
                <asp:Parameter DefaultValue="-1" Name="ajusteId" Type="Decimal" />
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
        &nbsp;
        <asp:SqlDataSource ID="Cobertura" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
            SelectCommand="sp_rgenx_CoberturasByRamoId" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
                    Type="Decimal" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:ObjectDataSource ID="odsNuevaPersonaJuridica" runat="server" InsertMethod="Insert"
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaNuevaJuridicaTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="cbxAseguradora" Name="aseguradoraid" PropertyName="SelectedValue"
                    Type="Decimal" />
                <asp:ControlParameter ControlID="txtNumPoliza" Name="numeroPoliza" PropertyName="Text"
                    Type="String" />
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
                <asp:Parameter DefaultValue="-1" Name="ajusteId" Type="Decimal" />
                <asp:ControlParameter ControlID="fArchivo" Name="archivo" PropertyName="Text" Type="Object" />
            </InsertParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsNuevaPersonaNatural" runat="server" InsertMethod="Insert"
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaNuevaNaturalTableAdapter">
            <SelectParameters>
                <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="cbxAseguradora" Name="aseguradoraid" PropertyName="SelectedValue"
                    Type="Decimal" />
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
                <asp:Parameter DefaultValue="-1" Name="ajusteId" Type="Decimal" />
                <asp:ControlParameter ControlID="fArchivo" Name="archivo" PropertyName="Text" Type="Object" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </form>
</body>
</html>
