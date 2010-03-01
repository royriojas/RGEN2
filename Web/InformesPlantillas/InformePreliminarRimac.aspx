<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformePreliminarRimac.aspx.cs"
  Inherits="InformesPlantillas_InformePreliminarRimac" %>

<%@ Import Namespace="App_Code.RimacInforme.Domain" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<%@ Register Src="Caratula.ascx" TagName="Caratula" TagPrefix="uc5" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>INFORME PRELIMINAR</title>
  <link href='<%= ResolveUrl("~/InformesPlantillas/infRimac.css?nc=" + DateTime.Now.Ticks) %>'
    rel="Stylesheet" type="text/css" />
</head>
<body>
  <form id="_form1" runat="server">
  <div>
    <p class="DateSalute">
      Lima,
      <%= DateTime.Now.ToLongDateString() %></p>
    <h2 class="RimacLogo">
      RÍMAC
    </h2>
    <h3 class="RimacName">
      Compañía de Seguros y Reaseguros S.A.</h3>
    <p>
      Las Begonias N° 475 3er. Piso</p>
    <p class="Bold">
      Lima 27 - PERÚ</p>
    <p class="Bold">
      Att. : <span class="Underline">SR./</span></p>
    <p>
      &nbsp;</p>
    <uc5:Caratula ID="Caratula1" runat="server" />
    <div class="main">
      <h2 class="infPreliminarTitle">
        INFORME N° 1 PRELIMINAR</h2>
      <div class="ruler-divider doble">
      </div>
      <div class="ruler-divider">
      </div>
      <div class="infoSeccion">
        <h3>
          INFORMACIÓN GENERAL</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          LUGAR DEL SINIESTRO</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          BIEN(ES) SINIESTRADO(S)</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          ANTECEDENTES</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          OCURRENCIA</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          INVESTIGACIONES</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          DAÑOS</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          CAUSA</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          DETALLE DE LA PÓLIZA</h3>
        <div class="subSeccion">
          <h4>
            Materia Asegurada</h4>
        </div>
        <div class="subSeccion">
          <h4>
            Local Asegurado / Ubicación del Riesgo</h4>
        </div>
        <div class="subSeccion">
          <table>
            <tr>
              <td>
                <h4>
                  Cobertura Aplicable (RAMO)</h4>
              </td>
              <td>
                <h4>
                  Suma Asegurada</h4>
              </td>
            </tr>
          </table>
        </div>
        <div class="subSeccion">
          <h4>
            Sección</h4>
        </div>
        <div class="subSeccion">
          <h4>
            Deducible Aplicable</h4>
        </div>
        <div class="subSeccion">
          <h4>
            Cláusulas Aplicables</h4>
        </div>
      </div>
      <div class="infoSeccion">
        <h3>
          RECLAMO</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          COBERTURA</h3>
        <div class="subSeccion">
          <h4>
            Cumplimiento de Garantías / Prescripciones de Seguridad</h4>
        </div>
      </div>
      <div class="infoSeccion">
        <h3>
          RESERVA</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          SALVAMENTO / RECUPERO</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          MEDIDAS CORRECTIVAS</h3>
      </div>
      <div class="infoSeccion">
        <h3>
          SITUACIÓN ACTUAL</h3>
        <div class="subSeccion">
          <h4>
            Documentos solicitados</h4>
        </div>
      </div>
      <div class="infoSeccion">
        <h3>
          FOTOS</h3>
      </div>
    </div>
  </div>
  </form>
</body>
</html>
