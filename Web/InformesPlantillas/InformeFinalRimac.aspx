<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformeFinalRimac.aspx.cs"
  Inherits="InformesPlantillas_InformeFinal" %>

<%@ Import Namespace="App_Code.RimacInforme.Domain" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<%@ Register Src="~/RimacInforme/Deducibles.ascx" TagName="Deducibles" TagPrefix="uc2" %>
<%@ Register Src="~/RimacInforme/Clausulas.ascx" TagName="Clausulas" TagPrefix="uc3" %>
<%@ Register Src="~/RimacInforme/Damage.ascx" TagName="Damage" TagPrefix="uc4" %>
<%@ Register Src="Caratula.ascx" TagName="Caratula" TagPrefix="uc5" %>
<%@ Register Src="../RimacInforme/DocumentacionSolicitada.ascx" TagName="DocumentacionSolicitada"
  TagPrefix="uc1" %>
<%@ Register Src="../RimacInforme/Fotos.ascx" TagName="Fotos" TagPrefix="uc6" %>
<%@ Register Src="TitulosAdicionales.ascx" TagName="TitulosAdicionales" TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>INFORME FINAL</title>
  <link href='<%= ResolveUrl("~/InformesPlantillas/infRimac.css?nc=" + DateTime.Now.Ticks) %>'
    rel="Stylesheet" type="text/css" />

  <script type="text/javascript" src='<%= ResolveUrl("~/RimacInforme/scripts/jquery.js")  %>'></script>

  <script type="text/javascript">
    $(function() {
      $('.infoSeccion>h3, .subSeccion>h4').each(function() {
        if ($(this).next().length <= 0) $(this).remove();
        else if ($(this).next().is('.subSeccion')) $(this).remove();
      });
    });
  </script>

</head>
<body>
  <form id="_form1" runat="server">
  <div>
    <asp:ObjectDataSource ID="odsInforme" runat="server" DataObjectTypeName="App_Code.RimacInforme.Domain.AjusteDto"
      OldValuesParameterFormatString="{0}" SelectMethod="GetInformeBasicoByAjusteId"
      TypeName="App_Code.RimacInforme.Persistence.AjusteDtoOds">
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="-1" Name="ajusteId" QueryStringField="AjusteId"
          Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="FormViewInforme" DataKeyNames="AjusteId" Width="100%" runat="server"
      DefaultMode="ReadOnly" DataSourceID="odsInforme">
      <ItemTemplate>
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
            INFORME FINAL             
          </h2>
          <div class="ruler-divider doble">
          </div>
          <div class="ruler-divider">
          </div>
          <div class="InfoGroup" id="_groupIPreliminar" runat="server">
            <div class="infoSeccion">
              <h3>
                INFORMACIÓN GENERAL</h3>
              <%#((AjusteDto) Container.DataItem).DescripcionRiesgo %>
            </div>
            <div class="infoSeccion">
              <h3>
                LUGAR DEL SINIESTRO</h3>
              <%#((AjusteDto) Container.DataItem).DescripcionLugarSiniestro%>
            </div>
            <div class="infoSeccion">
              <h3>
                BIEN(ES) SINIESTRADO(S)</h3>
              <%#((AjusteDto) Container.DataItem).DescripcionBienesAfectados %>
            </div>
            <div class="infoSeccion">
              <h3>
                ANTECEDENTES</h3>
              <%#((AjusteDto) Container.DataItem).Antecedentes
              %>
            </div>
            <div class="infoSeccion">
              <h3>
                OCURRENCIA</h3>
              <%#((AjusteDto) Container.DataItem).Ocurrencia
              %>
            </div>
            <div class="infoSeccion">
              <h3>
                INVESTIGACIONES</h3>
              <%#((AjusteDto) Container.DataItem).Investigaciones
              %>
            </div>
            <div class="infoSeccion">
              <h3>
                DAÑOS</h3>
              <!-- //TODO Check this -->
              <%#((AjusteDto) Container.DataItem).DescripcionDamage 
              %>
            </div>
            <div class="infoSeccion">
              <h3>
                CAUSA</h3>
              <%#((AjusteDto) Container.DataItem).CausasSiniestro
              %>
            </div>
            <div class="infoSeccion">
              <h3>
                DETALLE DE LA PÓLIZA</h3>
              <p>
                A continuación resumimos la Póliza N°<%# ((AjusteDto) Container.DataItem).Poliza.PolizaNumber %>
                contratada por el Asegurado,
                <%# ((AjusteDto) Container.DataItem).InfoAsegurado.Asegurado%>
                , cuya vigencia es
                <%# ((AjusteDto) Container.DataItem).Poliza.Vigencia %>
                :</p>
              <div class="subSeccion">
                <h4>
                  Materia Asegurada</h4>
                <%# ((AjusteDto) Container.DataItem).MateriaAsegurada %>
              </div>
              <div class="subSeccion">
                <h4>
                  Local Asegurado / Ubicación del Riesgo</h4>
                <%# ((AjusteDto) Container.DataItem).LocalAsegurado %>
                <!-- TODO -->
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
                  <tr>
                    <td>
                      <%# ((AjusteDto) Container.DataItem).Poliza.Cobertura %>
                    </td>
                    <td>
                      <!-- //TODO Check this -->
                      <%# ((AjusteDto) Container.DataItem).SumaAsegurada 
                      
                      %>
                    </td>
                  </tr>
                </table>
              </div>
              <div class="subSeccion">
                <h4>
                  Sección</h4>
                <%# ((AjusteDto) Container.DataItem).Seccion %>
              </div>
              <div class="subSeccion">
                <h4>
                  Deducible Aplicable</h4>
                <uc2:Deducibles ID="Deducibles1" runat="server" />
              </div>
              <div class="subSeccion">
                <h4>
                  Cláusulas Aplicables</h4>
                <uc3:Clausulas ID="Clausulas1" runat="server" />
              </div>
            </div>
            <div class="infoSeccion">
              <h3>
                RECLAMO</h3>
              <p>
                El Asegurado ha estimado su reclamo en un monto de
                <%# ((AjusteDto) Container.DataItem).MonedaReclamoSimbolo %>
                <%# ((AjusteDto) Container.DataItem).Reclamo %></p>
                <%# ((AjusteDto) Container.DataItem).DescripcionReclamo %>
                
            </div>
            <div class="infoSeccion">
              <h3>
                COBERTURA</h3>
              <%# ((AjusteDto) Container.DataItem).OpinionAjustador %>
              <div class="subSeccion">
                <h4>
                  Cumplimiento de Garantías / Prescripciones de Seguridad</h4>
                <%# ((AjusteDto) Container.DataItem).VerificacionGarantias %>
              </div>
            </div>
            <%-- <div class="infoSeccion">
              <h3>
                DETALLE DE LA PÉRDIDA Y AJUSTE</h3>
              <p>
                Luego de evaluar los documentos de sustento remitidos por el Asegurado, hemos establecido
                la siguiente liquidación
              </p>
              <%# ((AjusteDto) Container.DataItem).de %>
            </div>--%>
            <div class="infoSeccion">
              <h3>
                SALVAMENTO / RECUPERO</h3>
              <%# ((AjusteDto) Container.DataItem).Salvamentoyrecupero %>
            </div>
            <div class="infoSeccion">
              <h3>
                MEDIDAS CORRECTIVAS</h3>
              <%# ((AjusteDto) Container.DataItem).Recomendaciones  %>
            </div>
          </div>
          <div class="infoSeccion" id="_groupIPreliminar2" runat="server">
            <h3>
              FOTOS</h3>
            <uc6:Fotos ID="Fotos1" runat="server" />
          </div>
          <div class="infoSeccion">
            <h3 style="text-align: center; text-decoration: underline;">
              Resumen del Caso</h3>
            <table class="GridView Grid" cellspacing="0" cellpadding="0" border="0">
              <tbody>
                <tr class="header">
                  <th valign="top">
                    <p class="bold">
                      Fecha de Asignación</p>
                  </th>
                  <th valign="top">
                    <p class="bold">
                      Fecha de Inspección</p>
                  </th>
                  <th valign="top">
                    <p class="bold">
                      Fecha de envío de Informe Básico</p>
                  </th>
                  <th valign="top">
                    <p class="bold">
                      Fecha de envío de Informe Preliminar</p>
                  </th>
                </tr>
                <tr>
                  <td valign="top">
                    <p>
                      &nbsp;</p>
                  </td>
                  <td valign="top">
                    <p>
                      &nbsp;</p>
                  </td>
                  <td valign="top">
                    <p>
                      &nbsp;</p>
                  </td>
                  <td valign="top">
                    <p>
                      &nbsp;</p>
                  </td>
                </tr>
                <tr>
                  <td valign="top">
                    <p style="text-align:center;">
                      <%# String.Format("{0}", ((AjusteDto) Container.DataItem ).FechaRecepcionDocumentacion) %></p>
                  </td>
                  <td valign="top">
                    <p style="text-align:center;">
                      <%# String.Format("{0}",((AjusteDto) Container.DataItem).InfoConvenioAjuste.FechaConvenio)  %></p>
                  </td>
                  <td valign="top">
                    <p style="text-align:center;">
                      <%#  string.Format("{0}", ((AjusteDto) Container.DataItem).InfoConvenioAjuste.FechaRecepcionConvenioFirmado) %></p>
                  </td>
                  <td valign="top">
                    <p style="text-align:center;">
                      <%#  string.Format("{0}", ((AjusteDto) Container.DataItem).FechaEnvioIF)  %></p>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </ItemTemplate>
    </asp:FormView>
  </div>
  </form>
</body>
</html>
