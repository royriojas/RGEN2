﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformeFinalRimac.aspx.cs"
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
          LIMA,
          <%=DateTime.Now.Day.ToString() + " DE " + String.Format("{0:MMMM}", DateTime.Now).ToUpper() + " DEL " + DateTime.Now.Year.ToString()%></p>
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
        <p class="RimacAtencion">
          Att. : SR(A). <span class="Underline">
            <%#((AjusteDto) Container.DataItem).Recepcion.ConfirmadoCon %>
          </span>
        </p>
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
          
            <div class="infoSeccion" id="_damageDiv" runat="server">
              <h3>
                DAÑOS</h3>
              <uc4:Damage ID="Damage2" OnEmpty="EmptyDamage" runat="server" />
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
                A continuación resumimos la Póliza Número<%# ((AjusteDto) Container.DataItem).Poliza.PolizaNumber %>
                contratada por los asegurados Sres.
                <%# ((AjusteDto) Container.DataItem).InfoAsegurado.Asegurado%>
                , con vigencia en el periodo
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
                <%--<table width="100%">
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
                        <%# String.Format("{0:#,##0.00}",((AjusteDto) (Container.DataItem)).SumaAsegurada) %>
                      </span>
                    </td>
                  </tr>
                </table>--%>
                <asp:ObjectDataSource ID="odsCoberturasAplicablesGridview" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="DataSet1TableAdapters.RGN_COBERTURASAPLICABLESTableAdapter">
                  <SelectParameters>
                    <asp:QueryStringParameter Name="IdAjuste" QueryStringField="AjusteId" Type="Decimal" />
                  </SelectParameters>
                </asp:ObjectDataSource>
                <asp:GridView CssClass="GridView Grid" Width="100%" RowStyle-CssClass="row" ID="GridViewCoberturas"
                  runat="server" AutoGenerateColumns="False" DataSourceID="odsCoberturasAplicablesGridview">
                  <RowStyle CssClass="row"></RowStyle>
                  <Columns>
                    <asp:TemplateField ItemStyle-VerticalAlign="Top" HeaderText="Cobertura / Ramo" SortExpression="RamoCobertura">
                      <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("RamoCobertura") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-VerticalAlign="Top" ItemStyle-Width="240px" SortExpression="SumaAsegurada">
                      <HeaderTemplate>
                        <div>
                          <span>Suma Asegurada</span></div>
                      </HeaderTemplate>
                      <ItemTemplate>
                        <div style="text-align: right;">
                          <asp:Label ID="Label3" runat="server" Text='<%# Bind("MonedaSumaAsegurada") %>'></asp:Label>
                          <asp:Label ID="Label2" runat="server" Text='<%# Bind("SumaAsegurada") %>'></asp:Label>
                        </div>
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                  <HeaderStyle CssClass="header"></HeaderStyle>
                  <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                </asp:GridView>
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
                <%# String.Format("{0:#,##0.00}", ((AjusteDto)Container.DataItem).Reclamo)%>.</p>
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
            <div class="infoSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).PerdidaYajuste) %>'>
              <h3>
                DETALLE DE LA PÉRDIDA Y AJUSTE</h3>
              <%# ((AjusteDto) Container.DataItem).PerdidaYajuste %>
              <div class="subSeccion" style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).ValoresDeclarados) %>'>
                <h4>
                  Comentarios Sobre Valores Declarados</h4>
                <%# ((AjusteDto) Container.DataItem).ValoresDeclarados %>
              </div>
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
            <div class="infoSeccion" runat="server" id="_titulosDiv">
              <uc7:TitulosAdicionales ID="TitulosAdicionales1" OnEmpty="EmptyTitulosAdicionales"
                runat="server" />
            </div>
          </div>
          <div class="infoSeccion" id="_groupIPreliminar2" runat="server">
            <h3>
              FOTOS</h3>
            <uc6:Fotos ID="Fotos1" OnEmptyFotos="DoEmpty" runat="server" />
            <div style="clear: both">
            </div>
          </div>
          <div class="infoSeccion">
            <h3 style="text-align: center; text-decoration: underline;">
              Resumen del Caso</h3>
            <table class="GridView Grid" cellspacing="0" cellpadding="0" border="0">
              <tbody>
                <tr>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha de asignación</p>
                  </td>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha de Inspección</p>
                  </td>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha de envío de Informe Básico</p>
                  </td>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha de Envío de Informe Preliminar</p>
                  </td>
                </tr>
                <tr>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%#  String.Format("{0:dd/MM/yyyy}", ((AjusteDto)Container.DataItem).Recepcion.Recepcion)%></p>
                  </td>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%#  String.Format("{0:dd/MM/yyyy}", ((AjusteDto)Container.DataItem).InfoInspeccion.FechaInspeccion)%></p>
                  </td>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%#  String.Format("{0:dd/MM/yyyy}", ((AjusteDto)Container.DataItem).FechaEnvioIB)%></p>
                  </td>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%#  String.Format("{0:dd/MM/yyyy}", ((AjusteDto)Container.DataItem).FechaEnvioIP)%></p>
                  </td>
                </tr>
                <tr>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha de recepción de último documento</p>
                  </td>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha en que envían Convenio de Ajuste</p>
                  </td>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha en que reciben Convenio Firmado</p>
                  </td>
                  <td valign="top" class="Bold">
                    <p style="text-align: center;">
                      Fecha del Informe Final</p>
                  </td>
                </tr>
                <tr>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%# String.Format("{0:dd/MM/yyyy}", ((AjusteDto)Container.DataItem).FechaRecepcionDocumentacion)%></p>
                  </td>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%# String.Format("{0:dd/MM/yyyy}", ((AjusteDto)Container.DataItem).InfoConvenioAjuste.FechaConvenio)%></p>
                  </td>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%#  string.Format("{0:dd/MM/yyyy}", ((AjusteDto)Container.DataItem).InfoConvenioAjuste.FechaRecepcionConvenioFirmado)%></p>
                  </td>
                  <td valign="top">
                    <p style="text-align: center;">
                      <%#  string.Format("{0:dd/MM/yyyy}", ((AjusteDto) Container.DataItem).FechaEnvioIF)  %></p>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </ItemTemplate>
    </asp:FormView>
  </div>
  <div class="Firma">
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <p>
      Atentamente,</p>
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <p>
      Ing. Rafael Romero Herbozo</p>
    <p>
      Registro S.B.S. AN-044</p>
    <p>
      Gerente General</p>
  </div>
  </form>
</body>
</html>
