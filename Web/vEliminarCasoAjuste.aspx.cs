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

public partial class vEliminarCasoAjuste : System.Web.UI.Page
{
    RGen.Utiles.AtribucionesUsuario au;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        if (au != null)
        {
            if (!au.verificaAtributo("ELIMINARAJUSTE"))
            {
                Response.Redirect("vLogin.aspx?urlAnterior=" + Request.Url.ToString());
            }
        }
        else
        {            
            Response.Redirect("vLogin.aspx?urlAnterior=" + Request.Url.ToString());
        }
        txtFechaEliminacion.Text = DateTime.Now.ToShortDateString();
    }
    protected void btnRegistrarEliminacion_Click(object sender, EventArgs e)
    {
        DateTime result;
        if (DateTime.TryParse(txtFechaEliminacion.Text, out result))
        {
            sdsEliminarAjuste.Update();

            int ajusteId;
            if (int.TryParse(Request.QueryString["AjusteId"],out ajusteId))             
            {                
                //Cancelar Notificaciones pendientes
                GestorNotificacion.cancelAllRequest(ajusteId);
            }

            
        }
        else
        {
            this.lblMensaje.Text = "Error: la fecha que intenta registrar no tiene el formato adecuado, por favor use dd-MM-yyyy";
            this.pnlConfirmacion.Style.Remove(HtmlTextWriterStyle.BackgroundColor);
            this.pnlConfirmacion.Style.Add(HtmlTextWriterStyle.BackgroundColor, "RED");
            this.pnlConfirmacion.Visible = true;
        }

    }
    protected void sdsEliminarAjuste_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        //utiles.debugClass.muestra(e.Command,Server.MapPath("log.txt"));
    }
    protected void sdsEliminarAjuste_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        this.lblMensaje.Text = "El Caso de Ajuste se encuentra ahora Eliminado, ya no podrá acceder a el...";
        /*this.pnlConfirmacion.Style.Remove(HtmlTextWriterStyle.BackgroundColor);
        this.pnlConfirmacion.Style.Add(HtmlTextWriterStyle.BackgroundColor, "RED");*/
        this.pnlConfirmacion.Visible = true;

        this.ClientScript.RegisterStartupScript(this.GetType(), "scriptInicial", "window.onload = function() { cierraLaVentana();}", true);
    }
}
