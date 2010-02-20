<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vSolicitudDatos.aspx.cs"
  Inherits="vSolicitudDatos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <title>Riesgos Generales | Documentos </title>
  <!-- Scripts -->

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_core.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_event.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_dom.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_checkAll.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script type="text/javascript" src="Scripts/lib/xCaseOperations.js"></script>

  <link rel="stylesheet" type="text/css" href="scripts/popUpWin/css/style.css" />
  <link rel="stylesheet" type="text/css" href="scripts/popUpWin/css/subModal.css" />

  <script type="text/javascript" language="javascript">
	
	 function ocultaMuestraFechas(e){
	    var fechita = new Date();
	    var evt = new xEvent(e);
	    //alert(evt.target.id);
	    var elemento = xGetElementById(evt.target.id+'fentrega');
	    if (evt.target.checked) {	 
	        elemento.style.display = "inline";
	        elemento.value = ((fechita.getUTCDate()<10)? "0"+fechita.getUTCDate():fechita.getUTCDate())+ "/" + 
	                        ((fechita.getUTCMonth()<10)? "0"+fechita.getUTCMonth():fechita.getUTCMonth()) + "/" 
	                        + fechita.getUTCFullYear();
	    }
	    else {
	        elemento.style.display = "none";
	    }
	    
	 }  
	 function activaComportamientosCheckBox() {
	    var checks = xGetElementsByClassName('FormCheck');
	    for (i = 0; i < checks.length; i++) {
	        xAddEventListener(checks[i],'click',ocultaMuestraFechas,true);
	    }
	  
	 }
	
	 window.onload = function() {
	    activaComportamientosCheckBox();
	    //var x_check = new xCheckAll_NET('chkTodos','div_documentos_solicitados');
	    if (<%=Editar%>) {
	        var collapsible = new CollapsibleDiv ('trg_busqueda',
						     'trg_busqueda_ocultar',
						     true,
						     null
						    );
		}		
		
		
	 }
	 
	 function validaSeparacion(ele) {
	    return confirm('Desea quitar de la lista al requisito : '+ele);
	 }
	 
	 function muestraPopUp(url) {	 
	    try {
	        if ($('frmSolicitud_txtNumSolicitud').value != "") {
	                showPopWin(url+'AjusteId=<%=qStringAjusteId %>&solicitudDocumentosId=<%=qStringSolicitudDocumentosId%>&NumAjusteSolicitud='+$('frmSolicitud_txtNumSolicitud').value, 450, 380, null);            
            }
            else {
                alert ('El número de la solicitud No puede estar en blanco');
            }
       }
       catch(e) {
            alert(e.message);
       }       
	 }
	 
	 function pideDestinatarios() {	  
	    var indice = $('frmSolicitud_cbxTipoCarta').value;
	    switch(indice) {
	        case 'Solicitud' : 	        
	            muestraPopUp('vCreaSolicitudDocumentos.aspx?tipo=Solicitud&');
	         break;
	        case 'Recordatorio' : 	        
	            muestraPopUp('vCreaSolicitudDocumentos.aspx?tipo=Recordatorio&');
	         break;
	        case 'Agradecimiento' : 	        
	            muestraPopUp('vCreaSolicitudDocumentos.aspx?tipo=Agradecimiento&');
	         break;
	    }
	 
	 }	
	 
  </script>

  <style type="text/css">
       .invisible {
            display:none;
        }
    </style>
  <link rel='stylesheet' type='text/css' href='css/layout.css' />
</head>
<body>
  <div style="width: 738px; overflow: auto; height: 460px; position: relative;">
    <div style="width: 718px;">
      <form id="form1" runat="server">
        <div style="padding: 5px; background: #417EC2">
          <div class="PanelEncabezado">
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="18px">Solicitud de Datos</asp:Label>&nbsp;&nbsp;
            <asp:Button ID="btnVolver" Style="position: relative; top: 2px; left: 442px;" runat="server"
              CssClass="FormButton" Text="Volver" OnClick="btnVolver_Click" />
          </div>
          <div class="hr">
          </div>
          <div id="CabeceraSolicitud" style="background-color: #AAC8DF; border: 1px solid #6699CC;
            padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px;
            position: relative;" class="DataTable">
            <asp:Label Style="display: none;" ID="lblSolicitud" runat="server" Text="SolicitudId"
              Visible="False"></asp:Label>
            <asp:FormView ID="frmSolicitud" runat="server" DataKeyNames="solicitudDocumentosId"
              DataSourceID="sdsDocumentos" DefaultMode="Insert" OnItemInserting="frmSolicitud_ItemInserting"
              OnItemUpdating="frmSolicitud_ItemUpdating" Height="104px">
              <EditItemTemplate>
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td style="width: 150px; height: 28px">
                      Número de Solicitud<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="txtNumSolicitud" ErrorMessage="(*)" ValidationGroup="FrmInsertEdit"></asp:RequiredFieldValidator></td>
                    <td style="width: 201px; height: 28px">
                      <asp:TextBox ID="txtNumSolicitud" runat="server" CssClass="FormText" Text='<%# Bind("numeroSolicitud") %>'
                        Width="200px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td style="width: 150px; height: 28px" colspan="1">
                      En Referencia a<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="txtEnReferencia" ErrorMessage="(*)" ValidationGroup="FrmInsertEdit"></asp:RequiredFieldValidator></td>
                    <td style="width: 201px; height: 28px">
                      <asp:TextBox ID="txtEnReferencia" runat="server" CssClass="FormText" Text='<%# Bind("enreferencia") %>'
                        Width="200px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td style="width: 150px; height: 28px">
                      Tipo
                    </td>
                    <td style="width: 201px; height: 28px">
                      <asp:DropDownList ID="cbxTipoCarta" runat="server" CssClass="FormText" Width="204px"
                        SelectedValue='<%# Bind("tipo") %>'>
                        <asp:ListItem Value="Solicitud">Solicitud</asp:ListItem>
                        <asp:ListItem>Recordatorio</asp:ListItem>
                        <asp:ListItem>Agradecimiento</asp:ListItem>
                      </asp:DropDownList></td>
                  </tr>
                </table>
              </EditItemTemplate>
              <InsertItemTemplate>
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td style="width: 159px; height: 28px">
                      Número de Solicitud
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="numeroSolicitudTextBox"
                        ErrorMessage="(*)" ValidationGroup="FrmInsertEdit"></asp:RequiredFieldValidator></td>
                    <td style="width: 201px; height: 28px">
                      <asp:TextBox ID="numeroSolicitudTextBox" runat="server" CssClass="FormText" Text='<%# Bind("numeroSolicitud") %>'
                        Width="200px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td style="width: 159px; height: 28px">
                      En Referencia a
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="enreferenciaTextBox"
                        ErrorMessage="(*)" ValidationGroup="FrmInsertEdit"></asp:RequiredFieldValidator></td>
                    <td style="width: 201px; height: 28px">
                      <asp:TextBox ID="enreferenciaTextBox" runat="server" CssClass="FormText" Text='<%# Bind("enreferencia") %>'
                        Width="200px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td style="width: 159px; height: 28px">
                      Tipo
                    </td>
                    <td style="width: 201px; height: 28px">
                      <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" Width="204px"
                        SelectedValue='<%# Bind("tipo") %>'>
                        <asp:ListItem Value="Solicitud">Solicitud</asp:ListItem>
                        <asp:ListItem>Recordatorio</asp:ListItem>
                        <asp:ListItem>Agradecimiento</asp:ListItem>
                      </asp:DropDownList></td>
                  </tr>
                </table>
              </InsertItemTemplate>
            </asp:FormView>
            <asp:Button Style="position: absolute; right: 22px; top: 18px;" ID="btnEnviarPorCorreo"
              runat="server" CssClass="FormButton" Text="Enviar por Correo" Width="110px" Visible="False" />
            <asp:Button Style="position: absolute; right: 22px; bottom: 10px;" ID="btnGuardarSolicitud"
              runat="server" Text="Guardar" CssClass="FormButton" OnClick="btnGuardarSolicitud_Click"
              Width="110px" ValidationGroup="FrmInsertEdit" />
            <button style="width: 110px; position: absolute; right: 22px; top: 38px;" id="btnGenerarCarta"
              runat="server" onclick="pideDestinatarios();" class="FormButton" visible="false">
              Generar Carta</button>
          </div>
          <asp:Panel ID="Panel1" runat="server" Visible="False">
            <p class="labels">
              Documentos Solicitados
            </p>
            <div id="div_documentos_solicitados" style="background-color: #AAC8DF; border: 1px solid #6699CC;
              padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px;
              position: relative;" class="DataTable">
              <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsDocumentosDeSolicitud"
                AutoGenerateColumns="False" Width="100%" OnRowDataBound="GridView1_RowDataBound"
                OnRowCommand="GridView1_RowCommand">
                <Columns>
                  <asp:BoundField DataField="requisitoId" HeaderText="requisitoId" SortExpression="requisitoId">
                    <ItemStyle CssClass="invisible" />
                    <HeaderStyle CssClass="invisible" />
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="Orden" SortExpression="Orden">
                    <EditItemTemplate>
                      <asp:TextBox ID="txtOrden" runat="server" Text='<%# Bind("Orden") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:TextBox ID="txtOrden" CssClass="FormText NATURAL" runat="server" Text='<%# Bind("Orden") %>'
                        Width="25px"></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle Width="30px" />
                  </asp:TemplateField>
                  <asp:BoundField DataField="nombre" HeaderText="Documento" SortExpression="nombre" />
                  <asp:TemplateField HeaderText="Recibido">
                    <ItemTemplate>
                      &nbsp;<asp:CheckBox ID="chk" runat="server" CssClass="FormCheck" />
                      <asp:TextBox ID="chkfentrega" Style="display: none;" runat="server" CssClass="FormText"
                        Width="103px"></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle Width="135px" />
                  </asp:TemplateField>
                  <asp:BoundField DataField="estado" HeaderText="estado" SortExpression="estado" Visible="False" />
                  <asp:TemplateField>
                    <ItemStyle Width="20px" />
                    <ItemTemplate>
                      <asp:ImageButton ID="btnQuitar" runat="server" CommandArgument='<%# Eval("requisitoId") %>'
                        CommandName="QUITAR" ImageUrl="~/img/quitar_de_lista.png" OnClientClick='<%# "return validaSeparacion(\""+Eval("nombre")+"\");" %>'
                        ToolTip="Remover de esta lista" />
                    </ItemTemplate>
                  </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="ItemStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
              </asp:GridView>
            </div>
            <p id="trg_busqueda" class="labels">
              B&uacute;squeda De Documentos
            </p>
            <div id="trg_busqueda_ocultar" style="background-color: #AAC8DF; border: 1px solid #6699CC;
              padding-right: 10px; padding-left: 10px; left: 0px; padding-bottom: 10px; padding-top: 10px;
              position: relative;" class="DataTable">
              <table>
                <tr>
                  <td style="width:120px;">
                    Ramo</td>
                  <td>
                    <asp:DropDownList ID="cbxRiesgos" runat="server" CssClass="FormText" DataSourceID="odsRamos"
                      DataTextField="nombre" DataValueField="ramoId" OnDataBound="cbxRiesgos_DataBound"
                      Width="254px">
                    </asp:DropDownList>
                  </td>
                  <td style="width: 10px;">
                  </td>
                  <td>
                    <asp:Button ID="btnBuscar" runat="server" CssClass="FormButton" Text="Mostrar" OnClick="btnBuscar_Click" />
                  </td>
                </tr>
                <tr>
                  <td>
                    Nombre Documento
                  </td>
                  <td>
                    <asp:TextBox ID="txtNombreDocumento" runat="server" CssClass="FormText" Width="250px"></asp:TextBox>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                </tr>
              </table>
              <br />
              <asp:GridView ID="grdViewDocumentosXRiesgo" runat="server" AutoGenerateColumns="False"
                DataSourceID="sdsDocumentosRelacionadosAlRiesgo" Width="100%">
                <Columns>
                  <asp:BoundField DataField="requisitoId" HeaderText="requisitoId" InsertVisible="False"
                    ReadOnly="True" SortExpression="requisitoId">
                    <ItemStyle CssClass="invisible" />
                    <HeaderStyle CssClass="invisible" />
                    <FooterStyle CssClass="invisible" />
                  </asp:BoundField>
                  <asp:BoundField DataField="documento" HeaderText="Documento Requerido" SortExpression="documento" />
                  <asp:TemplateField>
                    <ItemTemplate>
                      <asp:CheckBox ID="chkElegido" runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                  </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="ItemStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
                <EmptyDataTemplate>
                  No hay Documentos Asociados a este Riesgo
                </EmptyDataTemplate>
              </asp:GridView>
              <asp:Button Style="position: absolute; right: 10px; top: 12px;" ID="btnAddRequisito"
                runat="server" Text="Asociar Documentos" CssClass="FormButton" OnClick="btnAddRequisito_Click"
                Width="146px" />
            </div>
          </asp:Panel>
        </div>
      </form>
    </div>
  </div>
  <asp:ObjectDataSource ID="odsRamos" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsComboTableAdapters.RamoComboTableAdapter"></asp:ObjectDataSource>
  <asp:SqlDataSource ID="sdsDocumentosRelacionadosAlRiesgo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
    SelectCommand="sp_rgen_documentosXriesgoSelect" SelectCommandType="StoredProcedure">
    <SelectParameters>
      <asp:QueryStringParameter DefaultValue="" Name="solicitudDocumentosId" QueryStringField="solicitudDocumentosId"
        Type="Decimal" />
      <asp:ControlParameter ControlID="cbxRiesgos" Name="ramoId" PropertyName="SelectedValue"
        Type="Decimal" />
      <asp:ControlParameter ControlID="txtNombreDocumento" ConvertEmptyStringToNull="False"
        Name="nombre" PropertyName="Text" Type="String" />
    </SelectParameters>
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="sdsDocumentos" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
    DeleteCommand="UPDATE RGN_SOLICITUDDOCUMENTOS SET fupdate = @fupdate, estado = @estado, uupdate = @uupdate WHERE (solicitudDocumentosId = @solicitudDocumentosId)"
    InsertCommand="sp_rgen_solicitudDocumentosXInsert" SelectCommand="SELECT solicitudDocumentosId, numeroSolicitud, Fecha, ajusteId, fcrea, fupdate, estado, ucrea, uupdate, enreferencia, tipo FROM RGN_SOLICITUDDOCUMENTOS WHERE (solicitudDocumentosId = @solicitudDocumentosId)"
    UpdateCommand="UPDATE RGN_SOLICITUDDOCUMENTOS SET &#13;&#10;&#13;&#10;numeroSolicitud = @numeroSolicitud, &#13;&#10;estado = @estado, &#13;&#10;enreferencia = @enreferencia, &#13;&#10;uupdate = @uupdate, &#13;&#10;fupdate = @fupdate, &#13;&#10;tipo = @tipo &#13;&#10;&#13;&#10;WHERE (solicitudDocumentosId = @solicitudDocumentosId)&#13;&#10;"
    OnInserting="sdsDocumentos_Inserting" OnInserted="sdsDocumentos_Inserted" InsertCommandType="StoredProcedure">
    <DeleteParameters>
      <asp:Parameter Name="fupdate" />
      <asp:Parameter Name="estado" />
      <asp:Parameter Name="uupdate" />
      <asp:Parameter Name="solicitudDocumentosId" />
    </DeleteParameters>
    <UpdateParameters>
      <asp:Parameter Name="numeroSolicitud" />
      <asp:Parameter DefaultValue="A" Name="estado" />
      <asp:Parameter Name="enreferencia" />
      <asp:Parameter Name="uupdate" />
      <asp:Parameter Name="fupdate" />
      <asp:Parameter Name="tipo" />
      <asp:QueryStringParameter Name="solicitudDocumentosId" QueryStringField="SolicitudDocumentosId" />
    </UpdateParameters>
    <SelectParameters>
      <asp:QueryStringParameter DefaultValue="165" Name="solicitudDocumentosId" QueryStringField="solicitudDocumentosId" />
    </SelectParameters>
    <InsertParameters>
      <asp:Parameter Name="numeroSolicitud" DefaultValue="" Type="String" />
      <asp:QueryStringParameter DefaultValue="165" Name="ajusteId" QueryStringField="AjusteId" />
      <asp:Parameter Name="estado" DefaultValue="A" />
      <asp:Parameter Name="enreferencia" DefaultValue="" Type="String" />
      <asp:Parameter Name="tipo" Type="String" />
      <asp:Parameter Direction="InputOutput" Name="SolicitudDocumentosId" Type="Decimal" />
    </InsertParameters>
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="sdsInsertRequisitoEnAjuste" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
    InsertCommand="sp_rgen_requisitos_ajuste_insert" InsertCommandType="StoredProcedure"
    SelectCommand="sp_rgen_Requisitos" SelectCommandType="StoredProcedure">
    <SelectParameters>
      <asp:Parameter DefaultValue="165" Name="ajusteId" Type="Decimal" />
    </SelectParameters>
    <InsertParameters>
      <asp:Parameter Name="requisitoId" Type="Decimal" />
      <asp:Parameter Name="solicitudDocumentosId" Type="Decimal" />
      <asp:Parameter Name="ajusteId" Type="Decimal" />
      <asp:Parameter Name="ucrea" Type="String" />
    </InsertParameters>
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="sdsDocumentosDeSolicitud" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
    SelectCommand="sp_rgen_requerimientos_ajuste_select" SelectCommandType="StoredProcedure"
    UpdateCommand="UPDATE dbo.RGN_AJUSTE_RGN_REQUERIMIENTO SET FechaEntrega = @FechaEntrega, fupdate = @fupdate, estado = @estado, uupdate = @uupdate, orden = @orden WHERE (requisitoId = @requisitoId) AND (solicitudDocumentosId = @SolicitudDocumentosId)"
    OnUpdating="sdsDocumentosDeSolicitud_Updating" OnSelected="sdsDocumentosDeSolicitud_Selected"
    DeleteCommand="delete from RGN_AJUSTE_RGN_REQUERIMIENTO where requisitoId = @requisitoId and solicitudDocumentosId = @solicitudDocumentosId ">
    <SelectParameters>
      <asp:QueryStringParameter DefaultValue="" Name="solicitudDocumentosId" QueryStringField="SolicitudDocumentosId"
        Type="Decimal" />
      <asp:QueryStringParameter Name="AjusteId" QueryStringField="AjusteId" Type="Decimal" />
    </SelectParameters>
    <UpdateParameters>
      <asp:Parameter Name="FechaEntrega" />
      <asp:Parameter Name="fupdate" />
      <asp:Parameter Name="estado" />
      <asp:Parameter Name="uupdate" />
      <asp:Parameter Name="requisitoId" />
      <asp:Parameter Name="SolicitudDocumentosId" />
      <asp:Parameter Name="orden" />
    </UpdateParameters>
    <DeleteParameters>
      <asp:Parameter Name="requisitoId" />
      <asp:Parameter Name="solicitudDocumentosId" />
    </DeleteParameters>
  </asp:SqlDataSource>

  <script type="text/javascript">
        creaPopUpDivs();
  </script>

</body>
</html>
