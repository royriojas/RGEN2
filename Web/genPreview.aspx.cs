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

public partial class genPreview : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    String TipoInforme = Request.QueryString["TI"];
    String AjusteId = Request.QueryString["AjusteId"];

    this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "RedirectKey", String.Format("window.location.href='genPreviewPdf.aspx?AjusteId={0}&TI={1}'", AjusteId, TipoInforme), true);
    
  }
}
