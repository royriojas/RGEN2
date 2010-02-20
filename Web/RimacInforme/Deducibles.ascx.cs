using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RimacInforme_Deducibles : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void odsDeducibles_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.divDeducibles.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
    }
}
