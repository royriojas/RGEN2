<%@ Control Language="C#" AutoEventWireup="true" CodeFile="linksAjustadorAdministrador.ascx.cs"
  Inherits="linksAjustadorAdministrador" %>
<link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
<div id="MenuSecundario" style="width: 800px">
  <a id="LnkRegistroAjuste" href="vNuevoCasoAjuste.aspx" runat="server">Nuevo Ajuste</a><span id="SepFinRegistroAjuste" runat="server"> | </span>
  <a id="lnkAjusteMinimo" href="vNuevoCaso.aspx" runat="server">Nuevo Caso (Registro Mínimo)</a> <span id="SepAjusteMinimo" runat="server"> | </span>
  <a id="LnkListaPendientes" href="vListaAjustesPendientes.aspx" runat="server">
        Mis Ajustes Pendientes</a> <span id="SepListasPendientes" runat="server">| </span>
  <a id="LnkListaAjustes" href="vListaAjuste.aspx" runat="server" visible="false">Lista
    de Ajustes</a> <span id="SepListaAjustes" runat="server" visible="false">| </span>
  <a id="LnkAsignarAjustador" href="vAsignarAjustador.aspx" runat="server">Asignar Ajustador
  </a><span id="SepListaAsignarAjustador" runat="server">| </span>
  <%--<a id="LnkParrafosComunes" href="vParrafosTitulosComunes.aspx"  runat="server">Títulos Comunes</a> --%>
  <%--<span id="SepTitulosComunes" runat="server"> | </span>--%>
  <a id="lnkControlCalidadAjustes" href="vListaControlCalidad.aspx" runat="server">Control
    de Calidad</a>
</div>
