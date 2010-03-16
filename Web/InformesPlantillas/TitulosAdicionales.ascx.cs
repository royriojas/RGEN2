using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class InformesPlantillas_TitulosAdicionales : System.Web.UI.UserControl
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
    protected void odsTitulosAdicionales_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {

        if (e.Exception != null)
            throw e.Exception.InnerException;
    
        divTitulosAdionales.Visible = (((DataTable)e.ReturnValue).Rows.Count > 0);

        if (!divTitulosAdionales.Visible)
        {
            InvokeEmpty(new EventArgs());
        }
    
    }
}
