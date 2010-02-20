<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vParrafosTitulosComunes.aspx.cs" Inherits="vParrafosTitulosComunes" %>

<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
    TagPrefix="uc2" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Registro de Ajuste</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
  
</head>
<body>
<div style="margin-left:auto; margin-right:auto; position:relative; width:999px; height: 472px; left: 0px; top: 0px;">
    <form id="form1" runat="server">
        <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="ajuste"/>
        <uc2:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server" />
        <div id="ContenidoPagina">
                                    
            Parrafos Comunes
        
        </div>
        
	
		
    </form>
</div>
</body>
</html>
