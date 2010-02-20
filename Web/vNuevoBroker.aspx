<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vNuevoBroker.aspx.cs" Inherits="vNuevoBroker" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Nuevo Broker</title>
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
		    
		    			   					
	    }
	    catch (e) {
	        alert (e.message);
	    }
    }
    
    window.onload = function () {
       evaluateAction();
    }    
    
    
    
    
  </script>

  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div style="position: relative; overflow: auto; width: 700px; height: 480px;">
      <div id="cont" style="width: 680px; position: relative;">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%;">
            <div class="PanelEncabezado">
              <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="18px">Nuevo Broker</asp:Label>
              <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Broker" title="Agregar Broker"
                id="openCloseBtn" />
            </div>
            <div class="hr">
            </div>
            <div id="nuevoRegDiv" runat="server">
              <asp:FormView ID="FormView1" runat="server" DataKeyNames="personaId" DataSourceID="sdsBrokerFRM"
                DefaultMode="Insert" Width="551px" OnItemInserting="FormView1_ItemInserting" OnItemUpdating="FormView1_ItemUpdating"
                OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated">
                <InsertItemTemplate>
                  <div style="padding: 5px;" class="DataTable">
                    <table class="DataTable" width="630" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="130">
                          Raz&oacute;n Social
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="personaTextBox"
                            ErrorMessage="Escriba la Razón Social" ValidationGroup="newItem">(*)</asp:RequiredFieldValidator></td>
                        <td width="176">
                          <asp:TextBox ID="personaTextBox" runat="server" Text='<%# Bind("persona") %>' CssClass="FormText MAYUSC"
                            Width="160px"></asp:TextBox></td>
                        <td width="130">
                          Tipo Documento
                        </td>
                        <td width="194">
                          <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" SelectedValue='<%# Bind("tdocidId") %>'
                            Width="165px">
                            <asp:ListItem Selected="True" Value="6">RUC</asp:ListItem>
                          </asp:DropDownList>
                        </td>
                      </tr>
                      <tr>
                        <td style="height: 16px">
                        </td>
                        <td style="height: 16px">
                        </td>
                        <td style="height: 16px">
                          N&deg; Documento
                        </td>
                        <td style="height: 16px">
                          <asp:TextBox ID="documentoTextBox" runat="server" Text='<%# Bind("docid") %>' CssClass="FormText"
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Direcci&oacute;n</td>
                        <td>
                          <asp:TextBox ID="direccionTextBox" runat="server" Text='<%# Bind("direccion") %>'
                            CssClass="FormText" Width="160px"></asp:TextBox></td>
                        <td>
                          Telefono Fijo
                        </td>
                        <td>
                          <asp:TextBox ID="TFIJOTextBox" runat="server" Text='<%# Bind("TFIJO") %>' CssClass="FormText"
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Distrito</td>
                        <td>
                          <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" CssClass="FormText" DataType="Distrito"
                            IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="5" MenuCSSClass="asbMenu"
                            MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="10" ResourcesDir="./asb_includes"
                            SelectedValue='<%# Bind("ubigeoId") %>' SelMenuItemCSSClass="asbSelMenuItem" UseIFrame="True"
                            Width="160px"></cc1:AutoSuggestBox>
                        </td>
                        <td>
                          Fax</td>
                        <td>
                          <asp:TextBox ID="TFAXTextBox" runat="server" Text='<%# Bind("TFAX") %>' CssClass="FormText"
                            Width="160px"></asp:TextBox></td>
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
                      <tr>
                        <td style="height: 16px">
                        </td>
                        <td style="height: 16px">
                          &nbsp;<asp:ImageButton ID="btnGuardar" runat="server" CommandName="Insert" ImageUrl="~/images/IconSave24.gif"
                            ValidationGroup="newItem" /></td>
                        <td style="height: 16px">
                        </td>
                        <td style="height: 16px">
                        </td>
                      </tr>
                    </table>
                  </div>
                </InsertItemTemplate>
                <EditItemTemplate>
                  <div style="padding: 5px;" class="DataTable">
                    <div style="background: #2c84bd; padding: 5px; margin-bottom: 5px;">
                      <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px">Nuevo Broker</asp:Label>&nbsp;
                    </div>
                    <table class="DataTable" width="630" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="130">
                          Raz&oacute;n Social
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="personaTextBox"
                            ErrorMessage="Escriba la Razón Social" ValidationGroup="newItem">(*)</asp:RequiredFieldValidator></td>
                        <td width="176">
                          <asp:TextBox ID="personaTextBox" runat="server" Text='<%# Bind("persona") %>' CssClass="FormText MAYUSC"
                            Width="160px"></asp:TextBox></td>
                        <td width="130">
                          Tipo Documento
                        </td>
                        <td width="194">
                          <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" SelectedValue='<%# Bind("tdocidId") %>'
                            Width="165px">
                            <asp:ListItem Value="6">RUC</asp:ListItem>
                          </asp:DropDownList>
                        </td>
                      </tr>
                      <tr>
                        <td style="height: 16px">
                        </td>
                        <td style="height: 16px">
                        </td>
                        <td style="height: 16px">
                          N&deg; Documento
                        </td>
                        <td style="height: 16px">
                          <asp:TextBox ID="documentoTextBox" runat="server" Text='<%# Bind("docid") %>' CssClass="FormText"
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Direcci&oacute;n</td>
                        <td>
                          <asp:TextBox ID="direccionTextBox" runat="server" Text='<%# Bind("direccion") %>'
                            CssClass="FormText" Width="160px"></asp:TextBox></td>
                        <td>
                          Telefono Fijo
                        </td>
                        <td>
                          <asp:TextBox ID="TFIJOTextBox" runat="server" Text='<%# Bind("TFIJO") %>' CssClass="FormText"
                            Width="160px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Distrito</td>
                        <td>
                          <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" CssClass="FormText" DataType="Distrito"
                            IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="5" MenuCSSClass="asbMenu"
                            MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="10" ResourcesDir="./asb_includes"
                            SelectedValue='<%# Bind("ubigeoId") %>' SelMenuItemCSSClass="asbSelMenuItem" UseIFrame="True"
                            Width="160px" Text='<%# Eval("ubigeo") %>'></cc1:AutoSuggestBox>
                        </td>
                        <td>
                          Fax</td>
                        <td>
                          <asp:TextBox ID="TFAXTextBox" runat="server" Text='<%# Bind("TFAX") %>' CssClass="FormText"
                            Width="160px"></asp:TextBox></td>
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
                      <tr>
                        <td>
                        </td>
                        <td>
                          <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="FormButton"
                            Text="Grabar" Width="125px" ValidationGroup="newItem" /></td>
                        <td>
                        </td>
                        <td>
                        </td>
                      </tr>
                    </table>
                  </div>
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
          <div class="DataContentRight">
            <div class="PanelEncabezado">
              <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px">Brokers</asp:Label>
              <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
                onclick="return separar();" Width="22px" CssClass="BtnSeparar"></asp:HyperLink>
            </div>
            <div style="padding: 1px;">
              <div class="hr">
              </div>
              <div style="padding: 1px;">
                <div id="filterDiv" style="padding: 1px;" class="DataTable">
                  <table>
                    <tr>
                      <td>
                        <asp:Label ID="Label2" runat="server" Text="Razón Social : "></asp:Label>&nbsp;</td>
                      <td>
                        <asp:TextBox ID="txtNombreBroker" runat="server" CssClass="FormText MAYSUC" Width="250px"></asp:TextBox>
                      </td>
                      <td style="width: 54px">
                        <asp:Button ID="Button2" CssClass="FormButton" runat="server" Text="Buscar" />
                      </td>
                    </tr>
                  </table>
                </div>
              </div>
              <div style="padding: 1px;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="personaId"
                  DataSourceID="sdsBroker" Width="646px" AllowPaging="True" PageSize="15" AllowSorting="True"
                  OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating">
                  <Columns>
                    <asp:BoundField DataField="personaId" HeaderText="personaId" InsertVisible="False"
                      ReadOnly="True" SortExpression="personaId">
                      <ItemStyle CssClass="invisible" />
                      <HeaderStyle CssClass="invisible" />
                    </asp:BoundField>
                    <asp:BoundField DataField="persona" HeaderText="Raz&#243;n Social" SortExpression="persona" />
                    <asp:BoundField DataField="TFIJO" HeaderText="Tel&#233;fono" ReadOnly="True" SortExpression="TFIJO" />
                    <asp:BoundField DataField="direccion" HeaderText="Direcci&#243;n" SortExpression="direccion" />
                    <asp:TemplateField HeaderText="Estado" SortExpression="estado">
                      <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# muestraEstado((String)Eval("estado")) %>'></asp:Label>
                      </ItemTemplate>
                      <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                      <ItemStyle Width="100px" />
                      <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                          ImageUrl="~/imgRGen/button_edit.gif" OnClientClick='<%# setDireccion((decimal)Eval("personaId")) %>' />
                        &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False"
                          CommandName="Delete" ImageUrl='<%# setImage((String)Eval("estado")) %>' OnClientClick='<%# setMensajeConfirmacion((String)Eval("estado")) %>'
                          ToolTip='<%# setToolTip((String)Eval("estado")) %>' />
                        <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/imgRGen/btnUsuarioAssign.jpg"
                          ToolTip="Asignar Usuario" OnClientClick='<%# setUrlAssignUser((decimal)Eval("personaId")) %>' />
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                  <RowStyle CssClass="ItemStyle" />
                  <HeaderStyle CssClass="HeaderStyle" />
                  <FooterStyle CssClass="ItemStyle" />
                  <PagerStyle CssClass="ItemStyle" />
                </asp:GridView>
              </div>
              <br />
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
    <asp:SqlDataSource ID="sdsBroker" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      InsertCommand="sp_rgen_BrokerInsert" InsertCommandType="StoredProcedure" SelectCommand="sp_rgen_BrokerByName"
      SelectCommandType="StoredProcedure" DeleteCommand="sp_rgen_PersonaDelete" DeleteCommandType="StoredProcedure">
      <InsertParameters>
        <asp:Parameter Name="persona" Type="String" />
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
        <asp:ControlParameter ControlID="txtNombreBroker" Name="name" PropertyName="Text"
          Type="String" />
      </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBrokerFRM" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      InsertCommand="sp_rgen_BrokerInsert" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:rgen2ConnectionString.ProviderName %>"
      SelectCommand="sp_rgen_BrokerSelectById" SelectCommandType="StoredProcedure" UpdateCommand="sp_rgen_brokerUpdate"
      UpdateCommandType="StoredProcedure">
      <SelectParameters>
        <asp:QueryStringParameter Name="personaId" QueryStringField="BrokerId" Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:Parameter Name="persona" Type="String" />
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
      <UpdateParameters>
        <asp:Parameter Name="persona" Type="String" />
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
    </asp:SqlDataSource>
  </form>
</body>
</html>
