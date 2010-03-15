<%@ Page Title="" Language="C#" MasterPageFile="~/RimacInforme/RimacFormsMaster.master"
  ValidateRequest="false" AutoEventWireup="true" CodeFile="InformeBasico.aspx.cs"
  Inherits="RimacInforme_InformeBasico" %>

<%@ Register Src="detalleSublimitesAfectados.ascx" TagName="detalleSublimitesAfectados"
  TagPrefix="uc1" %>
<%@ Register Src="Deducibles.ascx" TagName="Deducibles" TagPrefix="uc2" %>
<%@ Register Src="Clausulas.ascx" TagName="Clausulas" TagPrefix="uc3" %>
<%@ Register Src="Damage.ascx" TagName="Damage" TagPrefix="uc4" %>
<%@ Register Src="DocumentacionSolicitada.ascx" TagName="DocumentacionSolicitada"
  TagPrefix="uc5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  <script type="text/javascript">
        
        var selector = "<%= GetTipoInformeClass() %>"
        
        var ajusteId = '<%= Request.QueryString["AjusteId"] %>';

        $(function() {
        
            $(selector).show();
            
            $('.Group-Content').hide();

            $('.Group .Legend').css({ cursor: 'pointer' }).toggleWithoutPrevent(function(e) {

                if ($(e.target).is('a span') || $(e.target).is('a')) return true;
                $(this).next().fadeIn(300);
            }, function(e) {

                if ($(e.target).is('a span') || $(e.target).is('a')) return true;
                $(this).next().fadeOut(300);
            });
 
            var actionbuttons = '<div class="ActionBar CommandButtons">' +
				'<ul>' +
					'<li><a class="LinkButton Save Little ValidatorTrigger" href="" validation_group=".InformeSave"><span>Grabar</span></a></li>' +
					'<li><a class="LinkButton Generate Little" href="#"><span>Generar</span></a></li>' +
					'<li><a class="LinkButton Observate Little" href=""><span>Observar</span></a></li>' +
					'<li><a class="LinkButton Preview Little" target="_blank" href="<%= String.Format( ResolveClientUrl("~/vVistaPrevia.aspx?AjusteId={0}&TI={1}"), Request.QueryString["AjusteId"] , GetTipoInforme()) %>"><span>Vista Previa HTML</span></a></li>' +
					'<li><a class="LinkButton PreviewPDF Little" target="_blank" href=""><span>Vista Previa PDF</span></a></li>' +
					'<li><a class="LinkButton ImprimirPDF Little" target="_blank" href=""><span>Imprimir PDF</span></a></li>' +
				'</ul>' +
			'</div>';

            $('.Group .Legend').append(actionbuttons);

            $('.Group .Legend').hover(function() { $(this).addClass('hover') }, function() { $(this).removeClass('hover'); });

            $('a.LinkButton.Save').click(function() {
                __doPostBack('ctl00$ContentPlaceHolder1$LnkSave', '');
                return false;
            });

            $('a.GoDocuments').click(function() {
                showModalDialog('<%= ResolveUrl(string.Format("~/vDocumentos.aspx?AjusteId={0}", Request.QueryString["AjusteId"])) %>');
                return false;
            });

            $('a.LinkButton.Generate').click(function() {
                window.top.showPopWin('<%= ResolveUrl(string.Format("~/generarStatus.aspx?ajusteId={0}&tipoInforme={1}&observado=0", Request.QueryString["AjusteId"], GetTipoInforme())) %>', 229, 75, null);
                return false;
            });
            $('a.LinkButton.Observate').click(function() {
                window.top.showPopWin('<%= ResolveUrl(string.Format("~/generarStatus.aspx?ajusteId={0}&tipoInforme={1}&observado=1", Request.QueryString["AjusteId"], GetTipoInforme())) %>', 229, 75, null);
                return false;
            });

            $('a.LinkButton.PreviewPDF').click(function() {
                //window.top.ShowReport('genPreview.aspx?AjusteId='+ajusteId+'&TI=' + tipoInforme+'&NOW=NOW', 229, 75, null);   
                window.top.ShowReport('<%= ResolveUrl(string.Format("~/genPreview.aspx?AjusteId={0}&TI={1}&NOW=NOW&nc={2}", Request.QueryString["AjusteId"], GetTipoInforme() , DateTime.Now.Ticks)) %>', 229, 75, null);
                return false;
            });

            $('a.LinkButton.ImprimirPDF').click(function() {
                window.top.ShowReport('<%= ResolveUrl(string.Format("~/genPreviewImprimir.aspx?AjusteId={0}&TI={1}&NOW=NOW&nc={2}", Request.QueryString["AjusteId"], GetTipoInforme() , DateTime.Now.Ticks)) %>', 229, 75, null);
                return false;
            });
			
			//important to call after every validation
			$(document).initValidation();

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
          <div class="Group IFC">
            <div class="Field">
              <label>
                N&uacute;mero Informe Complementario</label>
              <div class="FieldWrapper">
                <asp:TextBox CssClass="FormText" ID="_txtNumInformeBasico" Text='<%# Bind("NumeroIfb")  %>'
                  runat="server"></asp:TextBox>
              </div>
            </div>
            <div class="doClear">
            </div>
          </div>
          <div class="Group AseguradoInfo  IFB IFP IFC IFF">
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
          <div class="Group InformacionPoliza IFB IFP IFC IFF">
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
                  Límites:
                </label>
                <!--div class="FieldWrapper">
                  <p>
                      <%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).MonedaSumaAsegurada%>
                      <%# String.Format("{0:#,##0.00}",((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).SumaAsegurada) %>
                  </p>
                  
                  
                </div-->
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText tinymce-simple" Text='<%# Bind("Limites") %>'
                    TextMode="MultiLine" ID="_txtLimites" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Deducibles:
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
          <div class="Group RecepcionCaso  IFB IFP IFC IFF">
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
          <div class="Group InformacionOcurrencia  IFB IFP IFC IFF">
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
                <!--div class="FieldWrapper List">
                  <uc4:Damage ID="Damage1" runat="server" />
                </div-->
                
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText tinymce-simple" Text='<%# Bind("DanosCaratula") %>'
                    TextMode="MultiLine" ID="_txtDanosCaratula" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
                
                <%-- <asp:LinkButton OnClick="GotoDamage" CssClass="LinkButton Little GoDamage" ID="_lnkGoDamage"
                  runat="server">
                  <span>
                    <asp:Literal ID="DamageLinks" Text='Daños:' runat="server"></asp:Literal></span></asp:LinkButton>
                <div class="doClear">
                </div> --%>
              </div>
            </div>
          </div>
          <div class="Group InformacionInspeccion IFB IFP IFC IFF">
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
              <div class="Field">
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
          <div class="Group SituacionActual IFB IFP IFC IFF">
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
                  <div class="doClear">
                  </div>
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Documentos Solicitados Pendientes de Entrega:
                </label>
                <uc5:DocumentacionSolicitada ID="DocumentacionSolicitada1" runat="server" />
              </div>
              <div class="Field">
                <label>
                  Click en el botón para ver los documentos solicitados</label>
                <div class="FieldWrapper">
                  <asp:HyperLink CssClass="LinkButton Little GoDocuments" ID="_lnkGoDocuments" Style="width: 200px"
                    runat="server">
                    <span>
                      <asp:Literal ID="DocumentsLinks" Text='Documentos Solicitados:' runat="server"></asp:Literal></span></asp:HyperLink>
                  <div class="doClear">
                  </div>
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          <div class="Group Montos  IFB IFP IFC IFF">
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
                    <asp:TextBox CssClass="FormText montoAviso" Text='<%# Bind("Reclamo") %>' ID="_txtMontoAvisoReclamo"
                      runat="server"></asp:TextBox>					  
                  </div>
				  
                </div>
				<p class="Validator Required InformeSave" field=".montoAviso">Requerido</p>
		          <p class="Validator RegularExpression InformeSave" field=".montoAviso" regex="^\d+(\.\d{1,2})?$">Solo números de la forma #.00</p>
		          
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
                    <asp:TextBox CssClass="FormText montoReserva" Text='<%# Bind("Reserva") %>' ID="_txtReservaPreliminar"
                      runat="server"></asp:TextBox>
					
                  </div>				  
                </div>
				<p class="Validator Required InformeSave" field=".montoReserva">Requerido</p>
		          <p class="Validator RegularExpression InformeSave" field=".montoReserva" regex="^\d+(\.\d{1,2})?$">Solo números de la forma #.00</p>
		          
                <div class="doClear">
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          <div class="Group NotasFinales IFB">
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
          <div class="Group DetalleInforme IFP IFF">
            <div class="Legend">
              <h2>
                <span>Detalle de las Secciones del Informe</span></h2>
            </div>
            <div class="Group-Content">
              <label>
                Click en el botón para editar las Secciones Adicionales del Informe</label>
              <asp:LinkButton OnClick="GotoSection" CssClass="LinkButton Little GoSection" ID="_lnkGoSection"
                Style="width: 200px" runat="server">
                <span>
                  <asp:Literal ID="SectionLinks" Text='Secciones Adicionales:' runat="server"></asp:Literal></span></asp:LinkButton>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Información General:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtDescripcionRiesgo" Text='<%# Bind("DescripcionRiesgo") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Descripcion del Lugar del Siniestro</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtDescripcionLugarSiniestro" Text='<%# Bind("DescripcionLugarSiniestro") %>'
                    CssClass="FormText tinymce-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Descripcion Bienes/Personas Afectadas</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtDescripcionBienesAfectados" Text='<%# Bind("DescripcionBienesAfectados") %>'
                    CssClass="FormText tinymce-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Antecedentes</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtAntecedentes" Text='<%# Bind("Antecedentes") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Investigaciones</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtInvestigaciones" Text='<%# Bind("Investigaciones") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Descripcion de los Daños</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtDescripcionDanos" Text='<%# Bind("DescripcionDamage") %>'
                    CssClass="FormText tinymce-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Causas del Siniestro</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtCausasSiniestros" Text='<%# Bind("CausasSiniestro") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Detalle Materia Asegurada de la Póliza</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtMateriaAsegurada" Text='<%# Bind("MateriaAsegurada") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Detalle Local Asegurado / Ubicación del Riesgo de la Póliza</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtLocalAsegurado" Text='<%# Bind("LocalAsegurado") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Sección de la Póliza</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtSeccion" Text='<%# Bind("Seccion") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Descripción del Reclamo</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtReclamo" Text='<%# Bind("DescripcionReclamo") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Cobertura / Opinion Ajustador</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtOpinionAjustador" Text='<%# Bind("OpinionAjustador") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Cumplimiento de Garantías / Prescripciones de Seguridad</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtVerificacionGarantias" Text='<%# Bind("VerificacionGarantias") %>'
                    CssClass="FormText tinymce-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Descripción de la reserva</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtDescripcionReserva" Text='<%# Bind("DescripcionReserva") %>'
                    CssClass="FormText tinymce-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Salvamento y Recupero</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtSalvamentoyrecupero" Text='<%# Bind("Salvamentoyrecupero") %>'
                    CssClass="FormText tinymce-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Medidas Correctivas / Recomendaciones</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtRecomendaciones" Text='<%# Bind("Recomendaciones") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          <div class="Group DetalleInformeComplementario IFC">
            <div class="Legend">
              <h2>
                <span>Detalle de las Secciones del Informe Complementario</span></h2>
            </div>
            <div class="Group-Content">
            <label>
                Click en el botón para editar las Secciones Adicionales del Informe</label>
              <asp:LinkButton OnClick="GotoSection" CssClass="LinkButton Little GoSection" ID="LinkButton1"
                Style="width: 200px" runat="server">
                <span>
                  <asp:Literal ID="Literal1" Text='Secciones Adicionales:' runat="server"></asp:Literal></span></asp:LinkButton>
              <div class="doClear">
              </div>
              <div class="Field TextEdit">
                <label>
                  Preambulo:
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtPreambulo" Text='<%# Bind("Antecedentes") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="Field TextEdit">
                <label>
                  Observaciones</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtObservaciones" Text='<%# Bind("Observaciones") %>' CssClass="FormText tinymce-simple"
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
