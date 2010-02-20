using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Globalization;

public partial class changeEstados : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
        Thread.CurrentThread.CurrentCulture = new CultureInfo("ar-KW");
        Thread.CurrentThread.CurrentUICulture = new CultureInfo("ar-KW");
        */
     
    }   
    protected void odsAdministraEstados_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.pnlMsg.Visible = true;
        this.GridView1.DataBind();            
    }   
}
