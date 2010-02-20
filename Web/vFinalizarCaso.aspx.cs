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

public partial class vFinalizarCaso : System.Web.UI.Page
{
    private RGen.Utiles.AtribucionesUsuario au;

    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        if ((au == null) || !(au.TipoUsuario == "Administrador" || au.TipoUsuario == "Ajustador" || au.TipoUsuario=="Asistente"))
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }
        else
        {
            if (Request.QueryString["AjusteId"] != null)
            {
                //si no tiene convenio
                if (!(RGen.GestorAjuste.dameCodigoEstado(Convert.ToDecimal(Request.QueryString["AjusteId"])) >= 8))
                {
                    this.contenidoTotal.Style.Value = "display:none";
                    this.lblError.Visible = true;
                    this.pnlError.Visible = true;
                }
            }
            else
            {
                Response.Redirect("vLogin.aspx?urlAnterior=" + Request.Url.ToString());
            }
        }

    }

    protected void finalizarButton_Click(object sender, EventArgs e)
    {
        int BinLength = constanciaFileUpload.PostedFile.ContentLength;
        DateTime result;
        //falta finalizar caso
        if (!DateTime.TryParse(this.frecepcionTextBox.Text, out result))
        {
            this.lblMensaje.Text = "Error: Ingrese una fecha correcta en el formato dd-MM-yyyy";
            this.pnlConfirmacion.Style.Remove(HtmlTextWriterStyle.BackgroundColor);
            this.pnlConfirmacion.Style.Add(HtmlTextWriterStyle.BackgroundColor, "RED");
            this.pnlConfirmacion.Visible = true;
        }
        else
        {


            if (BinLength > 0 && (constanciaFileUpload.PostedFile.ContentType == "image/jpeg") || (constanciaFileUpload.PostedFile.ContentType == "image/pjpeg") && Request.QueryString["AjusteId"] != null)
            {
                byte[] BinBuffer = new byte[BinLength];
                constanciaFileUpload.PostedFile.InputStream.Read(BinBuffer, 0, BinLength);
                byte[] imagenThumb = ImgHdl.ImgResize.ResizeImageFile(BinBuffer, 80, ImgHdl.Horientation.Portrait);

                int res = 0;
                dsAjusteTableAdapters.AjusteTotalInsertTableAdapter ajusteAdapter = new dsAjusteTableAdapters.AjusteTotalInsertTableAdapter();
                res = ajusteAdapter.FinalizarCaso(decimal.Parse(Request.QueryString["AjusteId"].ToString()), DateTime.Now, constanciaFileUpload.FileName, comentarioTextBox.Text, constanciaFileUpload.FileBytes, imagenThumb, au.UserName);
                //Response.Redirect("vListaAjuste.aspx");            

                if (res > 0)
                {
                    this.lblMensaje.Text = "El Ajuste se ha Finalizado Correctamente... por favor cierre la ventana";
                   /* this.pnlConfirmacion.Style.Remove(HtmlTextWriterStyle.BackgroundColor);
                    this.pnlConfirmacion.Style.Add(HtmlTextWriterStyle.BackgroundColor, "RED");*/
                    this.pnlConfirmacion.Visible = true;
                    this.ClientScript.RegisterStartupScript(this.GetType(), "scriptInicial", "window.onload = function() { cierraLaVentana();}", true);
                }

            }
            else
            {
                this.lblMensaje.Text = "Error: El Archivo que intenta subir no es una imagen jpg";
                this.pnlConfirmacion.Style.Remove(HtmlTextWriterStyle.BackgroundColor);
                this.pnlConfirmacion.Style.Add(HtmlTextWriterStyle.BackgroundColor, "RED");
                this.pnlConfirmacion.Visible = true;

            }
        }
    }
}

