using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using R3M.Common;

public partial class InformesPlantillas_InformeFinal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected decimal AjusteId
    {
        get { return Convert.ToDecimal(Util.XDefault(Request.QueryString["AjusteId"], "-1")); }

    }

    protected void DoEmpty(object sender, EventArgs e)
    {
        //_groupIPreliminar2
        HtmlGenericControl groupIPreliminar2 = FormViewInforme.FindControl("_groupIPreliminar2") as HtmlGenericControl;
        if (groupIPreliminar2 != null)
        {
            groupIPreliminar2.Visible = false;
        }
    }

    protected void EmptyClausulas(object sender, EventArgs e)
    {
        HtmlGenericControl clausulasDiv = FormViewInforme.FindControl("_clausulasDiv") as HtmlGenericControl;
        if (clausulasDiv != null)
        {
            clausulasDiv.Visible = false;
        }
    }

    protected void EmptyDeducibles(object sender, EventArgs e)
    {
        //_clausulasDiv
        HtmlGenericControl deduciblesDiv = FormViewInforme.FindControl("_deduciblesDiv") as HtmlGenericControl;
        if (deduciblesDiv != null)
        {
            deduciblesDiv.Visible = false;
        }
    }
}
