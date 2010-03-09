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

public partial class genPreviewImprimir : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    String TipoInforme = Request.QueryString["TI"];
    String AjusteId = Request.QueryString["AjusteId"];

    Page.ClientScript.RegisterClientScriptBlock(GetType(), "RedirectKey", String.Format("window.location.href='genPreviewImprimirPdf.aspx?AjusteId={0}&TI={1}&nc={2}'", AjusteId, TipoInforme, DateTime.Now.Ticks), true);
    
  }
}
