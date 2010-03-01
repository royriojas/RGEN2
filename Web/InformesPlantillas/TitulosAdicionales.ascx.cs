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

public partial class InformesPlantillas_TitulosAdicionales : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void odsTitulosAdicionales_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.divTitulosAdionales.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
    }
}
