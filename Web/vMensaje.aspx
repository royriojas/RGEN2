<%@ Page Language="C#" MasterPageFile="~/RGenMasterPage.master" AutoEventWireup="true"
  CodeFile="vMensaje.aspx.cs" Inherits="vMensaje" Title="Untitled Page" %>

<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
  TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <uc2:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server">
  </uc2:linksAjustadorAdministrador>
  <div class="dt">
    <div class="dtl">
    </div>
    <div class="dtr">
    </div>
  </div>
  <div class="dc">
    <div class="dcr">
      <h2>
        Nuevo Caso de Ajuste (Requisitos Mínimos)
      </h2>
      <div class="hr">
      </div>
      <div>
        <p style="font-size: 16px;">
          El caso ha sido registrado correctamente con el número: <a id='navLink' href="" runat="server"
            style="text-decoration: underline">
            <asp:Label ID="lblNumAjuste" runat="server" Text="Label"></asp:Label></a></p>
        <p>
          <a style="text-decoration: underline;" href="vNuevoCasoAjuste.aspx">Volver al Registro
            de Casos</a></p>
      </div>
    </div>
  </div>
  <div class="db">
    <div class="dbl">
    </div>
    <div class="dbr">
    </div>
  </div>
</asp:Content>
