﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class InformesPlantillas_Caratula : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected bool IsComplementary
    {
        get { return Request.QueryString["TI"] == "IC"; }

    }

    protected bool IsFinal
    {
        get { return Request.QueryString["TI"] == "IF"; }
        
    }

    protected void DoDataBound(object sender, EventArgs e)
    {
        RimacInforme_detalleSublimitesAfectados ctrl = FormViewInforme.FindControl("_detalleSublimitesAfectados1") as RimacInforme_detalleSublimitesAfectados;
        if (ctrl != null)
        {
            ctrl.AjusteId = Convert.ToDecimal(Request.QueryString["AjusteId"]);
            ctrl.BindData();
        }

    }
}
