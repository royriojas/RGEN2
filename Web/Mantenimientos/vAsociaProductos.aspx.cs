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
using CCSOL.Utiles;

public partial class Mantenimientos_vAsociaProductos : System.Web.UI.Page
{
    private RGen.Utiles.AtribucionesUsuario au = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "../vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }


        string Producto = Utilidades.isNull(Request.QueryString["nombreProducto"], "");
        this.lblProductoSeleccionado.Text = "Asociar los siguientes Ramos a : " + Producto;


    }
    protected void imgBtnSave_Click(object sender, ImageClickEventArgs e)
    {
        this.doAssociations();
        this.grdRamos.DataBind();
    }

    private void doAssociations()
    {
        foreach (GridViewRow row in grdRamos.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("chk");
            if (chk.Checked)
            {
                sdsRamosChecks.InsertParameters.Clear();
                sdsRamosChecks.InsertParameters.Add("productoId", Request.QueryString["ProductoId"]);
                sdsRamosChecks.InsertParameters.Add("ramoId", row.Cells[0].Text);
                sdsRamosChecks.Insert();
            }
            else
            {
                sdsRamosChecks.DeleteParameters.Clear();
                sdsRamosChecks.DeleteParameters.Add("productoId", Request.QueryString["ProductoId"]);
                sdsRamosChecks.DeleteParameters.Add("ramoId", row.Cells[0].Text);
                sdsRamosChecks.Delete();

            }
        }
        Response.Redirect("../vListaProducto.aspx");
    }
}
