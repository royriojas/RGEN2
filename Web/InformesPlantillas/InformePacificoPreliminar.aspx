<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformePacificoPreliminar.aspx.cs"
  Inherits="InformesPlantillas_InformePacificoPreliminar" %>

<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Informe Preliminar</title>
  <link href="inf.css?nc=<%= DateTime.Now.ToString() %>" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataSourceID="odsDatosGenerales">
      <ItemTemplate>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td colspan="3" valign="top" class="Negrita">
              <h2>
                SEÑORES PACÍFICO SEGUROS</h2>
            </td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              ATENCIÓN</td>
            <td width="10" valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="responsableaseguradoraLabel" runat="server" Text='<%# Bind("responsableaseguradora") %>'></asp:Label>
			</td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              ASEGURADO</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="aseguradoLabel" runat="server" Text='<%# Bind("asegurado") %>'></asp:Label>
			</td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              BROKER</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="brokerLabel" runat="server" Text='<%# Bind("broker") %>'></asp:Label>
			</td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              EJECUTIVO DE SINIESTROS</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="ejecutivoSiniestrosLabel" runat="server" Text='<%# Bind("responsableaseguradora") %>'></asp:Label>
			</td>
          </tr>
        </table>
      </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="odsDatosGenerales" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoGeneralesTableAdapter">
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
          Type="Int32" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="FormView3" runat="server" DataSourceID="odsDatosPóliza">
      <ItemTemplate>
        <br />
        <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              PÓLIZA Nº</td>
            <td width="10" valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="numeroLabel" runat="server" Text='<%# Bind("numero") %>'></asp:Label>
			</td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              VIGENCIA</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="vigenciaLabel" runat="server" Text='<%# Bind("vigencia") %>'></asp:Label>
			</td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              COBERTURA AFECTADA</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="coberturaLabel" runat="server" Text='<%# Bind("cobertura") %>'></asp:Label>
			</td>
          </tr>
        </table>
      </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="odsDatosPóliza" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoPolizaTableAdapter">
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
          Type="Int32" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="FormView2" runat="server" DataSourceID="odsDatosPrincipalesAjuste">
      <ItemTemplate>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              PACÍFICO REF. Nº</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="numeroSiniestroCiaLabel" runat="server" Text='<%# Bind("numeroSiniestroCia") %>'></asp:Label></td>
          </tr>
		  <tr>
            <td style="width: 210px; height: 41px;" valign="top" class="Negrita">
              FECHA/LUGAR DE OCURRENCIA</td>
            <td valign="top" class="Negrita" style="width: 10px; height: 41px;">
              :</td>
            <td valign="top" style="height: 41px">
              <asp:Label ID="fsiniestroLabel" runat="server" Text='<%# Bind("fsiniestro") %>'></asp:Label>
              <br />
              <asp:Label ID="lugarSiniestroLabel" runat="server" Text='<%# Bind("lugarSiniestro") %>'></asp:Label><br />
              <asp:Label ID="distritoSiniestroLabel" runat="server" Text='<%# Bind("distritoSiniestro") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              CAUSA</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="causasiniestroLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("causasiniestro")) %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              BIEN AFECTADO</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <%#GestorInforme.getSubtitle("BIEN_AFECTADO",AjusteId) %>
            </td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              DAÑOS Y/O PÉRDIDAS</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <%#GestorInforme.getSubtitle("DANO_PERDIDA",AjusteId) %>
            </td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              CONTACTO Y CARGO</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="personaContactoLabel" runat="server" Text='<%# Bind("personaContacto") %>'></asp:Label>
              <br />
              <asp:Label ID="cargoPersonaContactoLabel" runat="server" Text='<%# Bind("cargoPersonaContacto") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              EJECUTIVO AJUSTADOR</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="ajustadorLabel" runat="server" Text='<%# Bind("ajustador") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              RECLAMO</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="monedaReclamoLabel" runat="server" Text='<%# Bind("monedaReclamo") %>'></asp:Label>
              <asp:Label ID="reclamoLabel" runat="server" Text='<%# Bind("reclamo","{0:#,###.00}") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              RESERVA NETA
            </td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="monedaReservaLabel" runat="server" Text='<%# Bind("monedaReserva") %>'></asp:Label>
              <asp:Label ID="reservaLabel" runat="server" Text='<%# Bind("reserva", "{0:#,###.00}") %>'></asp:Label></td>
          </tr>
        </table>
        <asp:HiddenField ID="hdfSiniestroCia" runat="server" Value='<%# Bind("numeroSiniestroCia") %>' />
      </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="odsDatosPrincipalesAjuste" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsReportePacificoTableAdapters.InformeBasicoPacificoDatosAjusteTableAdapter">
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
          Type="Int32" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <br />
    <h2>
      INFORMACIÓN GENERAL</h2>
    <div class="line">
    </div>
    <h3>
      DEL ASEGURADO
    </h3>
    <asp:FormView ID="FormView4" runat="server" DataSourceID="odsDatosGenerales">
      <ItemTemplate>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              CONTRATANTE</td>
            <td width="10" valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="Label1" runat="server" Text='<%# Bind("contratante") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 210px;" valign="top" class="Negrita">
              ASEGURADO</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="Label2" runat="server" Text='<%# Bind("asegurado") %>'></asp:Label></td>
          </tr>
          <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("gironegocio")) %>'>
            <td style="width: 210px;" valign="top" class="Negrita">
              GIRO DEL NEGOCIO</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              <asp:Label ID="Label3" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("gironegocio")) %>'></asp:Label></td>
          </tr>
          <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("grupoeconomico")) %>'>
            <td style="width: 210px;" valign="top" class="Negrita">
              GRUPO ECONOMICO</td>
            <td valign="top" class="Negrita" style="width: 10px;">
              :</td>
            <td valign="top">
              &nbsp;<asp:Label ID="label4" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("grupoeconomico")) %>'></asp:Label></td>
          </tr>
        </table>
      </ItemTemplate>
    </asp:FormView>
    <br />
    <asp:FormView ID="frmDatosAjuste" runat="server" DataSourceID="odsOcurrencia">
      <ItemTemplate>
        <h2>
          DETALLES DEL SINIESTRO</h2>
        <div class="line">
        </div>
        <div id="divLugarSiniestro" runat="server" style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("lugarSiniestro")) %>'>
          <h3>
            LUGAR DEL SINIESTRO</h3>
          <p>
            <asp:Label ID="Label5" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("lugarSiniestro")) %>'></asp:Label></p>
          <br />
        </div>
        <div id="divCircunstancias" runat="server" style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("detalleocurrencia")) %>'>
          <h3>
            CIRCUNSTANCIAS DEL SINIESTRO</h3>
          <p>
            <asp:Label ID="Label6" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("detalleocurrencia")) %>'></asp:Label></p>
          <br />
        </div>
        <h2>
          INVESTIGACIONES</h2>
        <div class="line">
        </div>
        <div id="divInvestigaciones" runat="server" style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("investigaciones")) %>'>
          <p>
            <asp:Label ID="Label8" runat="server" Text='<%#Eval("investigaciones")%>'></asp:Label></p>
        </div>
        <div id="divBienesAfectados" runat="server">
          <h3>
            &nbsp;DAÑOS Y/O PÉRDIDAS</h3>
        </div>
        <div id="divDanos" runat="server">
          <cc1:Repeater ID="Repeater1" runat="server" DataSourceID="odsOcurrenciaDetalle" OnItemDataBound="Repeater1_ItemDataBound">
            <HeaderTemplate>
              <table class="GridView" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr class="header">
                  <th width="4%">
                    ÍTEM</th>
                  <th width="28%">
                    BIENES Y/O PERSONAS AFECTADAS</th>
                  <th width="24%">
                    DESCRIPCIÓN DE LOS DAÑOS, PERDIDAS Y/O HERIDAS</th>
                  <th width="26%">
                    LOCAL</th>
                  <th width="18%">
                    ESTIMACIÓN DE DAÑO Y/O PERDIDA</th>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
              <tr>
                <td valign="top">
                  <div align="center">
                    <asp:Label ID="itemLabel" runat="server" Text='<%# this.Num++ %>'></asp:Label>
                  </div>
                </td>
                <td valign="top">
                  <asp:Label ID="bienesLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("Bienes"))%>'></asp:Label></td>
                <td valign="top">
                  <asp:Label ID="descripcionLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("descripcion"))%>'></asp:Label></td>
                <td valign="top">
                  <asp:Label ID="localLabel" runat="server" Text='<%#(Eval("LocalDelBien"))%>'></asp:Label></td>
                <td valign="top">
                  <div align="right" style="text-align:right;">
                    <asp:Label ID="montoLabel" runat="server" Text='<%#Eval("estimacion", "{0:#,###.00}")%>'></asp:Label>
                  </div>
                </td>
              </tr>
            </ItemTemplate>
            <FooterTemplate>
              <tr>
                <td colspan="4" valign="top">
                  <div class="Negrita" align="right">
                    TOTAL PERDIDAS ESTIMADAS US$
                  </div>
                </td>
                <td valign="top">
                  <div align="right" style="text-align:right;">
                    <%# this.SumaDetalleOcurrencia.ToString("#,###.00")%>
                  </div>
                </td>
              </tr>
              </table>
            </FooterTemplate>
          </cc1:Repeater>
          <asp:ObjectDataSource ID="odsOcurrenciaDetalle" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoOcurrenciaDetalleTableAdapter"
            OnSelecting="odsOcurrenciaDetalle_Selecting" OnSelected="odsOcurrenciaDetalle_Selected">
            <SelectParameters>
              <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
                Type="Int32" />
            </SelectParameters>
          </asp:ObjectDataSource>
        </div>
        <h3>
          CAUSA DEL SINIESTRO</h3>
        <p>
          <asp:Label ID="Label7" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("causasiniestro")) %>'></asp:Label></p>
      </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="odsOcurrencia" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoOcurrenciaCabeceraTableAdapter">
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
          Type="Int32" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <h2>
      DETALLES DE LA PÓLIZA</h2>
    <div class="line">
    </div>
    <div id="divMateriaAsegurada" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("MATERIA_ASEGURADA",this.AjusteId)) %>'>
      <h3>
        MATERIA ASEGURADA</h3>
      <p>
        <%= GestorInforme.getSubtitle("MATERIA_ASEGURADA",AjusteId)%>
      </p>
    </div>
    <div id="divUbicacionRiesgo" runat="server" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("UBICACION_RIESGO",this.AjusteId)) %>'>
      <h3>
        UBICACIÓN DEL RIESGO</h3>
      <p>
        <%= GestorInforme.getSubtitle("UBICACION_RIESGO", AjusteId)%>
      </p>
    </div>
    <div id="divBienesAfectados" runat="server">
      <cc1:Repeater ID="repeaterSublimites" runat="server" DataSourceID="odsPolizaDetalle"
        OnItemCreated="repeaterSublimites_ItemCreated2" OnItemDataBound="repeaterSublimites_ItemDataBound2">
        <EmptyDataTemplate>
        </EmptyDataTemplate>
        <HeaderTemplate>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="GridView">
            <tr class="header">
              <th width="4%">
                ÍTEM</th>
              <th width="28%">
                DETALLE</th>
              <th width="24%">
                LOCAL</th>
              <th width="22%">
                <asp:Label ID="concepto1Label" runat="server" Text=''></asp:Label></th>
              <th width="22%">
                <asp:Label ID="concepto2Label" runat="server" Text=''></asp:Label></th>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td valign="top">
              <div align="center">
                <asp:Label ID="itemLabel" runat="server" Text='<%# this.Num++ %>'></asp:Label>
              </div>
            </td>
            <td valign="top">
              <asp:Label ID="detalleLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("detalle"))%>'></asp:Label></td>
            <td valign="top">
              <asp:Label ID="localLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("localItem"))%>'></asp:Label></td>
            <td valign="top">
              <div align="right" style="text-align:right;">
                <asp:Label ID="simboloLabel" runat="server" Text='<%#Eval("simbolo")%>' Style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("monto")) %>'></asp:Label>
                <asp:Label ID="montoLabel" runat="server" Text='<%#Eval("monto", "{0:#,###.00}")%>'></asp:Label>
              </div>
            </td>
            <td valign="top">
              <div align="right" style="text-align:right;">
                <asp:Label ID="simbolo2Label" runat="server" Text='<%#Eval("simbolo")%>' Style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("montoAsegurado2")) %>'></asp:Label>
                <asp:Label ID="montoAsegurado2" runat="server" Text='<%#Eval("montoAsegurado2", "{0:#,###.00}")%>'></asp:Label>
              </div>
            </td>
          </tr>
        </ItemTemplate>
        <FooterTemplate>
          </table>
        </FooterTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsPolizaDetalle" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoPolizaDetalleTableAdapter"
        OnSelecting="odsPolizaDetalle_Selecting" OnSelected="odsPolizaDetalle_Selected1">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divSeccion" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("SECCION",this.AjusteId)) %>'>
      <h3>
        SECCIÓN</h3>
      <p>
        <%= GestorInforme.getSubtitle("SECCION", AjusteId)%>
      </p>
    </div>
    <div id="divDeducibles" runat="server">
      <h3>
        DEDUCIBLE</h3>
      <cc1:Repeater ID="repeaterDeducibles" runat="server" DataSourceID="odsDeducibles">
        <ItemTemplate>
          <ul>
            <li>
              <asp:Label ID="deducibleLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("condiciones"))%>'></asp:Label></li>
          </ul>
        </ItemTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsDeducibles" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter"
        OnSelected="odsDeducibles_Selected">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divClausulas" runat="server">
      <h3>
        CLÁUSULAS</h3>
      <cc1:Repeater ID="repeaterClausulas" runat="server" DataSourceID="odsClausulas">
        <ItemTemplate>
          <ul>
            <li>
              <asp:Label ID="clausulaLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("nombre"))%>'></asp:Label></li>
          </ul>
        </ItemTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsClausulas" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoClausulasTableAdapter"
        OnSelected="odsClausulas_Selected">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divCumplimientoyGarantias" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("CUMPLIMIENTO_GARANTIAS",this.AjusteId)) %>'>
      <h3>
        CUMPLIMIENTO GARANTÍAS/PRESCRIPCIONES DE SEGURIDAD</h3>
      <p>
        <%= GestorInforme.getSubtitle("CUMPLIMIENTO_GARANTIAS",this.AjusteId) %>
      </p>
    </div>
    <div id="divReclamo" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("RECLAMO_AJUSTE",this.AjusteId)) %>'>
      <h2>
        RECLAMO</h2>
      <p>
        <%= GestorInforme.getSubtitle("RECLAMO_AJUSTE",this.AjusteId) %>
      </p>
    </div>
    <div id="divCobertura" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("ANALISIS_COBERTURA",this.AjusteId)) %>'>
      <h2>
        COBERTURA</h2>
      <p>
        <%= GestorInforme.getSubtitle("ANALISIS_COBERTURA",this.AjusteId) %>
      </p>
    </div>
    <div id="divReserva" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("RESERVA",this.AjusteId)) %>'>
      <h2>
        RESERVA</h2>
      <p>
        <%= GestorInforme.getSubtitle("RESERVA",this.AjusteId) %>
      </p>
    </div>
    <div id="divInfraseguro" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("INFRASEGURO",this.AjusteId)) %>'>
      <h2>
        INFRASEGURO</h2>
      <p>
        <%= GestorInforme.getSubtitle("INFRASEGURO",this.AjusteId) %>
      </p>
    </div>
    <div id="divSalvamento" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("SALVAMENTO/RECUPERO",this.AjusteId)) %>'>
      <h2>
        SALVAMENTO | RECUPERO</h2>
      <p>
        <%= GestorInforme.getSubtitle("SALVAMENTO/RECUPERO", this.AjusteId)%>
      </p>
    </div>
    <div id="divMedidas" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("MEDIDAS_CORRECTIVAS",this.AjusteId)) %>'>
      <h2>
        MEDIDAS CORRECTIVAS</h2>
      <p>
        <%= GestorInforme.getSubtitle("MEDIDAS_CORRECTIVAS", this.AjusteId)%>
      </p>
    </div>
    <div id="divSituacionActual" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("SITUACION_ACTUAL",this.AjusteId)) %>'>
      <h2>
        SITUACIÓN ACTUAL</h2>
      <p>
        <%= GestorInforme.getSubtitle("SITUACION_ACTUAL", this.AjusteId)%>
      </p>
    </div>
    <div id="divObservaciones" style='<%= CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("OBSERVACIONES",this.AjusteId)) %>'>
      <h2>
        OBSERVACIONES
      </h2>
      <p>
        <%= GestorInforme.getSubtitle("OBSERVACIONES", this.AjusteId)%>
      </p>
    </div>
    <div id="divTitulosAdionales" runat="server">
      <cc1:Repeater ID="repeaterTitulos" runat="server" DataSourceID="odsTitulosAdicionales">
        <ItemTemplate>
          <h2>
            <asp:Literal ID="SubtituloSeccionLabel" runat="server" Text='<%# Eval("TituloSeccion") %>'></asp:Literal>
          </h2>
          <asp:Literal ID="ContenidoSeccionLabel" runat="server" Text='<%# Eval("contenidoSeccion") %>'></asp:Literal></td>
        </ItemTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsTitulosAdicionales" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReportePacificoTableAdapters.InformeSeccionesAjusteSelectPacificoTableAdapter"
        OnSelected="odsTitulosAdicionales_Selected">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <h3>
      Preventores Asociados</h3>
    <p>
      Ajustadores y Peritos de Seguros S.A.A.</p>
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <h3>
      Ing. Rafael Romero</h3>
    <p>
      Gerente de Riesgos Generales<br />
      A.P.J: 012 / A.P.N: 044</p>
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
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoImagenesTableAdapter"
        OnSelected="odsImagenes_Selected">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
  </form>
</body>
</html>
