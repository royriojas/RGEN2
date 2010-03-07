<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformeBasicoRimac.aspx.cs"
  Inherits="InformesPlantillas_InformeBasicoRimac" %>

<%@ Import Namespace="App_Code.RimacInforme.Domain" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Register Src="~/RimacInforme/detalleSublimitesAfectados.ascx" TagName="detalleSublimitesAfectados"
  TagPrefix="uc1" %>
<%@ Register Src="~/RimacInforme/Deducibles.ascx" TagName="Deducibles" TagPrefix="uc2" %>
<%@ Register Src="~/RimacInforme/Clausulas.ascx" TagName="Clausulas" TagPrefix="uc3" %>
<%@ Register Src="~/RimacInforme/Damage.ascx" TagName="Damage" TagPrefix="uc4" %>
<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<%@ Register Src="../RimacInforme/Fotos.ascx" TagName="Fotos" TagPrefix="uc5" %>
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
        INFORME BÁSICO AJUSTE No.
        <%#((AjusteDto) (Container.DataItem)).NumeroAjuste%>
      </h1>
      <p class="Bold Underline">
        ATENCIÓN</p>
      <p class="Bold">
        SRS. RÍMAC</p>
      <p class="Bold">
        SR.
        <%#((AjusteDto) (Container.DataItem)).Recepcion.ConfirmadoCon %>
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
            <td valign="top" style="width:105px">
              <p class="label">
                CONTRATANTE:</p>
            </td>
            <td valign="top" >
              <p>
                <%#((AjusteDto) (Container.DataItem)).InfoAsegurado.Contratante%></p>
            </td>
            <td valign="top" style="width:135px;" >
              <p class="label">
                ASEGURADO:</p>
            </td>
            <td valign="top">
              <p>
                <%#((AjusteDto) (Container.DataItem)).InfoAsegurado.Asegurado%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" colspan="2">
              <p class="label">
                GIRO DEL NEGOCIO / OCUPACIÓN:
              </p>
            </td>
            <td valign="top" colspan="2" >
              <p>
                <%#((AjusteDto) (Container.DataItem)).GiroNegocio%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" >
              <p class="label">
                BROKER:
              </p>
            </td>
            <td valign="top" >
              <p>
                <%#((AjusteDto) (Container.DataItem)).InfoAsegurado.Broker%></p>
            </td>
            <td valign="top" >
              <p class="label">
                EJECUTIVO:
              </p>
            </td>
            <td valign="top">
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
            <td valign="top" style="width:180px;" >
              <p class="label">
                PÓLIZA:</p>
            </td>
            <td valign="top" colspan="2" >
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.PolizaNumber%></p>
            </td>
            <td valign="top" style="width:100px" >
              <p class="label">
                VIGENCIA:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.Vigencia%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" >
              <p class="label">
                TIPO (PRODUCTO):</p>
            </td>
            <td valign="top" colspan="2" >
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.Tipo%></p>
            </td>
            <td valign="top" >
              <p class="label">
                RAMO:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).Poliza.Ramo%></p>
            </td>
          </tr>
          <tr>
            <td valign="top">
              <p class="label">
                LÍMITES:</p>
            </td>
            <td colspan="4">
              <p>
                <%# ((AjusteDto) (Container.DataItem)).MonedaSumaAsegurada %>
                <%#  String.Format("{0:#,###.00}", ((AjusteDto)(Container.DataItem)).SumaAsegurada)%>
              </p>
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
            <td valign="top" style="width: 205px;" >
              <p class="label">
                # REF ASEGURADOR:</p>
            </td>
            <td valign="top" >
              <p>
                <%#((AjusteDto) (Container.DataItem)).Recepcion.NumeroAseguradora%></p>
            </td>
            <td valign="top" style="width: 125px;" >
              <p class="label">
                RECEPCIÓN:</p>
            </td>
            <td>
              <p>
                <%#((AjusteDto) (Container.DataItem)).Recepcion.Recepcion%></p>
            </td>
          </tr>
          <tr>
            <td valign="top" >
              <p class="label">
                CONFIRMADO CON:</p>
            </td>
            <td valign="top" >
              <p>
                <%#((AjusteDto) (Container.DataItem)).Recepcion.ConfirmadoCon%></p>
            </td>
            <td valign="top" >
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
            <td valign="top" style="width: 285px;>
              <p class="label">
                FECHA Y HORA DE SINIESTRO:</p>
            </td>
            <td valign="top">
              <p>
                <%#((AjusteDto) (Container.DataItem)).FechaYHoraSiniestro%></p>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top" >
              <p class="label">
                LUGAR DEL SINIESTRO:</p>
            </td>
            <td valign="top">
              <p>
                <%#((AjusteDto) (Container.DataItem)).LugarDeSiniestro%></p>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top" >
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
            <td valign="top" colspan="2">
              <p class="label">
                OCURRENCIA:
              </p>
			  <div class="text-content">
				<%#((AjusteDto) (Container.DataItem)).Ocurrencia%>
			  </div>
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
              <h2 >
                SITUACIÓN ACTUAL
              </h2>
              <div class="text-content">
                <%# ((AjusteDto) (Container.DataItem)).SituacionSiniestro %>
			  </div>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
      <table class="TableSection" border="0" cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td valign="top" style="width:300px;">
              <h2>
                MONTO DE AVISO / RECLAMO:</h2>
            </td>
            <td>
              <p>
                <%# String.Format("{0}", ((AjusteDto)Container.DataItem).MonedaReclamoSimbolo)%>
                <%# String.Format("{0:#,###.00}", ((AjusteDto)Container.DataItem).Reclamo)%>
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top" style="width:300px;" >
              <h2 >
                RESERVA PRELIMINAR:</h2>
            </td>
            <td>
              <p>
                <%# String.Format("{0}", ((AjusteDto)Container.DataItem).MonedaReservaSimbolo)%>
                <%# String.Format("{0:#,###.00}", ((AjusteDto)Container.DataItem).Reserva)%></p>
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
            <td style='<%# CCSOL.Utiles.Utilidades.IsNull(((AjusteDto) (Container.DataItem)).Notas) %>'  valign="top" colspan="6">
              <p class="label">
                NOTAS:</p>
              <div class="text-content">
                <%# ((AjusteDto) (Container.DataItem)).Notas %></div>
            </td>
          </tr>
        </tbody>
      </table>
      <p>
        &nbsp;</p>
    </ItemTemplate>
  </asp:FormView>
  <div class="Group">
    <h2 runat="server" id="fotosTitle" >
      FOTOS
    </h2>
    <uc5:Fotos ID="Fotos1" runat="server" />
  </div>
  </form>
</body>
</html>
