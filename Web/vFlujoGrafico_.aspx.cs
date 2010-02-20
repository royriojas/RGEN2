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

public partial class vFlujoGrafico_ : System.Web.UI.Page
{
    public String qStringAjusteId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(utiles.ajax.gestorAjax));
        if (Request.QueryString["AjusteId"] != null)
        {
            this.qStringAjusteId = Request.QueryString["AjusteId"];
        }

    }
}
