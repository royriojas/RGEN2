<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Caratula.ascx.cs" Inherits="InformesPlantillas_Caratula" %>
<%@ Import Namespace="App_Code.RimacInforme.Domain" %>
<%@ Register Src="~/RimacInforme/detalleSublimitesAfectados.ascx" TagName="detalleSublimitesAfectados"
  TagPrefix="uc1" %>
<%@ Register Src="~/RimacInforme/Deducibles.ascx" TagName="Deducibles" TagPrefix="uc2" %>
<%@ Register Src="~/RimacInforme/Clausulas.ascx" TagName="Clausulas" TagPrefix="uc3" %>
<%@ Register Src="~/RimacInforme/Damage.ascx" TagName="Damage" TagPrefix="uc4" %>
<asp:ObjectDataSource ID="odsInforme" runat="server" DataObjectTypeName="App_Code.RimacInforme.Domain.AjusteDto"
  OldValuesParameterFormatString="{0}" SelectMethod="GetInformeBasicoByAjusteId"
  TypeName="App_Code.RimacInforme.Persistence.AjusteDtoOds">
  <SelectParameters>
    <asp:QueryStringParameter DefaultValue="-1" Name="ajusteId" QueryStringField="AjusteId"
      Type="Decimal" />
  </SelectParameters>
</asp:ObjectDataSource>
<asp:FormView OnDataBound="DoDataBound" ID="FormViewInforme" DataKeyNames="AjusteId"
  Width="100%" runat="server" DefaultMode="ReadOnly" DataSourceID="odsInforme">
  <ItemTemplate>
    <div class="Caratula">
      <table >
        <tr>
          <td class="label" valign="top" style="width: 380px">
            INFORME
          </td>
          <td style="width: 10px">
            <span class="bold">:</span>
          </td>
          <td>
            INFORME
            <%# IsFinal ? "FINAL" : "PRELIMINAR"  %>
            <span>
              <%# (((AjusteDto)Container.DataItem).NumeroIfb > 1 && IsComplementary) ? string.Format("N° {0}", ((AjusteDto)Container.DataItem).NumeroIfb) : String.Empty %>
            </span>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            FECHA DE INFORME BÁSICO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0:dd/MM/yyyy}", ((AjusteDto) (Container.DataItem)).FechaEnvioIB) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            SU REF
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).Recepcion.NumeroAseguradora) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            NUESTRA REF
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).NumeroAjuste) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            CONTRATANTE
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).InfoAsegurado.Contratante) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            ASEGURADO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).InfoAsegurado.Asegurado) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            BROKER
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).InfoAsegurado.Broker) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            PÓLIZA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).Poliza.PolizaNumber) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            VIGENCIA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).Poliza.Vigencia ) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            TIPO DE PÓLIZA y RAMO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0} / {1}", ((AjusteDto)(Container.DataItem)).Poliza.Tipo, ((AjusteDto)(Container.DataItem)).Poliza.Ramo)%>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            LÍMITES
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td valign="top">
            <p>
              <%# ((AjusteDto) (Container.DataItem)).MonedaSumaAsegurada %>
              <%#  String.Format("{0:#,###.00}", ((AjusteDto)(Container.DataItem)).SumaAsegurada)%>
            </p>
          </td>
        </tr>
        <%--<tr>
          <td colspan="3">
            <uc1:detalleSublimitesAfectados ID="_detalleSublimitesAfectados1" runat="server" />
          </td>
        </tr>--%>
        <tr>
          <td class="label" valign="top">
            CAUSA
          </td>
          <td valign="top">
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).CausasSiniestro) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            LUGAR
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) (Container.DataItem)).LugarDeSiniestro) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            FECHA DE OCURRENCIA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0:D}", ((AjusteDto) (Container.DataItem)).FechaYHoraSiniestro) %>
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            BIEN / PERSONA AFECTADO (A) / DAÑOS / LESIONES / PERDIDAS
          </td>
          <td valign="top">
            <span class="bold">:</span>
          </td>
          <td valign="top">
            <uc4:Damage ID="Damage2" runat="server" />
          </td>
        </tr>
        <tr>
          <td class="label" valign="top">
            RECLAMO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# String.Format("{0}", ((AjusteDto) Container.DataItem).MonedaReclamoSimbolo) %>
            <%# String.Format("{0:#,###.00}", ((AjusteDto)Container.DataItem).Reclamo)%>
          </td>
        </tr>
        <tr style='<%#  IsFinal ? "display:none": ""  %>'>
          <td class="label" valign="top">
            RESERVA NETA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <span class="bold">
              <%# String.Format("{0}", ((AjusteDto)Container.DataItem).MonedaReservaSimbolo)%>
              <%# String.Format("{0:#,###.00}", ((AjusteDto)Container.DataItem).Reserva)%></span>
          </td>
        </tr>
        <tr style='<%#  !IsFinal ? "display:none": ""  %>'>
          <td class="label" valign="top">
            INDEMNIZACIÓN
          </td>
          <td valign="top">
            <span class="bold">:</span>
          </td>
          <td valign="top">
            <span class="bold">
              <%# String.Format("{0}", ((AjusteDto)Container.DataItem).MonedaReservaSimbolo)%>
              <%# String.Format("{0:#,###.00}", ((AjusteDto)Container.DataItem).InfoConvenioAjuste.TotalIndemnizacion)%></span>
          </td>
        </tr>
      </table>
    </div>
    <div class="pagebreak">
      &nbsp;</div>
  </ItemTemplate>
</asp:FormView>
