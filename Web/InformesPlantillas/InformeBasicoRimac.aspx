﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformeBasicoRimac.aspx.cs"
  Inherits="InformesPlantillas_InformeBasicoRimac" %>

<%@ Import Namespace="App_Code.RimacInforme.Domain" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Register Src="~/RimacInforme/detalleSublimitesAfectados.ascx" TagName="detalleSublimitesAfectados"
  TagPrefix="uc1" %>
<%@ Register Src="~/RimacInforme/Deducibles.ascx" TagName="Deducibles" TagPrefix="uc2" %>
<%@ Register Src="~/RimacInforme/Clausulas.ascx" TagName="Clausulas" TagPrefix="uc3" %>
<%@ Register Src="~/RimacInforme/Damage.ascx" TagName="Damage" TagPrefix="uc4" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>INFORME BÁSICO</title>
  <link href='<%= ResolveUrl("~/InformesPlantillas/infRimac.css?nc=" + DateTime.Now.Ticks) %>'
    rel="Stylesheet" type="text/css" />
</head>
<body>
  <form id="_form1" runat="server">
  <asp:ObjectDataSource ID="odsInforme" runat="server" DataObjectTypeName="App_Code.RimacInforme.Domain.AjusteDto"
    OldValuesParameterFormatString="{0}" SelectMethod="GetInformeBasicoByAjusteId"
    TypeName="App_Code.RimacInforme.Persistence.AjusteDtoOds">
    <SelectParameters>
      <asp:QueryStringParameter DefaultValue="-1" Name="ajusteId" QueryStringField="AjusteId"
        Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
  <asp:FormView ID="FormViewInforme" DataKeyNames="AjusteId" Width="100%" runat="server"
    OnDataBound="DoDataBound" DefaultMode="ReadOnly" DataSourceID="odsInforme">
    <ItemTemplate>
      <p class="DateSalute">
        Lima,
        <%= DateTime.Now.ToLongDateString() %></p>
      <h1 class="InfTitle">
        INFORME BÁSICO #<%#((AjusteDto) (Container.DataItem)).NumeroIfb%>&nbsp; AJUSTE No.
        <%#((AjusteDto) (Container.DataItem)).NumeroAjuste%>
      </h1>
      <p class="Bold Underline">
        ATENCIÓN</p>
      <p class="Bold">
        SRS. RÍMAC</p>
      <p class="Bold">
        SR.
      </p>
      <p>
        &nbsp;</p>
      <table class="TableSection" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" colspan="4">
              <h2>
                INFORMACIÓN DEL ASEGURADO</h2>
            </td>
          </tr>
          <tr>
            <td valign="top" width="115">
              <p class="label">
                CONTRATANTE:</p>
            </td>
            <td valign="top" width="159">
              <p>
                <%#((AjusteDto) (Container.DataItem)).InfoAsegurado.Contratante%></p>
            </td>
            <td valign="top" width="104">
              <p class="label">
                ASEGURADO:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).InfoAsegurado.Asegurado%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="2" width="274">
              <p class="label">
                GIRO DEL NEGOCIO / OCUPACIÓN
              </p>
            </td>
            <td valign="top" colspan="2" width="335">
              <p>
                <%#((AjusteDto) (Container.DataItem)).GiroNegocio%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" width="115">
              <p class="label">
                BROKER
              </p>
            </td>
            <td valign="top" width="159">
              <p>
                <%#((AjusteDto) (Container.DataItem)).InfoAsegurado.Broker%></p>
            </td>
            <td valign="top" width="104">
              <p class="label">
                EJECUTIVO
              </p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).InfoAsegurado.EjecutivoBroker%></p>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" colspan="5">
              <h2>
                INFORMACIÓN DE LA PÓLIZA</h2>
            </td>
          </tr>
          <tr>
            <td valign="top" width="115">
              <p class="label">
                PÓLIZA:</p>
            </td>
            <td valign="top" colspan="2" width="168">
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.PolizaNumber%></p>
            </td>
            <td valign="top" width="124">
              <p class="label">
                VIGENCIA:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.Vigencia%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" width="115">
              <p class="label">
                TIPO (PRODUCTO):</p>
            </td>
            <td valign="top" colspan="2" width="168">
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.Tipo%></p>
            </td>
            <td valign="top" width="124">
              <p class="label">
                RAMO:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.Ramo%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="5">
              <h2>
                LÍMITES:</h2>
              <uc1:detalleSublimitesAfectados ID="detalleSublimitesAfectados1" runat="server" />
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="5">
              <p class="label">
                DEDUCIBLES:</p>
              <uc2:Deducibles ID="Deducibles1" runat="server" />
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="5">
              <p class="label">
                CLAUSULAS APLICABLES:</p>
              <uc3:Clausulas ID="Clausulas1" runat="server" />
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" colspan="4">
              <h2>
                RECEPCIÓN DEL CASO</h2>
            </td>
          </tr>
          <tr>
            <td valign="top" width="151">
              <p class="label">
                # REF ASEGURADOR:</p>
            </td>
            <td valign="top" width="151">
              <p>
                <%#((AjusteDto) (Container.DataItem)).Recepcion.NumeroAseguradora%></p>
            </td>
            <td valign="top" width="97">
              <p class="label">
                RECEPCIÓN:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).Recepcion.Recepcion%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" width="151">
              <p class="label">
                CONFIRMADO CON:</p>
            </td>
            <td valign="top" width="151">
              <p>
                <%#((AjusteDto) (Container.DataItem)).Recepcion.ConfirmadoCon%></p>
            </td>
            <td valign="top" width="97">
              <p class="label">
                AJUSTADOR:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).Recepcion.Ajustador%></p>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" colspan="2">
              <h2>
                INFORMACIÓN DE OCURRENCIA / DESCUBRIMIENTO</h2>
            </td>
          </tr>
          <tr>
            <td valign="top" width="217">
              <p class="label">
                FECHA Y HORA DE SINIESTRO:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).FechaYHoraSiniestro%></p>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top" width="217">
              <p class="label">
                LUGAR DEL SINIESTRO:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).LugarDeSiniestro%></p>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top" width="217">
              <p class="label">
                DESCRIPCIÓN DE SINIESTRO:
              </p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).DescripcionSiniestro%></p>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top">
              <p class="label">
                OCURRENCIA:
              </p>
            </td>
            <td valign="top">
              <p>
                <%#((AjusteDto) (Container.DataItem)).Ocurrencia%></p>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="2">
              <p class="label">
                DAÑOS:
              </p>
              <uc4:Damage ID="Damage1" runat="server" />
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" colspan="5">
              <h2>
                INFORMACIÓN DE INSPECCIÓN</h2>
            </td>
          </tr>
          <tr>
            <td valign="top" width="123">
              <p class="label">
                COORDINACIÓN:</p>
            </td>
            <td valign="top" colspan="2" width="170">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).InfoInspeccion.PersonaContacto %></p>
            </td>
            <td valign="top" width="97">
              <p class="label">
                INSPECCIÓN:</p>
            </td>
            <td>
              <p>
                <%# ((AjusteDto) (Container.DataItem)).InfoInspeccion.FechaInspeccion %></p>
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="2" width="217">
              <p class="label">
                LUGAR DE INSPECCIÓN:</p>
            </td>
            <td valign="top" colspan="3">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).InfoInspeccion.LugarInspeccion %></p>
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="2" width="217">
              <p class="label">
                PERSONA ENTREVISTADA:
              </p>
            </td>
            <td valign="top" colspan="3">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).InfoInspeccion.PersonaEntrevistada %></p>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td>
              <p class="label">
                SITUACIÓN ACTUAL
              </p>
              <p>
                <%# ((AjusteDto) (Container.DataItem)).SituacionSiniestro %></p>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" width="227">
              <p class="label">
                MONTO DE AVISO / RECLAMO:</p>
            </td>
            <td>
              <p>
                <%# ((AjusteDto) (Container.DataItem)).MonedaReclamoSimbolo %>
                <%# ((AjusteDto) (Container.DataItem)).Reclamo %>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top" width="227">
              <p class="label">
                RESERVA PRELIMINAR:</p>
            </td>
            <td>
              <p>
                <%# ((AjusteDto) (Container.DataItem)).MonedaReservaSimbolo %>
                <%# ((AjusteDto) (Container.DataItem)).Reserva %></p>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" colspan="6">
              <h2>
                NOTAS FINALES
              </h2>
            </td>
          </tr>
          <tr>
            <td valign="top" width="255">
              <p class="label">
                FAVOR ENVIAR COPIA DE PÓLIZA</p>
            </td>
            <td valign="top" width="57">
              <p class="label">
                SI</p>
            </td>
            <td valign="top" valign="top" width="28">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).EnviarCopiaPoliza == true ? "X" : "" %></p>
            </td>
            <td valign="top" width="38">
              <p class="label">
                NO</p>
            </td>
            <td valign="top" valign="top" width="28">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).EnviarCopiaPoliza == false ? "X" : "" %></p>
            </td>
            <td>
              <p>
                &nbsp;</p>
            </td>
          </tr>
          <tr>
            <td valign="top" width="255">
              <p class="label">
                FAVOR ENVIAR No DE SINIESTRO</p>
            </td>
            <td valign="top" width="57">
              <p class="label">
                SI&nbsp;</p>
            </td>
            <td valign="top" valign="top" width="28">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).EnviaNumeroSiniestro == true ? "X" : "" %></p>
            </td>
            <td valign="top" width="38">
              <p class="label">
                NO</p>
            </td>
            <td valign="top" valign="top" width="28">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).EnviaNumeroSiniestro == false ? "X" : "" %></p>
            </td>
            <td>
              <p>
                &nbsp;</p>
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="6">
              <p class="label">
                NOTAS:</p>
              <p>
                <%# ((AjusteDto) (Container.DataItem)).Notas %></p>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
    </ItemTemplate>
  </asp:FormView>
  <div class="Group">
    <h2>
      FOTOS</h2>
    <div id="divImagenes" runat="server">
      <h2 style="page-break-before: always">
        IMAGENES DEL SINIESTRO</h2>
      <cc1:Repeater ID="Repeater2" runat="server" DataSourceID="odsImagenes" OnDataBinding="Repeater2_DataBinding"
        OnItemDataBound="Repeater2_ItemDataBound">
        <HeaderTemplate>
          <table>
            <tr>
        </HeaderTemplate>
        <ItemTemplate>
          <td valign="top" style="width: 460px; text-align: right;">
            <div class="ImgHolder">
              <img alt="" src='<%# R3M.Common.Util.ResolveURL("vGetImageGrande.aspx?AjusteId="+ Request.QueryString["ajusteId"] + "&ArchivoId=" + Eval("archivoId").ToString() + "&imagen=grande")  %>' />
            </div>
            <div class="txtInfo">
              <%# Eval("descripcion") %>
            </div>
          </td>
          <asp:Literal ID="separator" runat="server" Visible="false">
            </tr><tr>
          </asp:Literal>
          <asp:Literal ID="TableEnd" runat="server" Visible="false">
          </tr>
          </table>
            <div style="page-break-before: always; clear: both">
            </div>
            <table>
            <tr>
          </asp:Literal>
        </ItemTemplate>
        <FooterTemplate>
          </tr></table>
        </FooterTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsImagenes" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" OnSelected="odsImagenes_Selected" TypeName="dsReporteTableAdapters.InformeBasicoImagenesTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
  </div>
  </form>
</body>
</html>