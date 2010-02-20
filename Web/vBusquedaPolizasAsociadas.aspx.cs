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

public partial class vBusquedaPolizasAsociadas : System.Web.UI.Page
{
    RGen.Utiles.AtribucionesUsuario au;
    public Decimal ajusteId;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        if (au == null)
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }

        txtAsegurado.Text = Request.QueryString["Asegurado"].ToString();
        txtAseguradoraNombre.Text = Request.QueryString["Aseguradora"].ToString();
        txtAseguradoId.Text = Request.QueryString["AseguradoId"].ToString();
        txtAseguradoraId.Text = Request.QueryString["AseguradoraId"].ToString();
        ajusteId = Convert.ToDecimal(Request.QueryString["AjusteId"]);

    }


    protected void gridPolizas_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;
            e.Row.Attributes.Add("id", e.Row.ClientID);
            e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
            e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
            e.Row.Attributes.Add("onClick", "copiaACampoOcultoPolizaId("+AuxRow["PolizaId"]+")");
        }
    }
    protected void btnBuscar_Click(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        this.sqlAsociaPoliza.InsertParameters.Add("usuario", au.UserName);
        try
        {
            sqlAsociaPoliza.Insert();
            this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "reload", "window.parent.doReload();window.parent.hidePopWin(true);", true);
        }
        catch (Exception ex)
        {

        }
    }
   
    protected void sqlAsociaPoliza_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {

    }
    protected void sqlAsociaPoliza_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        String cmd = utiles.debugClass.muestra(e.Command);
    }
}
