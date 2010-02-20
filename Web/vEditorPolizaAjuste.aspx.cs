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

public partial class vEditorPolizaAjuste : System.Web.UI.Page
{
    public int RowCount
    {
        get
        {
            return Convert.ToInt32(ViewState["RowCount"]);
        }
        set
        {
            ViewState["RowCount"] = value;
        }
    }
    public int num = 1;
    public String qStringAjusteId;
    public String UrlActual;
    protected void Page_Load(object sender, EventArgs e)
    {
        qStringAjusteId = Request.QueryString["AjusteId"];
        if (!IsPostBack)
        {
            txtAsegurado.Text = ((TextBox)this.FwiewPolizaPrincipal.FindControl("TextBoxAsegurado")).Text;
            txtAseguradoId.Text = ((TextBox)this.FwiewPolizaPrincipal.FindControl("TextBoxAseguradoId")).Text;
            txtAseguradora.Text = ((TextBox)this.FwiewPolizaPrincipal.FindControl("TextBoxAseguradora")).Text;
            txtAseguradoraId.Text = ((TextBox)this.FwiewPolizaPrincipal.FindControl("TextBoxAseguradoraId")).Text;
        }
        Session["urlBack"] = Request.Url.ToString();
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Response.Redirect("vBusquedaPolizasAsociadas.aspx?AjusteId=57&Asegurado=Real Tours&Aseguradora=Rimac Internacional&aseguradoraId=2&aseguradoId=20");
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;

            HyperLink link = (HyperLink)e.Row.FindControl("linkPoliza");
            link.Attributes.Add("onclick","javascript:muestraPopUp('" + qStringAjusteId + "','" + AuxRow["polizaId"].ToString()+ "');");
            
        }

    }
    
    protected void gvPolizasAsociadas_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        /*
        if (e.CommandName == "Eliminar")
        {
            dsRegistroBasicoTableAdapters.PolizasAsociadasTableAdapter itemAdapter = new dsRegistroBasicoTableAdapters.PolizasAsociadasTableAdapter();
            //itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()), qStringAjusteId);
            odsListaPolizasAsociadas.Delete();
            gvPolizasAsociadas.DataBind();
        }*/
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        Response.Redirect(Request.QueryString["urlAnterior"]);
    }


    protected void gvPolizasAsociadas_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        this.FwiewPolizaPrincipal.DataBind();
    }
    protected void odsListaPolizasAsociadas_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        RowCount = (e.AffectedRows);
    }
    protected void doPost_Click(object sender, EventArgs e)
    {
        this.gvPolizasAsociadas.DataBind();
    }
}
