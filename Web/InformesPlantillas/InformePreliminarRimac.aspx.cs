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
using R3M.Common;

public partial class InformesPlantillas_InformePreliminarRimac : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected decimal AjusteId
    {
        get { return Convert.ToDecimal(Util.XDefault(Request.QueryString["AjusteId"], "-1")); }

    }
}