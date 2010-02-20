<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vDetallesPoliza.aspx.cs" Inherits="vDetallesPoliza" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel='stylesheet' type='text/css' href='css/layout.css' />
    <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/v3.css' />
    
    <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_dyn.css'/>
    <title>Riesgos Generales | Detalles Póliza </title>

    <script type='text/javascript' src="Scripts/lib/x_core.js"></script>
    <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>
    <script type='text/javascript' src="Scripts/lib/xtabpanelgroup.js"></script>
    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

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
	  
	  var ifrm = xGetElementById('ifrmRegistroItemAsegurado');
	  ifrm.src = 'vRegistroItemAsegurado.aspx?AjusteId=<%=qStringAjusteId %>&PolizaId=<%=qStringPolizaId %>&tmstamp='+thisDate;
	  
	  ifrm = xGetElementById('ifrmRegistroDeducible');
	  ifrm.src = 'vRegistroDeducibles.aspx?AjusteId=<%=qStringAjusteId %>&PolizaId=<%=qStringPolizaId %>&tmstamp='+thisDate;
	  
	  ifrm = xGetElementById('ifrmRegistroClausula');
	  ifrm.src = 'vRegistroClausula.aspx?AjusteId=<%=qStringAjusteId %>&PolizaId=<%=qStringPolizaId %>&tmstamp='+thisDate;
	
//	  
//	  ifrm = xGetElementById('ifrmRegistroLimite');
//	  ifrm.src = 'vRegistroLimite.aspx?AjusteId=<%=qStringAjusteId %>&PolizaId=<%=qStringPolizaId %>&tmstamp='+thisDate; 	
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
    
    

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

</head>
<body style="background-color:#417EC2;background-image:none;">    
    	<form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; position: relative; width: 752px;height:540px;">
        
                
            <!-- paneles de Bitacora-->
            <div style="width: 752px;position: relative;">              
                <div >
                    <div >
                        <div>
                            <div id='tpg1' class='tabPanelGroup'>
                                <div class='tabGroup' style="position: relative;">
                                    <a id='lnkRegistroItemAsegurado' href='#RegistroItemAsegurado' class='tabDefault'>                                        
                                        <br />
                                        Items Asegurados<br />
                                                                              
                                  </a>
                                    <span class='linkDelim'>&nbsp;|&nbsp;</span> 
                                    <a id='lnkRegistroDeducible' href='#RegistroDeducible'
                                        class='tabDefault'>
                                        <br />
                                            Deducible<br />                                           
                                    </a>
                                    <span class='linkDelim'>&nbsp;|&nbsp;</span>
                                    <a id='lnkRegistroClausula' href='#RegistroClausula'
                                        class='tabDefault'>
                                        <br />
                                           Cláusulas<br />
                                            
                                    </a>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/IconPdf32Dark.gif"
                                        OnClick="ImageButton1_Click" Style="z-index: 103; left: 708px; position: absolute;
                                        top: 5px" ToolTip="Ver Póliza" />
                                    <%--<span class='linkDelim'>&nbsp;|&nbsp;</span> 
                                    <a id='lnkRegistroLimite' href='#RegistroLimite'
                                        class='tabDefault'>
                                        <br />
                                            Lìmites<br />
                                    </a>--%>
                              </div>
                                <div id='RegistroItemAsegurado' class='tabPanel'>
                                    <iframe id="ifrmRegistroItemAsegurado" scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%" ></iframe>
                                </div>
                                <div id='RegistroDeducible' class='tabPanel'>
                                    <iframe id="ifrmRegistroDeducible" scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%" ></iframe>
                                </div>
                                <div id='RegistroClausula' class='tabPanel'>
                                     <iframe id="ifrmRegistroClausula" scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%" ></iframe>
                                </div>
                                <%--<div id='RegistroLimite' class='tabPanel'>
                                    <iframe id="ifrmRegistroLimite" scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%" ></iframe>
                                </div>--%>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
