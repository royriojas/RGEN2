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

public partial class secuencia_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write("valor = " + Request.QueryString["uid"]);

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.ToString() + "?uid=" + this.Label1.Text);
    }
}
