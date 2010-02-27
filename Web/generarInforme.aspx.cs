using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using RGen.Utiles;

public partial class generarInforme : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string ajusteId = Request.QueryString["ajusteId"];
    string tipoInforme = Request.QueryString["tipoInforme"];
    bool observado = Convert.ToBoolean(int.Parse(Request.QueryString["observado"]));
    bool estadoValidacion = false;

    AtribucionesUsuario datosUsuario = (AtribucionesUsuario)Session["datosUsuario"];
    if (datosUsuario.verificaAtributo("CREAINFORMEAPROBADO")) estadoValidacion = true;
    RGen.docs.GetPdf.GenerarInforme(decimal.Parse(ajusteId), tipoInforme, estadoValidacion, observado, datosUsuario.UserName, Server.MapPath(""));

    Page.ClientScript.RegisterStartupScript(GetType(), "ScriptGeneracionInforme", "window.top.hidePopWin(true);", true);
  }
}
