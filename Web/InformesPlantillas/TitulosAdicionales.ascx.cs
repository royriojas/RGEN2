using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class InformesPlantillas_TitulosAdicionales : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void odsTitulosAdicionales_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        divTitulosAdionales.Visible = (((DataTable)e.ReturnValue).Rows.Count > 0);
    }
}
