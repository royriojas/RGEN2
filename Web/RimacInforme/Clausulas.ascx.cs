using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RimacInforme_Clausulas : System.Web.UI.UserControl
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
    protected void odsClausulas_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        divClausulas.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);

        if (!divClausulas.Visible)
        {
            InvokeEmpty(new EventArgs());
        }

    }
}
