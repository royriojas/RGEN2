<%@ Page Title="" Language="C#" MasterPageFile="~/RimacInforme/RimacFormsMaster.master"
  ValidateRequest="false" AutoEventWireup="true" CodeFile="InformeBasico.aspx.cs"
  Inherits="RimacInforme_InformeBasico" %>

<%@ Register Src="detalleSublimitesAfectados.ascx" TagName="detalleSublimitesAfectados"
  TagPrefix="uc1" %>
<%@ Register Src="Deducibles.ascx" TagName="Deducibles" TagPrefix="uc2" %>
<%@ Register Src="Clausulas.ascx" TagName="Clausulas" TagPrefix="uc3" %>
<%@ Register Src="Damage.ascx" TagName="Damage" TagPrefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  <script type="text/javascript">
        $(function() {
            $('.Group-Content').hide();

            $('.Group .Legend').css({ cursor: 'pointer' }).toggle(function() {
                $(this).next().fadeIn(300);
            }, function() {
                $(this).next().fadeOut(300);
            });

            var actionbuttons = '<div class="ActionBar CommandButtons">' +
				'<ul>' +
					'<li><a class="LinkButton Save Little" href=""><span>Grabar</span></a></li>' +
					'<li><a class="LinkButton Generate Little" href=""><span>Generar</span></a></li>' +
					'<li><a class="LinkButton Observate Little" href=""><span>Observar</span></a></li>' +
					'<li><a class="LinkButton Preview Little" href=""><span>Vista Previa HTML</span></a></li>' +
					'<li><a class="LinkButton PreviewPDF Little" href=""><span>Vista Previa PDF</span></a></li>' +
				'</ul>' +
			'</div>';

            $('.Group .Legend').append(actionbuttons);

            $('.Group .Legend').hover(function() { $(this).addClass('hover') }, function() { $(this).removeClass('hover'); });

            $('a.LinkButton.Save').click(function() {
                __doPostBack('ctl00$ContentPlaceHolder1$LnkSave', '');
            });

            $('a.GoDocuments').click(function() {
                showModalDialog('<%= ResolveClientUrl("~/vDocumentos.aspx?AjusteId=" + Request.QueryString["AjusteId"]) %>');
                return false;
            });
            
            $('a.LinkButton.Preview').attr('target','_blank').attr('href','<% = String.Format( ResolveClientUrl("~/vVistaPrevia.aspx?AjusteId={0}&TI={1}"), Request.QueryString["AjusteId"] , "IB") %>');

        });
  </script>

  <asp:LinkButton ID="LnkSave" Style="display: none;" OnClick="DoSave" runat="server">Save</asp:LinkButton>
  <div class="InformeBasico InformeInner">
    <asp:ObjectDataSource ID="odsInforme" runat="server" DataObjectTypeName="App_Code.RimacInforme.Domain.AjusteDto"
      OldValuesParameterFormatString="{0}" SelectMethod="GetInformeBasicoByAjusteId"
      TypeName="App_Code.RimacInforme.Persistence.AjusteDtoOds" UpdateMethod="Update">
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="-1" Name="ajusteId" QueryStringField="AjusteId"
          Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="FormViewInforme" DataKeyNames="AjusteId" Width="100%" runat="server"
      DefaultMode="Edit" DataSourceID="odsInforme" OnDataBound="FormViewInforme_DataBound"
      OnItemUpdating="FormViewInforme_ItemUpdating" OnDataBinding="FormViewInforme_DataBinding">
      <EditItemTemplate>
        <div class="FormCSS">
          <div class="Group AseguradoInfo">
            <div class="Legend">
              <h2>
                <span>Información del Asegurado</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Contratante:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" ID="_txtContratante" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).InfoAsegurado.Contratante %>'
                    runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field First">
                <label>
                  Asegurado:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" ID="_txtAsegurado" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).InfoAsegurado.Asegurado %>'
                    runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Giro del negocio / ocupación:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly tinymce-simple" TextMode="MultiLine" Rows="3"
                    ID="_txtGiroNegocio" runat="server" Text='<%# Bind("GiroNegocio") %>'></asp:TextBox>
                </div>
              </div>
              <div class="Field">
                <label>
                  Broker:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtBroker" CssClass="FormText Readonly" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).InfoAsegurado.Broker %>'
                    runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="Field">
                <label>
                  Ejecutivo:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtEjecutivo" CssClass="FormText Readonly" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).InfoAsegurado.EjecutivoBroker %>'
                    runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          <div class="Group InformacionPoliza">
            <div class="Legend">
              <h2>
                <span>Información de la Póliza</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Poliza:
                </label>
                <div class="FieldWrapper">
                  <asp:LinkButton OnClick="GotoPoliza" CssClass="LinkButton Little GoPoliza" ID="_lnkGoPoliza"
                    runat="server">
                    <span>
                      <asp:Literal ID="PolizasLinks" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).Poliza.PolizaNumber %>'
                        runat="server"></asp:Literal></span></asp:LinkButton>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field First">
                <label>
                  Vigencia:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtVigencia" CssClass="FormText Readonly" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).Poliza.Vigencia %>'
                    runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field">
                <label>
                  Tipo (Producto):
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtTipoProducto" CssClass="FormText Readonly" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).Poliza.Tipo %>'
                    runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field">
                <label>
                  Ramo:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtRamo" CssClass="FormText Readonly" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).Poliza.Ramo %>'
                    runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Límites (US$):
                </label>
                <div class="FieldWrapper">
                  <uc1:detalleSublimitesAfectados ID="detalleSublimitesAfectados1" runat="server" />
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Deducibles (US$):
                </label>
                <div class="FieldWrapper List">
                  <uc2:Deducibles ID="Deducibles1" runat="server" />
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Cláusulas aplicables
                </label>
                <div class="FieldWrapper List">
                  <uc3:Clausulas ID="Clausulas1" runat="server" />
                </div>
              </div>
            </div>
          </div>
          <div class="Group RecepcionCaso">
            <div class="Legend">
              <h2>
                <span>Recepción del Caso</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  # Ref. Asegurador
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("Recepcion.NumeroAseguradora") %>'
                    ID="_txtRefAsegurador" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field First">
                <label>
                  Recepción:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("Recepcion.Recepcion") %>'
                    ID="_txtRecepcion" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field">
                <label>
                  Confirmado con:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("Recepcion.ConfirmadoCon") %>'
                    ID="_txtConfirmadoCon" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field">
                <label>
                  Ajustador:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("Recepcion.Ajustador") %>'
                    ID="_txtAjustador" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          <div class="Group InformacionOcurrencia">
            <div class="Legend">
              <h2>
                <span>Información de la ocurrencia / descubrimiento</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Fecha y Hora del Siniestro:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("FechaYHoraSiniestro") %>'
                    ID="_txtFechaHoraSiniestro" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field First">
                <label>
                  Lugar del Siniestro:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("LugarDeSiniestro") %>'
                    ID="_txtLugarDelSiniestro" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Descripción del Siniestro:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText tinymce-simple" Text='<%# Bind("DescripcionSiniestro") %>'
                    TextMode="MultiLine" ID="_txtDescripcionSiniestro" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Ocurrencia:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtOcurrencia" Text='<%# Bind("Ocurrencia") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Daños</label>
                <div class="FieldWrapper">
                  <uc4:Damage ID="Damage1" runat="server" />
                </div>
                <div class="doClear">
                </div>
                <asp:LinkButton OnClick="GotoDamage" CssClass="LinkButton Little GoDamage" ID="_lnkGoDamage"
                  runat="server">
                  <span>
                    <asp:Literal ID="DamageLinks" Text='Daños:' runat="server"></asp:Literal></span></asp:LinkButton>
                <div class="doClear">
                </div>
              </div>
            </div>
          </div>
          <div class="Group InformacionInspeccion">
            <div class="Legend">
              <h2>
                <span>Información de la inspección</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Coordinación:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("InfoInspeccion.PersonaContacto") %>'
                    ID="_txtCoordinacion" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field First">
                <label>
                  Inspección:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("InfoInspeccion.FechaInspeccion") %>'
                    ID="_txtInspeccion" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field First">
                <label>
                  Lugar de Inspección:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("InfoInspeccion.LugarInspeccion") %>'
                    ID="_txtLugarDeInspeccion" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field">
                <label>
                  Persona Entrevistada:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("InfoInspeccion.PersonaEntrevistada") %>'
                    ID="_txtPersonaEntrevistada" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          <div class="Group SituacionActual">
            <div class="Legend">
              <h2>
                <span>Situación Actual</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First TextEdit">
                <label>
                  Situación del Siniestro:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox Text='<%# Bind("SituacionSiniestro") %>' ID="_txtSituacionSiniestro"
                    CssClass="FormText tinymce-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <asp:HyperLink CssClass="LinkButton Little GoDocuments" ID="_lnkGoDocuments" Style="width: 200px"
                  runat="server">
                  <span>
                    <asp:Literal ID="DocumentsLinks" Text='Documentos Solicitados:' runat="server"></asp:Literal></span></asp:HyperLink>
                <div class="doClear">
                </div>
              </div>
            </div>
          </div>
          <div class="Group Montos">
            <div class="Legend">
              <h2>
                <span>Montos</span></h2>
            </div>
            <asp:ObjectDataSource ID="odsComboMoneda" runat="server" OldValuesParameterFormatString="{0}"
              SelectMethod="GetData" TypeName="dsComboTableAdapters.MonedaComboTableAdapter">
            </asp:ObjectDataSource>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Monto de Aviso / Reclamo
                </label>
                <div class="FieldWrapper">
                  <div class="InlineElements">
                    <asp:DropDownList ID="_dropDownListTipoMonedaReclamo" runat="server" DataSourceID="odsComboMoneda"
                      DataTextField="simbolo" DataValueField="monedaId" AppendDataBoundItems="true">
                      <asp:ListItem Text="Elija" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox CssClass="FormText" Text='<%# Bind("Reclamo") %>' ID="_txtMontoAvisoReclamo"
                      runat="server"></asp:TextBox>
                  </div>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field First">
                <label>
                  Reserva Preliminar
                </label>
                <div class="FieldWrapper">
                  <div class="InlineElements">
                    <asp:DropDownList ID="_dropDownListTipoMonedaReserva" runat="server" DataSourceID="odsComboMoneda"
                      DataTextField="simbolo" DataValueField="monedaId" AppendDataBoundItems="true">
                      <asp:ListItem Text="Elija" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox CssClass="FormText" Text='<%# Bind("Reserva") %>' ID="_txtReservaPreliminar"
                      runat="server"></asp:TextBox>
                  </div>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          <div class="Group NotasFinales">
            <div class="Legend">
              <h2>
                <span>Notas Finales</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Favor enviar copia de la póliza:
                </label>
                <div class="FieldWrapper">
                  <asp:RadioButtonList ID="_radioListEnviarCopiaPoliza" SelectedValue='<%# Bind("EnviarCopiaPoliza") %>'
                    CssClass="RadioList" RepeatLayout="Flow" RepeatDirection="Horizontal" runat="server">
                    <asp:ListItem Text="Sí" Value="True"></asp:ListItem>
                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                  </asp:RadioButtonList>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field ">
                <label>
                  Favor enviar N° de Siniestro:
                </label>
                <div class="FieldWrapper">
                  <asp:RadioButtonList ID="_radioListEnviarFechaSiniestro" SelectedValue='<%# Bind("EnviaNumeroSiniestro") %>'
                    CssClass="RadioList" RepeatLayout="Flow" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Sí" Value="True"></asp:ListItem>
                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                  </asp:RadioButtonList>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Notas</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtNotas" Text='<%# Bind("Notas") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
      </EditItemTemplate>
    </asp:FormView>
  </div>
</asp:Content>
