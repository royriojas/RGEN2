<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vBitacoras.aspx.cs" Inherits="vBitacoras" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel='stylesheet' type='text/css' href='css/layout.css' />   
    <!--<link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_def.css' />-->
    <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_dyn.css' />
    <title>Riesgos Generales | Bitacoras </title>

    <script type='text/javascript' src="Scripts/lib/x_core.js"></script>

    <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>

    <script type='text/javascript' src="Scripts/lib/xtabpanelgroup.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script type="text/javascript" src="Scripts/functions.js"></script>

    <script type='text/javascript'>

    window.onload = function()
    {
        if (window.winOnLoad) window.winOnLoad();
    	
    }
    window.onunload = function()
    {
        if (window.winOnUnload) window.winOnUnload();
    }
    </script>

    <script type='text/javascript'>
    
var tpg1;

function recargaFrames() {
	  var thisDate = new Date();
	  
	  var ifrm = xGetElementById('ifrmRegistroComunicacion');
	  ifrm.src = 'vRegistroComunicacion.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
	  
	  ifrm = xGetElementById('ifrmRegistroActividad');
	  ifrm.src = 'vRegistroActividades.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
	  
	  ifrm = xGetElementById('ifrmRegistroAnexo');
	  ifrm.src = 'vRegistroAnexos.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate; 	
	  
	  ifrm = xGetElementById('ifrmRegistroGasto');
	  ifrm.src = 'vRegistrarGasto.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
	
	  
	  
}
function winOnLoad()
{
	try {
	    
	  tpg1 = new xTabPanelGroup('tpg1',742, 530, 40, 'tabPanel', 'tabGroup', 'tabDefault', 'tabSelected');
	  recargaFrames();
	
	  
	
	}
	catch(e) {
		alert(e.message + " " );
	}
}

window.onunload = function()
{
  if (tpg1) tpg1.onUnload();
}
    </script>

    <link href="Css/layout.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body >
    <form id="form1" runat="server">
        <!-- paneles de Bitacora-->
        <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
        </div>
        <div class="DataContent">
            <div class="DataContentRight" style="position:relative;">
                <div class="PanelEncabezado">
                    <asp:Label ID="Label1" runat="server" Font-Size="18px" Font-Bold="True" ForeColor="White">Bitácoras</asp:Label>
                    
                   </div>
                <div class="hr">
                </div>
                <div style="position: relative;">
                    <div id='tpg1' class='tabPanelGroup'>
                        <div class='tabGroup' style="position: relative; left: 0px; top: 3px;">
                            <a id='lnkRegistroComunicacion' href='#RegistroComunicacion' class='tabDefault'>
                                <br />
                                Comunicaciones<br />
                            </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkRegistroActividades' href='#RegistroActividades'
                                class='tabDefault'>
                                <br />
                                Actividades<br />
                            </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkRegistroAnexos' href='#RegistroAnexos'
                                class='tabDefault'>
                                <br />
                                Anexos<br />
                            </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkRegistroGastos' href='#RegistroGastos'
                                class='tabDefault'>
                                <br />
                                Gastos<br />
                            </a>
                        </div>
                        <div id='RegistroComunicacion' class='tabPanel'>
                            <iframe id="ifrmRegistroComunicacion" scrolling="auto" frameborder="0" style="border-width: 0px;
                                width: 100%; height: 100%"></iframe>
                        </div>
                        <div id='RegistroActividades' class='tabPanel'>
                            <iframe id="ifrmRegistroActividad" scrolling="auto" frameborder="0" style="border-width: 0px;
                                width: 100%; height: 100%"></iframe>
                        </div>
                        <div id='RegistroAnexos' class='tabPanel'>
                            <iframe id="ifrmRegistroAnexo" scrolling="auto" frameborder="0" style="border-width: 0px;
                                width: 100%; height: 100%"></iframe>
                        </div>
                        <div id='RegistroGastos' class='tabPanel'>
                            <iframe id="ifrmRegistroGasto" scrolling="auto" frameborder="0" style="border-width: 0px;
                                width: 100%; height: 100%"></iframe>
                        </div>
                    </div>
                </div>
                <br />
            </div>
        </div>
        <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
        </div>
    </form>
</body>
</html>
