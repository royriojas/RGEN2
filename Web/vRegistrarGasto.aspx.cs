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

public partial class vRegistrarGasto : System.Web.UI.Page
{
    public int num = 1;

    protected void Page_Load(object sender, EventArgs e)
    {

        RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(Request.QueryString["AjusteId"],Response,"vLogin.aspx?urlAnterior="+ Request.RawUrl);

        
        AjaxPro.Utility.RegisterTypeForAjax(typeof(utiles.ajax.gestorAjax));
        this.cambiaTipoCambio();

        if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
        {
            this.nuevoGasto.Attributes.Add("style", "display:none;");
            this.GridView1.Columns[13].Visible = false;
        }
        if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
        {
          this.nuevoGasto.Attributes.Add("style", "display:none;");
          this.GridView1.Columns[13].Visible = false;
        }
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

        if (this.txtFecha.Text != "") 
        {
            DateTime t = Convert.ToDateTime(this.txtFecha.Text);
            this.txtFecha.Text = t.ToString();
        }
        
        odsGastos.Insert();
        
        Response.Redirect("vRegistrarGasto.aspx?AjusteId=" + Request.QueryString["AjusteId"]);
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsGastoTableAdapters.GastoListaTableAdapter itemAdapter = new dsGastoTableAdapters.GastoListaTableAdapter();
            itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
            GridView1.DataBind();
        }
    }
}
