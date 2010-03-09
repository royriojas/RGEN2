<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformePreliminarRimac.aspx.cs"
  Inherits="InformesPlantillas_InformePreliminarRimac" %>

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
  <title>INFORME PRELIMINAR</title>
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
      DefaultMode="ReadOnly" DataSourceID="odsInforme" OnDataBound="DoDataBound">
      <ItemTemplate>
        <p class="DateSalute">
         LIMA,
          <%=String.Format("{0:dd MMMM, yyyy}", DateTime.Now).ToUpper()%></p>
        <h2 class="RimacLogo">
          RÍMAC
        </h2>
        <h3 class="RimacName">
          Compañía de Seguros y Reaseguros S.A.</h3>
        <p>
          Las Begonias N° 475 3er. Piso</p>
        <p class="Bold">
          Lima 27 - PERÚ</p>
        <p>
          &nbsp;</p>
        <p class="Bold">
          Att. : SR(A). <span class="Underline">
            <%#((AjusteDto) Container.DataItem).Recepcion.ConfirmadoCon %>
          </span>
        </p>
        <p>
          &nbsp;</p>
        <uc5:Caratula ID="Caratula1" runat="server" />
        <div class="main">
          <h2 class="infPreliminarTitle">
            INFORME PRELIMINAR <span>
              <%# (((AjusteDto)Container.DataItem).NumeroIfb > 1 && IsComplementary) ? string.Format("N° {0}", ((AjusteDto)Container.DataItem).NumeroIfb) : String.Empty %>
            </span>
          </h2>
          <div class="ruler-divider doble">
          </div>
          <div class="ruler-divider">
          </div>
          <div class="InfoGroup" id="_groupIPreliminar" runat="server">
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).DescripcionRiesgo) %>'>
              <h3>
                INFORMACIÓN GENERAL</h3>
              <%#((AjusteDto) Container.DataItem).DescripcionRiesgo %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).DescripcionLugarSiniestro) %>'>
              <h3>
                LUGAR DEL SINIESTRO</h3>
              <%#((AjusteDto) Container.DataItem).DescripcionLugarSiniestro%>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).DescripcionBienesAfectados) %>'>
              <h3>
                BIEN(ES) SINIESTRADO(S)</h3>
              <%#((AjusteDto) Container.DataItem).DescripcionBienesAfectados %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Antecedentes) %>'>
              <h3>
                ANTECEDENTES</h3>
              <%#((AjusteDto) Container.DataItem).Antecedentes
              %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Ocurrencia) %>'>
              <h3>
                OCURRENCIA</h3>
              <%#((AjusteDto) Container.DataItem).Ocurrencia
              %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Investigaciones) %>'>
              <h3>
                INVESTIGACIONES</h3>
              <%#((AjusteDto) Container.DataItem).Investigaciones
              %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).DescripcionDamage) %>'>
              <h3>
                DAÑOS</h3>
              <!-- //TODO Check this -->
              <%#((AjusteDto) Container.DataItem).DescripcionDamage 
              %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).CausasSiniestro) %>'>
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
              <div class="subSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).MateriaAsegurada) %>'>
                <h4>
                  Materia Asegurada</h4>
                <%# ((AjusteDto) Container.DataItem).MateriaAsegurada %>
              </div>
              <div class="subSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).LocalAsegurado) %>'>
                <h4>
                  Local Asegurado / Ubicación del Riesgo</h4>
                <%# ((AjusteDto) Container.DataItem).LocalAsegurado %>
                <!-- TODO -->
              </div>
              <div class="subSeccion">
                <table width="100%">
                  <tr>
                    <td style="width: 500px;">
                      <h4>
                        Cobertura Aplicable (RAMO)</h4>
                    </td>
                    <td>
                      <h4 style="text-align: right;">
                        Suma Asegurada</h4>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <%# ((AjusteDto) Container.DataItem).Poliza.Cobertura %>
                    </td>
                    <td valign="top" align="right">
                      <span style="text-align: right;">
                        <%# ((AjusteDto) (Container.DataItem)).MonedaSumaAsegurada%>
                        <%# String.Format("{0:#,###.00}",((AjusteDto) (Container.DataItem)).SumaAsegurada) %>
                      </span>
                    </td>
                  </tr>
                </table>
              </div>
              <div class="subSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Seccion) %>'>
                <h4>
                  Sección</h4>
                <%# ((AjusteDto) Container.DataItem).Seccion %>
              </div>
              <div class="subSeccion" id="_deduciblesDiv" runat="server">
                <h4>
                  Deducible Aplicable</h4>
                <uc2:Deducibles ID="Deducibles1" OnEmpty="EmptyDeducibles" runat="server" />
              </div>
              <div class="subSeccion" id="_clausulasDiv" runat="server">
                <h4>
                  Cláusulas Aplicables</h4>
                <uc3:Clausulas ID="Clausulas1" OnEmpty="EmptyClausulas" runat="server" />
              </div>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Reclamo) %>'>
              <h3>
                RECLAMO</h3>
              <p>
                El Asegurado ha estimado su reclamo en un monto de
                <%# ((AjusteDto) Container.DataItem).MonedaReclamoSimbolo %>
                <%# String.Format("{0:#,###.00}", ((AjusteDto)Container.DataItem).Reclamo)%>.</p>
              <%# ((AjusteDto) Container.DataItem).DescripcionReclamo %>
            </div>
            <div class="infoSeccion">
              <h3 style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).OpinionAjustador) %>'>
                COBERTURA</h3>
              <%# ((AjusteDto) Container.DataItem).OpinionAjustador %>
              <div class="subSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).VerificacionGarantias) %>'>
                <h4>
                  Cumplimiento de Garantías / Prescripciones de Seguridad</h4>
                <%# ((AjusteDto) Container.DataItem).VerificacionGarantias %>
              </div>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Reserva) %>'>
              <h3>
                RESERVA</h3>
              <p>
                Recomendamos establecer una Reserva Neta de <span class="bold">
                  <%# ((AjusteDto) Container.DataItem).MonedaReservaSimbolo %>
                   <%# String.Format("{0:#,###.00}", ((AjusteDto)Container.DataItem).Reserva)%></span>.</p>
              <%# ((AjusteDto) Container.DataItem).DescripcionReserva %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Salvamentoyrecupero) %>'>
              <h3>
                SALVAMENTO / RECUPERO</h3>
              <%# ((AjusteDto) Container.DataItem).Salvamentoyrecupero %>
            </div>
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Recomendaciones) %>'>
              <h3>
                MEDIDAS CORRECTIVAS</h3>
              <%# ((AjusteDto) Container.DataItem).Recomendaciones  %>
            </div>
          </div>
          <div id="_groupIComplementario2" class="groupSection" runat="server">
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Antecedentes) %>'>
              <h3>
                PREAMBULO</h3>
              <%# ((AjusteDto) Container.DataItem).Antecedentes %>
            </div>
          </div>
          <div class="infoSeccion">
            <h3 style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).SituacionSiniestro) %>'>
              SITUACIÓN ACTUAL</h3>
            <%# ((AjusteDto) Container.DataItem).SituacionSiniestro %>
            <div id="_documentosSeccion" runat="server" class="subSeccion">
              <h4>
                Documentos solicitados</h4>
              <uc1:DocumentacionSolicitada OnEmpty="OnEmptyDocuments" ID="DocumentacionSolicitada1"
                runat="server" />
            </div>
          </div>
          <div id="_groupIComplementario" runat="server">
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Observaciones) %>'>
              <h3>
                Observaciones</h3>
              <%# ((AjusteDto) Container.DataItem).Observaciones %>
            </div>
            <uc7:TitulosAdicionales ID="TitulosAdicionales1" runat="server" />
          </div>
          <div class="infoSeccion" id="_groupIPreliminar2" runat="server">
            <h3>
              FOTOS</h3>
            <uc6:Fotos ID="Fotos1" OnEmptyFotos="DoEmpty" runat="server" />
          </div>
        </div>
      </ItemTemplate>
    </asp:FormView>
  </div>
  <div class="Firma">
  <p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>Atentamente,</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>Ing. Rafael Romero Herbozo</p>
<p>Registro S.B.S. AN-044</p>
<p>Gerente General</p>

  </div>
  </form>
</body>
</html>
