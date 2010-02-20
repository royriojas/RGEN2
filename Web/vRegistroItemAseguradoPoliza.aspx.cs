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

public partial class vRegistroItemAseguradoPoliza : System.Web.UI.Page
{
    public int numItemsAsegurados = 1;
    String AjusteId;
    String PolizaId;
    RGen.Utiles.AtribucionesUsuario au;
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(utiles.ajax.gestorAjax));
        this.cambiaTipoCambio();
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        AjusteId = Request.QueryString["AjusteId"];
        PolizaId = Request.QueryString["PolizaId"];
    }
    protected void cambiaTipoCambio()
    {
        //codigo del Gestor

        try
        {

            dsTipoCambioTableAdapters.ObtenerTipoCambioTableAdapter mytableAdapter = new dsTipoCambioTableAdapters.ObtenerTipoCambioTableAdapter();
            dsTipoCambio.ObtenerTipoCambioDataTable myTable = mytableAdapter.GetData(Convert.ToInt32(this.cbxMoneda.SelectedValue));
            dsTipoCambio.ObtenerTipoCambioRow mifila = (dsTipoCambio.ObtenerTipoCambioRow)((DataRow)(myTable.Rows[0]));
            string cadenaDecimales = "" + Convert.ToDouble(mifila.factor);
            cadenaDecimales.Replace(',', '.');
            this.txtTipoCambio.Text = cadenaDecimales;

        }
        catch (Exception ex)
        {

        }
    }
    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        odsItemsAsegurados.InsertParameters.Add("usuario", au.UserName);
        odsItemsAsegurados.Insert();
        gridItemsAsegurados.DataBind();
        txtItemAsegurado.Text = "";
        txtMontoAsegurado.Text = "";
        txtMontoAsegurado2.Text = "";

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsPolizaTableAdapters.ItemAseguradoSelectByIdTableAdapter itemAdapter = new dsPolizaTableAdapters.ItemAseguradoSelectByIdTableAdapter();
            itemAdapter.Delete(Convert.ToDecimal(e.CommandArgument.ToString()));
            gridItemsAsegurados.DataBind();
        }
    }

    
}
