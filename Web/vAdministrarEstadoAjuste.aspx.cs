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

public partial class vAdministrarEstadoAjuste : System.Web.UI.Page
{
    public String numAjuste;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            numAjuste = Request.QueryString["numAjuste"];
            lblAjusteNumero.Text += numAjuste;
        }
    }
}
