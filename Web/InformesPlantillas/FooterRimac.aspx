<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FooterRimac.aspx.cs" Inherits="InformesPlantillas_FooterRimac" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
  <title></title>
  <link href='<%= ResolveUrl("~/InformesPlantillas/infRimac.css?nc=" + DateTime.Now.Ticks) %>'
    rel="Stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
  <div class="footer">
    <p>&nbsp;</p>
    <table width="100%" style="width: 100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td style="width:50%">
          <p class="bold">
            SAN ISIDRO:</p>
          <p>
            Mariano de los Santos 166</p>
          <p>
            Central: (511) 615-3035 Fax: (511) 615-3036</p>
          <p style=color:blue" >
            www.preventores.com.pe</p>
          <p class="bold">
            REG. S.B.S. Nº APJ 012</p>
        </td>
        <td style="width:50%">
          <p class="bold">
            AREQUIPA</p>
          <p>
            Calle Palacio Viejo 216 Of. 603 Cercado-Arequipa</p>
          <p>
            Central: 281282 Fax: 201316</p>
          <p>
            Partida Electrónica Nº 70005787</p>
        </td>
      </tr>
    </table>
  </div>
  </form>
</body>
</html>
