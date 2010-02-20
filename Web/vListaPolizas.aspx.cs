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

public partial class vListaPolizas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.txtAsegurado.Text = Request.QueryString["Asegurado"];
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;
            e.Row.Attributes.Add("id", e.Row.ClientID);
            e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
            e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
            e.Row.Attributes.Add("onClick", "javascript:Redirect('vEditorPoliza.aspx?PolizaId=" + AuxRow["PolizaId"].ToString() + "');");
        }
    }
    protected void ibtnBuscar_Click(object sender, ImageClickEventArgs e)
    {
       
    }

    
    protected void cbxCia_DataBound(object sender, EventArgs e)
    {
        ListItem item = new ListItem("TODOS", "");
        this.cbxCia.Items.Insert(0, item);
    }

}
