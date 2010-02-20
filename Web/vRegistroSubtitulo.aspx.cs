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

public partial class vRegistroSubtitulo : System.Web.UI.Page
{
  public string deboCerrar = "false";
  public string AjusteId;

  protected void Page_Load(object sender, EventArgs e)
  {
    AjusteId = Request.QueryString["AjusteId"];
  }
  protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
  {
    deboCerrar = "true";
  }
}
