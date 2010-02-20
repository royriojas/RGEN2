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

public partial class generarStatus : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string ajusteId = Request.QueryString["ajusteId"];
    string tipoInforme = Request.QueryString["tipoInforme"];
    string observado = Request.QueryString["observado"];
    String Now = Request.QueryString["NOW"];

    string script = String.Format("window.location = 'generarInforme.aspx?ajusteId={0}&tipoInforme={1}&observado={2}&NOW={3}'", ajusteId, tipoInforme, observado, Now);


    Page.ClientScript.RegisterStartupScript(this.GetType(), "ScriptGeneracionInforme", script, true);


  }
}
