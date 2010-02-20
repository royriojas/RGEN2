<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucHeader.ascx.cs" Inherits="ucHeader" %>

<script type="text/javascript" src="http://yui.yahooapis.com/2.4.1/build/yahoo-dom-event/yahoo-dom-event.js"></script>

<script type="text/javascript" src="Scripts/functions.js"></script>

<script type="text/javascript" src="Scripts/lib/x_core.js">
</script>

<script type="text/javascript" src="Scripts/lib/x_dom.js">
</script>

<script type="text/javascript" src="Scripts/lib/x_event.js">
</script>

<script type="text/javascript" src="Scripts/lib/xCaseOperations.js">
</script>

<link href="css/layout.css" rel="stylesheet" type="text/css" />

<script src="Scripts/AC_RunActiveContent.js" type="text/javascript"></script>

<script type="text/javascript">
  
  function _keepSessionHandler(res) 
    {
      try {
        var lastTryMessage = res.value;
        //addOptions('frmDatosVehiculo_cbxModelo',res.value);
        $('div_msg').innerHTML = lastTryMessage;        
        
      }
      catch(e) {
        alert('[ _keepSessionHandler ]: ' + e.message);
        $('div_msg').innerHTML = "";
      }
    }
    function __keepAlive() {
      try {        
        ucHeader.RefreshSession(_keepSessionHandler);
      }
      catch(e) {
        alert('[ _keepSessionHandler ]: ' + e.message);
        $('div_msg').innerHTML = "";
      }
    }
    function __KeepSessionAlive() {
        setInterval("__keepAlive()", 10 * 60 * 1000); 
    }
  
  xAddEventListener(window,'load',__KeepSessionAlive,true);
    
    
</script>

<div style="position: relative">
  <table id="TableHeader" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="56%">
        <div class="HeaderLeft">
          <br />
          <br />
          <br />
          <br />
          <br />
          <asp:Label ID="versionLabel" runat="server" Text="Versión 1.1" Font-Size="10px"></asp:Label>
        </div>
      </td>
      <td width="44%" align="right" valign="top">
        <div class="HeaderRight">

          <script type="text/javascript">
AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0','width','373','height','66','src','swf/rgen<%=setTime() %>','quality','high','pluginspage','http://www.macromedia.com/go/getflashplayer','wmode','transparent','movie','swf/rgen<%=setTime() %>' ); //end AC code
          </script>

          <noscript>
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
              width="373" height="66">
              <param name="movie" value="swf/rgen.swf<%=setTime() %>" />
              <param name="quality" value="high" />
              <param name="wmode" value="transparent" />
              <embed src="swf/rgen.swf<%=setTime() %>" width="373" height="66" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer"
                type="application/x-shockwave-flash" wmode="transparent"></embed>
            </object>
          </noscript>
        </div>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" id="TableMenuLink"
    style="height: 7px">
    <tr>
      <td style="height: 4px">
        <div id="MenuLink" style="margin-right: 2px">
          <div>
            <img id="MenuImgLeft" src="images/MainLeft.gif" width="5" height="25" alt="" /></div>
          <div>
            <a id="LnkAjuste" href="vListaAjuste.aspx" runat="server">Ajustes </a>
          </div>
          <div id="Sep1" class="separador" runat="server">
          </div>
          <div>
            <a id="LnkPoliza" href="vListaPolizas.aspx" runat="server">P&oacute;lizas</a></div>
          <div>
          </div>
          <div id="Sep3" class="separador" runat="server">
          </div>
          <div>
            <a id="lnkLibreriaPolizas" href="vClausulasComunes.aspx" runat="server" title="Librer&iacute;a de P&oacute;lizas">
              Librer&iacute;a de Cláusulas</a>
          </div>
          <div id="Sep6" class="separador" runat="server">
          </div>
          <div>
            <a id="LnkReportes" href="vReportes.aspx" runat="server" title="Emision de Reportes">
              Reportes</a>
          </div>
          <div id="Sep5" class="separador" runat="server">
          </div>
          <div>
            <a id="LnkEstadisticas" href="vEstadisticas.aspx" runat="server" title="Emision de Reportes">
              Estadísticas</a>
          </div>
          <div id="Sepx" class="separador" runat="server">
          </div>
          <div>
            <a id="LnkOpciones" href="vSubaccesos.aspx" runat="server" title="Opciones de Configuración">
              Opciones</a>
          </div>
          <div id="Sep4" class="separador" runat="server">
          </div>
          <div>
            <a id="lnkCerrarSesion" href="#" runat="server" title="Cerrar Sesi&oacute;n" onserverclick="lnkCerrarSesion_ServerClick">
              Cerrar Sesi&oacute;n</a>
          </div>
          <div id="Sep7" class="separador" runat="server">
          </div>
          <div style="float: right">
            <img src="images/MainRight.gif" width="5" height="25" alt="" /></div>
          <div style="float: right; height: 1px;">
          </div>
          <div class="textos" style="float: right">
            USUARIO:
            <%=NombreUsuario %>
            &nbsp;&nbsp;&nbsp;TIPO:<%=TipoUsuario %></div>
        </div>
      </td>
    </tr>
  </table>
  <div id='div_msg' style="float: right;">
  </div>
</div>
