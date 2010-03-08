using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RimacInforme_Deducibles : System.Web.UI.UserControl
{
    public event EventHandler Empty;

    private void InvokeEmpty(EventArgs e)
    {
        EventHandler empty = Empty;
        if (empty != null) empty(this, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void odsDeducibles_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        divDeducibles.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);

        if (!divDeducibles.Visible)
        {
            InvokeEmpty(new EventArgs());
        }
    }
}
