<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="vEditorUsuario.aspx.cs"
  Inherits="vEditorUsuario" %>

<%@ Register TagPrefix="Custom" Namespace="ASB" Assembly="AutoSuggestBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Editar Usuario</title>

  <script type="text/javascript" src="Scripts/lib/x_core.js">
  </script>

  <script type="text/javascript" src="Scripts/lib/x_dom.js">
  </script>

  <script type="text/javascript" src="Scripts/lib/x_event.js">
  </script>

  <script type="text/javascript" src="Scripts/lib/xCaseOperations.js">
  </script>

  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript">
        
        if(<%=deboCerrar%>)
        {
          window.top.hidePopWin();
          window.top.location = "vListaUsuario.aspx";
        }
        
        function ValidarUsuario(arg, context)
        {
            var ok=document.getElementById("usuarioFormView_okImage");
            var bad=document.getElementById("usuarioFormView_badImage");
            var spinner=document.getElementById("usuarioFormView_spinnerImage");

            spinner.style.display='none';
            ok.style.display='none';
            bad.style.display='none';

            if (arg!='') 
            {
                spinner.style.display='inline';
                <%=ClientScript.GetCallbackEventReference(this.usuarioEventControl, "arg", "ValidarUsuarioCallBack", "context", "HandleError", true)%>;
            }
        }
        
        function ValidarUsuarioCallBack(result, context)
        {
            var ok = document.getElementById("usuarioFormView_okImage");
            var bad = document.getElementById("usuarioFormView_badImage");
            var spinner = document.getElementById("usuarioFormView_spinnerImage");
            var usuarioTexbox = document.getElementById("usuarioFormView_usuarioTextBox");
            
            //alert(result);
            spinner.style.display='none';
            if (result=='True')
            {
                ok.style.display='inline';
                bad.style.display='none';
            }
            else {
                ok.style.display='none';
                bad.style.display='inline';
                usuarioTexbox.focus();
            }
        }
        
        function HandleError(message)
        {
          alert("Unhandled error:\n\n" + message);
        }
        function ShowASB(e) {
            //is Ajustador?
            if ($('usuarioFormView_rolIdCombo').value == 1) {
                $('usuarioFormView_asbCompanias').value = '- Preventores -';
                $('usuarioFormView_asbCompanias').readOnly = true;
               
            }
            else if ($('usuarioFormView_rolIdCombo').value == 10) {
                $('usuarioFormView_asbCompanias').value = '- Preventores -';
                $('usuarioFormView_asbCompanias').readOnly = true;
               
            }else {
                $('usuarioFormView_asbCompanias').value = '';
                $('usuarioFormView_asbCompanias').readOnly = false;
            }
        }
        
        window.onload = function () {
            xAddEventListener($('usuarioFormView_rolIdCombo'),'change',ShowASB,false);
            if ($('usuarioFormView_rolIdCombo').value == 1) {
                $('usuarioFormView_asbCompanias').value = '- Preventores -';
                $('usuarioFormView_asbCompanias').readOnly = true;
            }
            if ($('usuarioFormView_rolIdCombo').value == 10) {
                $('usuarioFormView_asbCompanias').value = '- Preventores -';
                $('usuarioFormView_asbCompanias').readOnly = true;
               
            }
        }
  </script>

  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px"
  class="DataTable">
  <form id="form1" runat="server">
    <div class="DataTop">
      <div class="DataTopLeft">
      </div>
      <div class="DataTopRight">
      </div>
    </div>
    <div class="DataContent">
      <div class="DataContentRight" style="padding: 1%">
        <h2>
          <asp:Label ID="lbEncabezado" runat="server">Usuario</asp:Label></h2>
        <div class="hr">
        </div>
        <div class="DataTable">
          <asp:FormView ID="usuarioFormView" runat="server" BorderWidth="0px" DataSourceID="odsUsuario"
            DefaultMode="Insert" OnDataBound="usuarioFormView_DataBound" DataKeyNames="usuarioId"
            OnItemInserting="usuarioFormView_ItemInserting" OnItemUpdating="usuarioFormView_ItemUpdating">
            <EditItemTemplate>
              <div style="width: 100%; padding: 1%" class="DataTable">
                <table cellspacing="0" cellpadding="0" border="0" class="DataTable">
                  <tr>
                    <td style="text-align: left; width: 175px" align="left">
                      Nombres
                    </td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:TextBox ID="nombreTextBox" runat="server" CssClass="FormText" MaxLength="250"
                        TabIndex="1" Width="270px" Text='<%# Bind("nombre1") %>'></asp:TextBox>
                      <asp:RequiredFieldValidator ID="nombre1RFV" runat="server" ControlToValidate="nombreTextBox"
                        ErrorMessage="Debe ingresar el nombre" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr style="color: #541c01">
                    <td style="text-align: left; width: 175px;" align="left">
                      Apellido paterno</td>
                    <td colspan="3">
                      <asp:TextBox ID="apellido1TextBox" runat="server" CssClass="FormText" MaxLength="250"
                        TabIndex="2" Width="270px" Text='<%# Bind("apellido1") %>'></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 175px;" align="left">
                      Apellido materno</td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:TextBox ID="apellido2TextBox" runat="server" CssClass="FormText" MaxLength="250"
                        TabIndex="3" Width="270px" Text='<%# Bind("apellido2") %>'></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 175px;" align="left">
                      Doc. identidad</td>
                    <td style="width: 144px">
                      <asp:DropDownList ID="tdocidIdCombo" runat="server" CssClass="FormText" Width="140px"
                        TabIndex="6" DataSourceID="odsTipoDocIdentidad" DataTextField="tdocid" DataValueField="tdocidId"
                        SelectedValue='<%# Bind("tdocidId") %>' OnDataBound="tdocidIdCombo_DataBound" AppendDataBoundItems="True">
                        <asp:ListItem>&lt;Elija&gt;</asp:ListItem>
                      </asp:DropDownList></td>
                    <td style="width: 120px;">
                      <asp:TextBox ID="docidTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TabIndex="7" Width="108px" Text='<%# Bind("docId") %>'></asp:TextBox></td>
                    <td style="height: 18px; text-align: left">
                      &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="docidTextBox"
                        ErrorMessage="Debe ingresar su número de documento" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr style="color: #541c01">
                    <td style="text-align: left; width: 175px;" align="left">
                      Teléfono</td>
                    <td style="width: 144px">
                      <asp:TextBox ID="telefonoTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TabIndex="7" Width="135px" Text='<%# Bind("telefono") %>'></asp:TextBox></td>
                    <td style="width: 120px;">
                    </td>
                    <td style="height: 18px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="left" style="width: 175px; height: 18px;">
                      <asp:TextBox ID="personaTextBox" runat="server" CssClass="FormText" Text='<%# Bind("personaId") %>'
                        Width="5px" Style="display: none"></asp:TextBox>
                      <asp:TextBox ID="passwordAuxTextBox" runat="server" Style="visibility: hidden" CssClass="FormText"
                        Text='<%# Bind("clave") %>' Width="2px"></asp:TextBox></td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:CompareValidator ID="contrasenhaCompareValidator" runat="server" ControlToCompare="passwordTextBox"
                        ControlToValidate="password2TextBox" ErrorMessage="La contraseña y su confirmación debe ser iguales"
                        Font-Bold="True">La contraseña y su confirmación debe ser iguales</asp:CompareValidator></td>
                  </tr>
                  <tr>
                    <td align="left" style="width: 175px; height: 19px;">
                      Usuario</td>
                    <td align="left" style="width: 144px; height: 19px;">
                      <asp:TextBox ID="usuarioTextBox" runat="server" CssClass="FormText MINUSC" MaxLength="20"
                        TabIndex="7" Width="135px" Text='<%# Bind("usuario") %>' onBlur="javascript:ValidarUsuario(this.value,'usuarioTextBox');"></asp:TextBox>
                    </td>
                    <td style="width: 120px; height: 19px;">
                      <asp:RequiredFieldValidator ID="usuarioRFV" runat="server" ControlToValidate="usuarioTextBox"
                        ErrorMessage="Debe ingresar el usuario" Font-Bold="True" Display="Dynamic">(*)</asp:RequiredFieldValidator><asp:Image
                          ID="spinnerImage" runat="server" ImageUrl="~/Images/spinner16.gif" Style="display: none" /><asp:Image
                            ID="badImage" runat="server" ImageUrl="~/Images/remove16.png" Style="display: none" /><asp:Image
                              ID="okImage" runat="server" ImageUrl="~/Images/ok16.png" Style="display: none" /></td>
                    <td style="height: 19px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="left" style="width: 175px; height: 18px;">
                      Contraseña</td>
                    <td align="left" style="width: 144px; height: 18px;">
                      <asp:TextBox ID="passwordTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TextMode="Password" Width="135px" Text='<%# Bind("clave") %>'></asp:TextBox>
                    </td>
                    <td style="width: 120px; height: 18px;">
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="passwordTextBox"
                        CssClass="DataValidator" ErrorMessage="Ingrese la contraseña">(*)</asp:RequiredFieldValidator></td>
                    <td style="height: 18px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="left" style="width: 175px">
                      Confirmar Contraseña</td>
                    <td align="left" style="width: 144px">
                      <asp:TextBox ID="password2TextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TextMode="Password" Width="135px"></asp:TextBox>
                    </td>
                    <td>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="password2TextBox"
                        CssClass="DataValidator" ErrorMessage="Ingrese la confirmación de contraseña">(*)</asp:RequiredFieldValidator></td>
                    <td style="height: 18px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="left" style="width: 175px; height: 17px;">
                      Rol</td>
                    <td align="left" style="width: 144px; height: 17px;">
                      <asp:DropDownList ID="rolIdCombo" runat="server" CssClass="FormText" Width="140px"
                        DataSourceID="odsRolCombo" DataTextField="rol" DataValueField="rolId" SelectedValue='<%# Bind("rolId") %>'
                        OnDataBound="rolIdCombo_DataBound">
                      </asp:DropDownList>
                    </td>
                    <td style="width: 120px; height: 17px; text-align: left">
                      <asp:RequiredFieldValidator ID="rolRFV" runat="server" ControlToValidate="rolIdCombo"
                        ErrorMessage="Debe escoger un rol" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                    <td style="height: 17px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="left" style="width: 175px; height: 17px">
                      <asp:Label ID="lblCompania" runat="server" Text="Compañía"></asp:Label></td>
                    <td align="left" style="width: 144px; height: 17px">
                      <Custom:AutoSuggestBox ID="asbCompanias" runat="server" CssClass="FormText" DataType="Companias"
                        Height="11px" IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="18"
                        MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                        NumMenuItems="10" OnFocusShowAll="False" ResourcesDir="./asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                        TabIndex="36" UseIFrame="True" WarnNoValueSelected="True" Width="135px" SelectedValue='<%# Eval("companiaId") %>'
                        Text='<%# Eval("nombreCompania") %>'></Custom:AutoSuggestBox></td>
                    <td style="width: 120px; height: 17px; text-align: left">
                      <asp:RequiredFieldValidator ID="companiaRFV" runat="server" ControlToValidate="asbCompanias"
                        ErrorMessage="Debe escoger una compañía" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                    <td style="height: 17px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="left" style="width: 175px; height: 18px">
                      Estado</td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:DropDownList ID="estadoCombo" runat="server" CssClass="FormText" Width="140px"
                        SelectedValue='<%# Bind("estado") %>'>
                        <asp:ListItem Value="A">ACTIVO</asp:ListItem>
                        <asp:ListItem Value="I">INACTIVO</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                  </tr>
                </table>
              </div>
            </EditItemTemplate>
            <InsertItemTemplate>
              <div style="width: 100%;  padding: 10px;" class="DataTable">
                <table cellspacing="0" cellpadding="0" border="0" class="DataTable">
                  <tr>
                    <td style="text-align: left; width: 170px">
                      Nombres
                    </td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:TextBox ID="nombreTextBox" runat="server" CssClass="FormText MAYUSC" MaxLength="250"
                        Width="290px" Text='<%# Bind("nombre1") %>'></asp:TextBox>
                      <asp:RequiredFieldValidator ID="nombre1RFV" runat="server" ControlToValidate="nombreTextBox"
                        ErrorMessage="Debe ingresar los nombres" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px;">
                      Apellido paterno</td>
                    <td colspan="3">
                      <asp:TextBox ID="apellido1TextBox" runat="server" CssClass="FormText" MaxLength="250"
                        Width="290px" Text='<%# Bind("apellido1") %>'></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px;">
                      Apellido materno</td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:TextBox ID="apellido2TextBox" runat="server" CssClass="FormText" MaxLength="250"
                        Width="290px" Text='<%# Bind("apellido2") %>'></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px;">
                      Doc. identidad</td>
                    <td style="width: 144px">
                      <asp:DropDownList ID="tdocidIdCombo" runat="server" CssClass="FormText" Width="140px"
                        DataSourceID="odsTipoDocIdentidad" DataTextField="tdocid" DataValueField="tdocidId"
                        SelectedValue='<%# Bind("tdocidId") %>'>
                      </asp:DropDownList></td>
                    <td>
                    </td>
                    <td style="height: 18px; text-align: left">
                      &nbsp;<asp:TextBox ID="docidTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        Width="135px" Text='<%# Bind("docId") %>'></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="docidTextBox"
                        ErrorMessage="Debe ingresar su número de documento" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px;">
                      Teléfono</td>
                    <td style="width: 144px">
                      <asp:TextBox ID="telefonoTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        Width="136px" Text='<%# Bind("telefono") %>'></asp:TextBox></td>
                    <td>
                    </td>
                    <td style="height: 18px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                    </td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:CompareValidator ID="contrasenhaCompareValidator" runat="server" ControlToCompare="passwordTextBox"
                        ControlToValidate="password2TextBox" ErrorMessage="La contraseña y su confirmación debe ser iguales"
                        Font-Bold="True">La contraseña y su confirmación debe ser iguales</asp:CompareValidator></td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      Usuario</td>
                    <td align="left" style="width: 144px">
                      <asp:TextBox ID="usuarioTextBox" runat="server" CssClass="FormText MINUSC" MaxLength="20"
                        Width="136px" Text='<%# Bind("usuario") %>' onBlur="javascript:ValidarUsuario(this.value,'usuarioTextBox');"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                    <td style="height: 18px; text-align: left">
                      <asp:RequiredFieldValidator ID="usuarioRFV" runat="server" ControlToValidate="usuarioTextBox"
                        ErrorMessage="Debe ingresar el usuario" Font-Bold="True" Display="Dynamic">(*)</asp:RequiredFieldValidator><asp:Image
                          ID="spinnerImage" runat="server" ImageUrl="~/Images/spinner16.gif" Style="display: none" /><asp:Image
                            ID="badImage" runat="server" ImageUrl="~/Images/remove16.png" Style="display: none" /><asp:Image
                              ID="okImage" runat="server" ImageUrl="~/Images/ok16.png" Style="display: none" /></td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      Contraseña</td>
                    <td align="left" style="width: 144px; height: 18px;">
                      <asp:TextBox ID="passwordTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TextMode="Password" Width="136px" Text='<%# Bind("clave") %>'></asp:TextBox>
                    </td>
                    <td>
                    </td>
                    <td style="height: 18px; text-align: left">
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="passwordTextBox"
                        CssClass="DataValidator" ErrorMessage="Ingrese la contraseña">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      Confirmar Contraseña</td>
                    <td align="left" style="width: 144px">
                      <asp:TextBox ID="password2TextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TextMode="Password" Width="136px"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                    <td style="height: 18px; text-align: left">
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="password2TextBox"
                        CssClass="DataValidator" ErrorMessage="Ingrese la confirmación de contraseña">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left; height: 18px;">
                      Rol</td>
                    <td align="left" style="width: 144px; height: 18px;">
                      <asp:DropDownList ID="rolIdCombo" runat="server" CssClass="FormText" Width="140px"
                        DataSourceID="odsRolCombo" DataTextField="rol" DataValueField="rolId" SelectedValue='<%# Bind("rolId") %>'
                        OnDataBound="rolIdCombo_DataBound">
                      </asp:DropDownList>
                    </td>
                    <td style="height: 18px">
                    </td>
                    <td style="height: 18px; text-align: left">
                      <asp:RequiredFieldValidator ID="rolRFV" runat="server" ControlToValidate="rolIdCombo"
                        ErrorMessage="Debe escoger un rol" Font-Bold="True" CssClass="DataValidator">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; height: 18px; text-align: left">
                      <asp:Label ID="lblCompania" runat="server" Text="Compañía"></asp:Label></td>
                    <td align="left" style="width: 144px; height: 18px">
                      <Custom:AutoSuggestBox ID="asbCompanias" runat="server" CssClass="FormText" DataType="Companias"
                        Height="11px" IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="18"
                        MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NoValueSelectedCSSClass="asbNonValueSelected"
                        NumMenuItems="10" OnFocusShowAll="False" ResourcesDir="./asb_includes" SelMenuItemCSSClass="asbSelMenuItem"
                        TabIndex="36" UseIFrame="True" WarnNoValueSelected="True" Width="135px" Text='<%# Eval("nombreCompania") %>'></Custom:AutoSuggestBox></td>
                    <td style="height: 18px">
                    </td>
                    <td style="height: 18px; text-align: left">
                      <asp:RequiredFieldValidator ID="companiaRFV" runat="server" ControlToValidate="asbCompanias"
                        CssClass="DataValidator" ErrorMessage="Debe escoger una compañía" Font-Bold="True">(*)</asp:RequiredFieldValidator></td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      Estado</td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:DropDownList ID="estadoCombo" runat="server" CssClass="FormText" Width="140px"
                        SelectedValue='<%# Bind("estado") %>'>
                        <asp:ListItem Value="A">ACTIVO</asp:ListItem>
                        <asp:ListItem Value="I">INACTIVO</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                  </tr>
                </table>
              </div>
            </InsertItemTemplate>
            <ItemTemplate>
              <div style="width: 100%; padding: 10px;" class="DataTable">
                <table cellspacing="0" cellpadding="0" border="0" class="DataTable" style="width: 521px">
                  <tr>
                    <td style="text-align: left; width: 170px">
                      Nombres
                    </td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:TextBox ID="nombreTextBox" runat="server" CssClass="FormText" MaxLength="250"
                        TabIndex="1" Width="278px" Text='<%# Eval("nombre1") %>' ReadOnly="True"></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px;">
                      Apellido paterno</td>
                    <td colspan="3">
                      <asp:TextBox ID="apellido1TextBox" runat="server" CssClass="FormText" MaxLength="250"
                        TabIndex="2" Width="278px" Text='<%# Eval("apellido1") %>' ReadOnly="True"></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px; height: 18px;">
                      Apellido materno</td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:TextBox ID="apellido2TextBox" runat="server" CssClass="FormText" MaxLength="250"
                        TabIndex="3" Width="278px" Text='<%# Eval("apellido2") %>' ReadOnly="True"></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px;">
                      Doc. identidad</td>
                    <td style="width: 144px">
                      <asp:DropDownList ID="tdocidIdCombo" runat="server" CssClass="FormText" Width="140px"
                        TabIndex="6" DataSourceID="odsTipoDocIdentidad" DataTextField="tdocid" DataValueField="tdocidId"
                        SelectedValue='<%# Eval("tdocidId") %>' Enabled="False" AppendDataBoundItems="True"
                        OnDataBound="tdocidIdCombo_DataBound">
                        <asp:ListItem Selected="True" Value="">&lt;Elija&gt;</asp:ListItem>
                      </asp:DropDownList></td>
                    <td style="height: 18px; text-align: right; width: 120px;">
                      <asp:TextBox ID="docidTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TabIndex="7" Width="135px" Text='<%# Eval("docId") %>' ReadOnly="True"></asp:TextBox></td>
                    <td style="height: 18px; text-align: left">
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td style="text-align: left; width: 170px;">
                      Teléfono</td>
                    <td style="width: 144px">
                      <asp:TextBox ID="telefonoTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TabIndex="7" Width="136px" Text='<%# Eval("telefono") %>' ReadOnly="True"></asp:TextBox></td>
                    <td style="height: 18px; text-align: right; width: 120px;">
                    </td>
                    <td style="height: 18px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      <asp:TextBox ID="personaTextBox" runat="server" CssClass="FormText" Style="display: none"
                        Text='<%# Eval("personaId") %>' Width="5px"></asp:TextBox></td>
                    <td colspan="3" style="height: 18px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      Usuario</td>
                    <td align="left" style="width: 144px">
                      <asp:TextBox ID="usuarioTextBox" runat="server" CssClass="FormText" MaxLength="20"
                        TabIndex="7" Width="135px" Text='<%# Eval("usuario") %>' ReadOnly="True"></asp:TextBox>
                    </td>
                    <td style="width: 120px; height: 18px; text-align: right">
                    </td>
                    <td style="height: 18px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      Rol</td>
                    <td align="left" style="width: 144px; height: 17px;">
                      <asp:DropDownList ID="rolIdCombo" runat="server" CssClass="FormText" Width="139px"
                        DataSourceID="odsRolCombo" DataTextField="rol" DataValueField="rolId" SelectedValue='<%# Eval("rolId") %>'
                        OnDataBound="rolIdCombo_DataBound" Enabled="False">
                      </asp:DropDownList>
                    </td>
                    <td style="width: 120px; height: 17px; text-align: right">
                    </td>
                    <td style="height: 17px; text-align: left">
                    </td>
                  </tr>
                  <tr>
                    <td align="right" style="width: 170px; text-align: left;">
                      Estado</td>
                    <td colspan="3" style="height: 18px; text-align: left">
                      <asp:DropDownList ID="estadoCombo" runat="server" CssClass="FormText" Width="139px"
                        SelectedValue='<%# Eval("estado") %>' Enabled="False">
                        <asp:ListItem Value="A">ACTIVO</asp:ListItem>
                        <asp:ListItem Value="I">INACTIVO</asp:ListItem>
                      </asp:DropDownList></td>
                  </tr>
                </table>
              </div>             
            </ItemTemplate>
          </asp:FormView>
        </div>
        <div style="text-align: right; margin-top: 5px">
          <asp:ImageButton ID="imgBtnAsignarMails" runat="server" ImageUrl="~/Images/asignarmail.jpg"
            OnClick="guardarImageButton_Click" ToolTip="Asignar Correo Electrónico" onmouseout="MakeClear(this,0)"
            onmouseover="MakeClear(this,1);" Visible="False" CausesValidation="False" />
          &nbsp; &nbsp;&nbsp; &nbsp;<asp:ImageButton ID="guardarImageButton" runat="server"
            ImageUrl="~/Images/IconSave32Dark.gif" OnClick="guardarImageButton_Click" ToolTip="Guardar datos"
            onmouseout="MakeClear(this,0)" onmouseover="MakeClear(this,1);" />&nbsp;
          <img id="salirHyperLink" alt="Salir" runat="server" src="Images/IconExit32Dark.gif"
            onclick="window.top.hidePopWin();" onmouseout="MakeClear(this,0)" onmouseover="MakeClear(this,1);"
            style="cursor: hand" />
        </div>
      </div>
    </div>
    <div class="DataBottom">
      <div class="DataBottomLeft">
      </div>
      <div class="DataBottomRight">
      </div>
    </div>
    <asp:ValidationSummary ID="beneficiarioVS" runat="server" ShowMessageBox="True" ShowSummary="False" />
    <asp:ObjectDataSource ID="odsTipoDocIdentidad" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoDocumentoIdentidadComboTableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsRolCombo" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.RolComboByUserTableAdapter">
      <SelectParameters>
        <asp:SessionParameter Name="tipoUsuario" SessionField="TipoUsuario" Type="String" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoPersonaCombo" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoPersonaComboTableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsUsuario" runat="server" DeleteMethod="Delete" SelectMethod="GetData"
      TypeName="dsUsuariosTableAdapters.UsuarioEditorTableAdapter" InsertMethod="Insert"
      UpdateMethod="Update" OnInserting="odsUsuario_Inserting">
      <DeleteParameters>
        <asp:Parameter Name="usuarioId" Type="Int32" />
      </DeleteParameters>
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="1" Name="usuarioId" QueryStringField="uid"
          Type="Int32" />
      </SelectParameters>
      <UpdateParameters>
        <asp:Parameter Name="usuarioId" Type="Int32" />
        <asp:Parameter Name="personaId" Type="Int32" />
        <asp:Parameter Name="nombre1" Type="String" />
        <asp:Parameter Name="apellido1" Type="String" />
        <asp:Parameter Name="apellido2" Type="String" />
        <asp:Parameter Name="telefono" Type="String" />
        <asp:Parameter Name="docId" Type="String" />
        <asp:Parameter Name="tdocidId" Type="Int32" />
        <asp:Parameter Name="rolId" Type="Int32" />
        <asp:Parameter Name="usuario" Type="String" />
        <asp:Parameter Name="clave" Type="String" />
        <asp:Parameter Name="estado" Type="String" />
        <asp:Parameter Name="creadorId" Type="Int32" />
        <asp:Parameter Name="companiaId" Type="Decimal" />
        <asp:Parameter Name="nombreCompania" Type="String" />
      </UpdateParameters>
      <InsertParameters>
        <asp:Parameter Name="nombre1" Type="String" />
        <asp:Parameter Name="apellido1" Type="String" />
        <asp:Parameter Name="apellido2" Type="String" />
        <asp:Parameter Name="telefono" Type="String" />
        <asp:Parameter Name="docId" Type="String" />
        <asp:Parameter Name="tdocidId" Type="Int32" />
        <asp:Parameter Name="rolId" Type="Int32" />
        <asp:Parameter Name="usuario" Type="String" />
        <asp:Parameter Name="clave" Type="String" />
        <asp:Parameter Name="estado" Type="String" />
        <asp:Parameter Name="creadorId" Type="Decimal" />
        <asp:Parameter Name="companiaId" Type="Decimal" />
      </InsertParameters>
    </asp:ObjectDataSource>
  </form>
</body>
</html>
