<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vNuevoAsegurado.aspx.cs"
  Inherits="vNuevoAsegurado" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Nuevo Asegurado</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/xCaseOperations.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript">
    
    var urlArgs;
    var action;
     
    function evaluateAction() {
        
        /*EVALUA LOS PARAMETROS VIA URL*/
       
        urlArgs = xGetURLArguments();
        action = xIsNull(urlArgs['action'],'nuevo');
        //alert(action);
        
        switch(action)
        {
            case 'nuevo' : doNewActions();
                break; 
            case 'editar': doEditActions();
                break;
            default : 
                break;            
        } 
        
        doInitActions();                   
    }
    
    function doInitActions() {

    }
    
    function doNewActions() {
        try {
            btn_ocultar = new CollapsibleDiv('openCloseBtn',
						     'nuevoRegDiv',						 
						     false,
						     null);
            deshabilitaCamposPersonaNatural('true');
        }
        catch(e) {
            alert(e.message);
        }
    }
    function doEditActions() {
         try {
            btn_ocultar = new CollapsibleDiv('openCloseBtn',
						     'nuevoRegDiv',						 
						     true,
						     null);
		    //simulo un click en los radioButtons
		        		    
		    if ($('FormView1_chk').checked) { 
		        $('FormView1_rbgrpNaturalJuridica_1').click();
		    }
		    else {
		        $('FormView1_rbgrpNaturalJuridica_0').click();
		    }
		    			   					
	    }
	    catch (e) {
	        alert (e.message);
	    }
    }
    
    window.onload = function () {
       evaluateAction();
    }
    
    function deshabilitaCamposPersonaNatural(key) {
        //alert(key == 'true');
        var habilitado = (key=='true');
	    var clase = (habilitado)? 'deshabilitado FormText MAYUSC': 'FormText MAYUSC';
	    var prefix = 'FormView1_'; //prefijo en el caso nuevo	    	    
	    
	    $(prefix+'ApellidoPaternoTextBox').className = clase;
	    $(prefix+'ApellidoPaternoTextBox').disabled = habilitado;
	    
	    $(prefix+'ApellidoMaternoTextBox').className = clase;	
	    $(prefix+'ApellidoMaternoTextBox').disabled = habilitado;
	    
	    $(prefix+'SegundoNombreTextBox').className = clase;
	    $(prefix+'SegundoNombreTextBox').disabled = habilitado;
	    
	    
		$('lblnombreRazonSocial').innerHTML = (habilitado)?"Razón Social":"Nombre";
		
	}
	
    function muestraOcultaPersonaJuridica(elemento) {				
		deshabilitaCamposPersonaNatural(elemento.value); 						
	}
	
    
  </script>

  <!-- por alguna extraña razon cuando necesito tener una clase CSS de manera dinámica no puedo sacarla del archivo css
        vinculado. Debo ponerla en la pagina -->
  <style type="text/css">
    
        .deshabilitado {                       
	        color: #CCCCCC;
	        background-color: #CCCCCC;	
	        font-family:Verdana;	
	        border-top:1px solid #41778B;
	        border-right:1px solid #D6D3CE;
	        border-bottom:1px solid #D6D3CE;
	        border-left:1px solid #42758C;
	        font-size:10px;
	        background-image:url(../imgRGen/fondo_FormText.gif);
	        background-repeat:repeat-x;	
        }

    </style>
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div style="position: relative; overflow: auto; width: 700px; height: 480px;">
      <div id="cont" style="width: 680px;">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%;">
            <div class="PanelEncabezado">
              <asp:Label ID="lblTitulo" runat="server" Font-Size="18px" Font-Bold="True">Nuevo Asegurado</asp:Label>
              <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar un Nuevo Asegurado"
                title="Agregar un Nuevo Asegurado" id="openCloseBtn" />
            </div>
            <div class="hr">
            </div>
            <div id="nuevoRegDiv" runat="server">
              <asp:FormView ID="FormView1" runat="server" DataKeyNames="personaId" DataSourceID="sdsAseguradoFRM"
                DefaultMode="Insert" Width="551px" OnItemInserting="FormView1_ItemInserting" OnItemUpdated="FormView1_ItemUpdated"
                OnItemUpdating="FormView1_ItemUpdating" OnDataBound="FormView1_DataBound" OnItemInserted="FormView1_ItemInserted"
                AllowPaging="True" Style="left: 0px">
                <InsertItemTemplate>
                  <div style="padding: 5px;" class="DataTable">
                    <table class="DataTable" width="630" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="130">
                          Tipo Persona</td>
                        <td width="176">
                          <asp:RadioButtonList ID="rbgrpNaturalJuridica" runat="server" Font-Bold="False" ForeColor="White"
                            RepeatDirection="Horizontal" TabIndex="13" SelectedValue='<%# Bind("chkPersonaJuridica") %>'>
                            <asp:ListItem onclick="muestraOcultaPersonaJuridica(this);" Value="false">Natural</asp:ListItem>
                            <asp:ListItem onclick="muestraOcultaPersonaJuridica(this);" Selected="True" Value="true">Jur&#237;dica</asp:ListItem>
                          </asp:RadioButtonList></td>
                        <td width="130">
                        </td>
                        <td width="194">
                        </td>
                      </tr>
                      <tr>
                        <td width="130">
                          <span id="lblnombreRazonSocial">Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                            runat="server" ControlToValidate="PrimerNombreTextBox" ErrorMessage="Elija un Nombre"
                            ValidationGroup="NuevoItem">(*)</asp:RequiredFieldValidator></span></td>
                        <td width="176">
                          <asp:TextBox ID="PrimerNombreTextBox" runat="server" CssClass="FormText MAYUSC" Text='<%# Bind("PrimerNombre") %>'
                            Width="160px"></asp:TextBox></td>
                        <td width="130">
                          Apellido Paterno</td>
                        <td width="194">
                          <asp:TextBox ID="ApellidoPaternoTextBox" runat="server" CssClass="FormText MAYUSC"
                            Text='<%# Bind("ApellidoPaterno") %>' Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td style="height: 16px">
                          Segundo Nombre</td>
                        <td style="height: 16px">
                          <asp:TextBox ID="SegundoNombreTextBox" runat="server" CssClass="FormText MAYUSC"
                            Text='<%# Bind("SegundoNombre") %>' Width="160px"></asp:TextBox></td>
                        <td style="height: 16px">
                          Apellido Materno</td>
                        <td style="height: 16px">
                          <asp:TextBox ID="ApellidoMaternoTextBox" runat="server" CssClass="FormText MAYUSC"
                            Text='<%# Bind("ApellidoMaterno") %>' Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Dirección</td>
                        <td>
                          <asp:TextBox ID="TextBox3" runat="server" CssClass="FormText" Text='<%# Bind("direccion") %>'
                            Width="160px"></asp:TextBox></td>
                        <td width="130">
                          Tipo Documento
                          <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="DropDownList1"
                            ErrorMessage="Debe Elegir un tipo" Operator="NotEqual" ValidationGroup="NuevoItem"
                            ValueToCompare="-1">(*)</asp:CompareValidator></td>
                        <td width="194">
                          <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" DataSourceID="odsTipoDocumento"
                            DataTextField="tdocid" DataValueField="tdocidId" SelectedValue='<%# Bind("tdocidId") %>'
                            Width="165px" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="-1">[ Elija ]</asp:ListItem>
                          </asp:DropDownList>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Distrito</td>
                        <td>
                          <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" BorderWidth="0px" CssClass="FormText"
                            DataType="Distrito" IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="15"
                            MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="12"
                            ResourcesDir="./asb_includes" SelectedValue='<%# Bind("ubigeoId") %>' SelMenuItemCSSClass="asbSelMenuItem"
                            UseIFrame="True" Width="160px" WarnNoValueSelected="false"></cc1:AutoSuggestBox>
                        </td>
                        <td style="height: 16px">
                          N° Documento
                        </td>
                        <td style="height: 16px">
                          <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Text='<%# Bind("docid") %>'
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                          Telefono Fijo
                        </td>
                        <td>
                          <asp:TextBox ID="TextBox4" runat="server" CssClass="FormText" Text='<%# Bind("TFIJO") %>'
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                          Fax</td>
                        <td>
                          <asp:TextBox ID="TextBox5" runat="server" CssClass="FormText" Text='<%# Bind("TFAX") %>'
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                          &nbsp;<asp:ImageButton ID="btnGuardar" runat="server" CommandName="Insert" ImageUrl="~/images/IconSave24.gif"
                            ValidationGroup="NuevoItem" /></td>
                        <td>
                        </td>
                        <td>
                        </td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                      </tr>
                    </table>
                  </div>
                  <asp:ObjectDataSource ID="odsTipoDocumento" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoDocumentoIdentidadComboTableAdapter">
                  </asp:ObjectDataSource>
                </InsertItemTemplate>
                <EditItemTemplate>
                  <div style="padding: 5px;" class="DataTable">
                    <table class="DataTable" width="630" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="130">
                          Tipo Persona</td>
                        <td width="176">
                          <asp:RadioButtonList ID="rbgrpNaturalJuridica" runat="server" Font-Bold="False" ForeColor="White"
                            RepeatDirection="Horizontal" TabIndex="13">
                            <asp:ListItem onclick="muestraOcultaPersonaJuridica(this);" Value="false">Natural</asp:ListItem>
                            <asp:ListItem onclick="muestraOcultaPersonaJuridica(this);" Selected="True" Value="true">Jur&#237;dica</asp:ListItem>
                          </asp:RadioButtonList></td>
                        <td width="130">
                          <asp:CheckBox Style="display: none;" ID="chk" runat="server" Checked='<%# Eval("chkPersonaJuridica") %>' /></td>
                        <td width="194">
                        </td>
                      </tr>
                      <tr>
                        <td width="130">
                          <span id="lblnombreRazonSocial">Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                            runat="server" ControlToValidate="PrimerNombreTextBox" ErrorMessage="Elija un Nombre"
                            ValidationGroup="NuevoItem">(*)</asp:RequiredFieldValidator></span></td>
                        <td width="176" style="color: #541c01">
                          <asp:TextBox ID="PrimerNombreTextBox" runat="server" CssClass="FormText MAYUSC" Text='<%# Bind("PrimerNombre") %>'
                            Width="160px"></asp:TextBox></td>
                        <td width="130" style="color: #541c01">
                          Apellido Paterno</td>
                        <td width="194">
                          <asp:TextBox ID="ApellidoPaternoTextBox" runat="server" CssClass="FormText MAYUSC"
                            Text='<%# Bind("ApellidoPaterno") %>' Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td style="height: 16px">
                          Segundo Nombre</td>
                        <td style="height: 16px">
                          <asp:TextBox ID="SegundoNombreTextBox" runat="server" CssClass="FormText MAYUSC"
                            Text='<%# Bind("SegundoNombre") %>' Width="160px"></asp:TextBox></td>
                        <td style="height: 16px">
                          Apellido Materno</td>
                        <td style="height: 16px">
                          <asp:TextBox ID="ApellidoMaternoTextBox" runat="server" CssClass="FormText MAYUSC"
                            Text='<%# Bind("ApellidoMaterno") %>' Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Dirección</td>
                        <td>
                          <asp:TextBox ID="TextBox3" runat="server" CssClass="FormText" Text='<%# Bind("direccion") %>'
                            Width="160px"></asp:TextBox></td>
                        <td width="130">
                          Tipo Documento
                          <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="DropDownList1"
                            ErrorMessage="Debe Elegir un tipo" Operator="NotEqual" ValidationGroup="NuevoItem"
                            ValueToCompare="-1">(*)</asp:CompareValidator></td>
                        <td width="194">
                          <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" DataSourceID="odsTipoDocumento"
                            DataTextField="tdocid" DataValueField="tdocidId" SelectedValue='<%# Bind("tdocidId") %>'
                            Width="165px" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="-1">[ Elija ]</asp:ListItem>
                          </asp:DropDownList>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Distrito</td>
                        <td>
                          <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" BorderWidth="0px" CssClass="FormText"
                            DataType="Distrito" IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="15"
                            MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="12"
                            ResourcesDir="./asb_includes" SelectedValue='<%# Bind("ubigeoId") %>' SelMenuItemCSSClass="asbSelMenuItem"
                            UseIFrame="True" Width="160px" Text='<%# Eval("ubigeo") %>'></cc1:AutoSuggestBox>
                        </td>
                        <td style="height: 16px">
                          N° Documento
                        </td>
                        <td style="height: 16px">
                          <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Text='<%# Bind("docid") %>'
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                          Telefono Fijo
                        </td>
                        <td>
                          <asp:TextBox ID="TextBox4" runat="server" CssClass="FormText" Text='<%# Bind("TFIJO") %>'
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                          Fax</td>
                        <td>
                          <asp:TextBox ID="TextBox5" runat="server" CssClass="FormText" Text='<%# Bind("TFAX") %>'
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                          <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="FormButton"
                            Text="Grabar" Width="125px" ValidationGroup="NuevoItem" /></td>
                        <td>
                        </td>
                        <td>
                        </td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                      </tr>
                    </table>
                  </div>
                  <asp:ObjectDataSource ID="odsTipoDocumento" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoDocumentoIdentidadComboTableAdapter">
                  </asp:ObjectDataSource>
                </EditItemTemplate>
              </asp:FormView>
            </div>
            <div style="clear: both">
            </div>
          </div>
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%;">
            <div class="PanelEncabezado">
              <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px">Asegurados</asp:Label>
              <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
                onclick="return separar();" Width="22px" CssClass="BtnSeparar"></asp:HyperLink>
            </div>
            <div class="hr">
            </div>
            <table>
              <tr>
                <td>
                  Nombre
                </td>
                <td style="width: 5px;">
                </td>
                <td>
                  <asp:TextBox ID="txtAsegurado" CssClass="FormText" Width="150px" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5px;">
                </td>
                <td>
                  <asp:Button ID="btnSearch" runat="server" Text="Buscar" CssClass="FormButton" OnClick="btnSearch_Click" />
                </td>
              </tr>
            </table>
            <div style="clear: both;">
              &nbsp;</div>
            <div style="padding: 1px;">
              <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="personaId"
                DataSourceID="sdsAsegurado" Width="646px" AllowPaging="True" PageSize="15" AllowSorting="True"
                OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating">
                <Columns>
                  <asp:BoundField DataField="personaId" HeaderText="personaId" InsertVisible="False"
                    ReadOnly="True" SortExpression="personaId">
                    <ItemStyle CssClass="invisible" />
                    <HeaderStyle CssClass="invisible" />
                  </asp:BoundField>
                  <asp:BoundField DataField="persona" HeaderText="Nombre o Raz&#243;n Social" SortExpression="persona" />
                  <asp:BoundField DataField="TFIJO" HeaderText="Tel&#233;fono" ReadOnly="True" SortExpression="TFIJO" />
                  <asp:BoundField DataField="direccion" HeaderText="Direcci&#243;n" SortExpression="direccion" />
                  <asp:BoundField DataField="ubigeo" HeaderText="Distrito" ReadOnly="True" SortExpression="ubigeo" />
                  <asp:TemplateField HeaderText="P. Jur&#237;dica" SortExpression="chkPersonaJuridica">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" Wrap="True" />
                    <ItemTemplate>
                      <div style="text-align: center;">
                        <asp:CheckBox ID="c" runat="server" Checked='<%# Bind("chkPersonaJuridica") %>' Enabled="false" /></div>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Estado" SortExpression="estado">
                    <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("estado") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# muestraEstado((String)Eval("estado")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                  </asp:TemplateField>
                  <asp:TemplateField>
                    <ItemStyle Width="60px" />
                    <ItemTemplate>
                      <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                        ImageUrl="~/imgRGen/button_edit.gif" OnClientClick='<%# setDireccion((decimal)Eval("personaId")) %>' />
                      &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False"
                        CommandName="Delete" ImageUrl='<%# setImage((String)Eval("estado")) %>' OnClientClick='<%# setMensajeConfirmacion((String)Eval("estado")) %>'
                        ToolTip='<%# setToolTip((String)Eval("estado")) %>' />
                    </ItemTemplate>
                  </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="ItemStyle" />
                <HeaderStyle CssClass="HeaderStyle" />
              </asp:GridView>
            </div>
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>
        </div>
      </div>
    </div>
    <asp:SqlDataSource ID="sdsAsegurado" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      InsertCommand="sp_rgen_AseguradoInsert" InsertCommandType="StoredProcedure" SelectCommand="sp_rgen_AseguradoSelectAll"
      SelectCommandType="StoredProcedure" DeleteCommand="sp_rgen_PersonaDelete" DeleteCommandType="StoredProcedure">
      <InsertParameters>
        <asp:Parameter Name="PrimerNombre" Type="String" />
        <asp:Parameter Name="SegundoNombre" Type="String" />
        <asp:Parameter Name="ApellidoPaterno" Type="String" />
        <asp:Parameter Name="ApellidoMaterno" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
        <asp:Parameter Name="TFIJO" Type="String" />
        <asp:Parameter Name="TFAX" Type="String" />
        <asp:Parameter Name="direccion" Type="String" />
        <asp:Parameter Name="ubigeoId" Type="String" />
        <asp:Parameter Name="tdocidId" Type="Decimal" />
        <asp:Parameter Name="docid" Type="String" />
        <asp:Parameter Direction="InputOutput" Name="personaId" Type="Decimal" />
        <asp:Parameter Name="chkPersonaJuridica" Type="Boolean" />
      </InsertParameters>
      <DeleteParameters>
        <asp:Parameter Name="personaId" Type="Decimal" />
        <asp:Parameter Name="uupdate" Type="String" />
      </DeleteParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="txtAsegurado" ConvertEmptyStringToNull="False" Name="persona"
          PropertyName="Text" Type="String" />
      </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsAseguradoFRM" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      InsertCommand="sp_rgen_AseguradoInsert" InsertCommandType="StoredProcedure" SelectCommand="sp_rgen_AseguradoSelectById"
      SelectCommandType="StoredProcedure" UpdateCommand="sp_rgen_aseguradoUpdate" UpdateCommandType="StoredProcedure">
      <UpdateParameters>
        <asp:Parameter Name="PrimerNombre" Type="String" />
        <asp:Parameter Name="SegundoNombre" Type="String" />
        <asp:Parameter Name="ApellidoPaterno" Type="String" />
        <asp:Parameter Name="ApellidoMaterno" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
        <asp:Parameter Name="TFIJO" Type="String" />
        <asp:Parameter Name="TFAX" Type="String" />
        <asp:Parameter Name="direccion" Type="String" />
        <asp:Parameter Name="ubigeoId" Type="String" />
        <asp:Parameter Name="tdocidId" Type="Decimal" />
        <asp:Parameter Name="docid" Type="String" />
        <asp:Parameter Name="personaId" Type="Decimal" />
        <asp:Parameter Name="chkPersonaJuridica" Type="Boolean" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter Name="personaId" QueryStringField="AseguradoId" Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:Parameter Name="PrimerNombre" Type="String" />
        <asp:Parameter Name="SegundoNombre" Type="String" />
        <asp:Parameter Name="ApellidoPaterno" Type="String" />
        <asp:Parameter Name="ApellidoMaterno" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
        <asp:Parameter Name="TFIJO" Type="String" />
        <asp:Parameter Name="TFAX" Type="String" />
        <asp:Parameter Name="direccion" Type="String" />
        <asp:Parameter Name="ubigeoId" Type="String" />
        <asp:Parameter Name="tdocidId" Type="Decimal" />
        <asp:Parameter Name="docid" Type="String" />
        <asp:Parameter Direction="InputOutput" Name="personaId" Type="Decimal" />
        <asp:Parameter Name="chkPersonaJuridica" Type="Boolean" />
      </InsertParameters>
    </asp:SqlDataSource>
  </form>
</body>
</html>
