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

public partial class vAsignarAjustador : System.Web.UI.Page
{
    private RGen.Utiles.AtribucionesUsuario au;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        if (au == null) {
			String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
		}
        validaCasoUso();
    }
    protected void validaCasoUso()
    {
        //verifico que el usuario pueda ejecutar este caso de uso
        if (!au.verificaAtributo("LASINAJUSTADOR"))
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
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
            e.Row.Attributes.Add("onClick", "javascript:showPopWin('vElegirAjustador.aspx?AjusteId=" + AuxRow["AjusteId"].ToString() + "',500,180,null);");
        }
    }
}
