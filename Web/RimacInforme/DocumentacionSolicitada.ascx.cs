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

public partial class RimacInforme_DocumentacionSolicitada : System.Web.UI.UserControl
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
    protected void odsDocumentosSolicitados_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        divDocumentacionSolicitada.Visible = (((DataTable)e.ReturnValue).Rows.Count > 0);
        if (!divDocumentacionSolicitada.Visible)
        {
            InvokeEmpty(new EventArgs());
        }
    }
}
