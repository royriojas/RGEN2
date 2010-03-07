<%@ Page Title="" Language="C#" MasterPageFile="~/RimacInforme/RimacFormsMaster.master"
  ValidateRequest="false" AutoEventWireup="true" CodeFile="InformeComplementario.aspx.cs"
  Inherits="RimacInforme_InformeComplementario" %>

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
					'<li><a class="LinkButton Save Little" href=""><span>Grabar</span></a></li>' +
					'<li><a class="LinkButton Generate Little" href="#"><span>Generar</span></a></li>' +
					'<li><a class="LinkButton Observate Little" href=""><span>Observar</span></a></li>' +
					'<li><a class="LinkButton Preview Little" target="_blank" href="<%= String.Format( ResolveClientUrl("~/vVistaPrevia.aspx?AjusteId={0}&TI={1}"), Request.QueryString["AjusteId"] , GetTipoInforme()) %>"><span>Vista Previa HTML</span></a></li>' +
					'<li><a class="LinkButton PreviewPDF Little" target="_blank" href=""><span>Vista Previa PDF</span></a></li>' +
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



        });
  </script>

  <asp:LinkButton ID="LnkSave" Style="display: none;" OnClick="DoSave" runat="server">Save</asp:LinkButton>
  <div class="InformeComplementario InformeInner">
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
          
          <div class="Group AseguradoInfo  IFC">
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
          
          <div class="Group RecepcionCaso  IFC">
            <div class="Legend">
              <h2>
                <span>Información del Caso</span></h2>
            </div>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  # Ref. Asegurador
                </label>
                <div class="FieldWrapper">
                  <asp:TextBox CssClass="FormText Readonly" Text='<%# Eval("Recepcion.NumeroAseguradora") %>'
                    ID="TextBox1" runat="server"></asp:TextBox>
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
                    ID="TextBox2" runat="server"></asp:TextBox>
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
                    ID="TextBox3" runat="server"></asp:TextBox>
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
                    ID="TextBox4" runat="server"></asp:TextBox>
                </div>
                <div class="doClear">
                </div>
              </div>
              <div class="doClear">
              </div>
            </div>
          </div>
          
          <div class="Group InformacionPoliza IFC">
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
                  <asp:TextBox ID="_txtSumaAsegurada" CssClass="FormText Readonly" Text='<%# ((Container.DataItem) as App_Code.RimacInforme.Domain.AjusteDto).SumaAsegurada %>'
                    runat="server"></asp:TextBox>
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
          
          <div class="Group InformacionOcurrencia IFC">
            <div class="Legend">
              <h2>
                <span>Información de la ocurrencia / descubrimiento</span></h2>
            </div>
            <div class="Group-Content">
              
              <div class="Field TextEdit">
                <label>
                  Causas del Siniestro</label>
                <div class="FieldWrapper">
                  <asp:TextBox ID="_txtCausasSiniestros" Text='<%# Bind("CausasSiniestro") %>' CssClass="FormText tinymce-simple"
                    TextMode="MultiLine" runat="server"></asp:TextBox>
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
          
          <div class="Group Montos  IFC">
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
                  Reserva Neta
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
