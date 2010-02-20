using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RimacInforme_Clausulas : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void odsClausulas_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.divClausulas.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
    }
}
