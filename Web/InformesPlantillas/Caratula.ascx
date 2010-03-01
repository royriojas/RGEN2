<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Caratula.ascx.cs" Inherits="InformesPlantillas_Caratula" %>
<%@ Import Namespace="App_Code.RimacInforme.Domain"%>
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
<asp:FormView ID="FormViewInforme" DataKeyNames="AjusteId" Width="100%" runat="server"
  DefaultMode="ReadOnly" DataSourceID="odsInforme">
  <ItemTemplate>
    <div class="Caratula">
      <table>
        <tr>
          <td class="label" style="width: 300px">
            INFORME
          </td>
          <td style="width: 10px">
            <span class="bold">:</span>
          </td>
          <td>
         Informe Preliminar
          </td>
        </tr>
        <tr>
          <td class="label">
            FECHA DE INFORME BÁSICO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
            <%# ((AjusteDto) (Container.DataItem)) %>
          </td>
        </tr>
        <tr>
          <td class="label">
            SU REF
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            NUESTRA REF
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            CONTRATANTE
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            ASEGURADO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            BROKER
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            PÓLIZA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            VIGENCIA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            TIPO DE PÓLIZA y RAMO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            LÍMITES
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            CAUSA, resumida.
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            LUGAR
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            FECHA DE OCURRENCIA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            BIEN / PERSONA AFECTADO (A)
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            DAÑOS / LESIONES / PERDIDAS
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            RECLAMO
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
        <tr>
          <td class="label">
            RESERVA NETA
          </td>
          <td>
            <span class="bold">:</span>
          </td>
          <td>
          </td>
        </tr>
      </table>
    </div>
    <div class="pagebreak">
      &nbsp;</div>
  </ItemTemplate>
</asp:FormView>
