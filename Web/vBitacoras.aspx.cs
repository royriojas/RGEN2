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

public partial class vBitacoras : System.Web.UI.Page
{
    public string qStringAjusteId;
    protected void Page_Load(object sender, EventArgs e)
    {
        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true") {
            //this.lnkSeparar.Visible = false;
        }
        qStringAjusteId = Request.QueryString["AjusteId"];
    }
}
