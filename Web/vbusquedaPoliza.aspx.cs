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

public partial class vbusquedaPoliza : System.Web.UI.Page
{
    public int num = 0;
    public string IndicadorDeLlamada;
    public string cerrar = "false";
    public String qStringAjusteId;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.txtAseguradoraId.Text = Request.QueryString["AseguradoraId"];
        this.txtAseguradoraNombre.Text = Request.QueryString["AseguradoraNombre"];
        this.IndicadorDeLlamada = Request.QueryString["IndicadorLlamada"];
        this.txtNumPoliza.Text = (Request.QueryString["NumeroPoliza"]!= null)? Request.QueryString["NumeroPoliza"]:this.txtNumPoliza.Text;
        qStringAjusteId = Request.QueryString["AjusteId"];
        if ((IndicadorDeLlamada != null) && (IndicadorDeLlamada == "AsignarPoliza"))
        {
            Session["Indicador"] = "AsignarPoliza";
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
      
    }
    protected void DataTable_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;
            e.Row.Attributes.Add("id", e.Row.ClientID);
            e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
            e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
            if (this.IndicadorDeLlamada != null)
            {
                e.Row.Attributes.Add("onClick", "javascript:grabaPolizaPrincipal(" + AuxRow["polizaId"].ToString() + ",'" + AuxRow["numeroPoliza"].ToString() + "',"+ AuxRow["ramoId"] +")");
            }
            else
            {
                if (Session["Indicador"] != null)
                {
                    e.Row.Attributes.Add("onClick", "javascript:grabaPolizaPrincipal(" + AuxRow["polizaId"].ToString() + ",'" + AuxRow["numeroPoliza"].ToString() + "'," + AuxRow["ramoId"] + ")");
                }
                else
                {
                    e.Row.Attributes.Add("onClick", "javascript:cierraVentana(" + AuxRow["polizaId"].ToString() + ",'" + AuxRow["numeroPoliza"].ToString() + "'," + AuxRow["aseguradoId"].ToString() + ",'" + AuxRow["asegurado"].ToString() + "','" + AuxRow["contratante"].ToString() + "','" + AuxRow["ramoafectado"].ToString() + "'," + AuxRow["ramoId"] + ");return false;");
                }
            }
                        
        }
    }
    protected void btnGrabarPolizaAjuste_Click(object sender, EventArgs e)
    {
        try
        {
            sdsInsertaPoliza.Insert();
        }
        catch (Exception ex)
        {
            if (Session["datosUsuario"] == null)
            {
                RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
                if (au == null)
                {
                    String urlActual = Request.Url.ToString();
                    Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
                }
            }
        }
        cerrar = "true";
        
    }
    protected void sdsInsertaPoliza_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        int num = e.Command.Parameters.Count;
    }
    protected void sdsInsertaPoliza_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {

    }
    protected void btnNuevaPoliza_Click(object sender, EventArgs e)
    {

    }
}
