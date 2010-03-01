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

public partial class InformesPlantillas_InformeBasicoRimac : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void DoDataBound(object sender, EventArgs e)
    {
        RimacInforme_detalleSublimitesAfectados ctrl = FormViewInforme.FindControl("detalleSublimitesAfectados1") as RimacInforme_detalleSublimitesAfectados;
        if (ctrl != null)
        {
            ctrl.AjusteId = Convert.ToDecimal(Request.QueryString["AjusteId"]);
            ctrl.BindData();
        }

    }

   

}
