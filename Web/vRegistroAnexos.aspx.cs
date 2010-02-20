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
using System.Data.SqlClient;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Security.AccessControl;
using CCSOL.Utiles;
using RGen.Utiles;

public partial class vRegistroAnexos : System.Web.UI.Page
{
    private RGen.Utiles.AtribucionesUsuario au;
    public int num = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }

        if (Request.QueryString["AjusteId"] == null)
        {
            Response.Redirect("vLogin.aspx?urlAnterior=" + Request.Url);
        }
        txtAjusteId.Text = Request.QueryString["AjusteId"];
       
        if (au != null)
        {
            if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
            {
                this.nuevoAnexo.Attributes.Add("style", "display:none;");
                this.gwAnexos.Columns[7].Visible = false;
            }
            if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
            {
                this.nuevoAnexo.Attributes.Add("style", "display:none;");
                this.gwAnexos.Columns[7].Visible = false;
            }
            if (!IsPostBack)
            {
                this.Panel1.Visible = false;
            }
        }
        else
        {
            Response.Redirect("vLogin.aspx?urlAnterior=" + Request.Url);
        }
    }

    protected void btnAnexar_Click(object sender, EventArgs e)
    {
        int BinLength = fupArchivo.PostedFile.ContentLength;

        if (BinLength > 0)
        {
            byte[] BinBuffer = new byte[BinLength];
            fupArchivo.PostedFile.InputStream.Read(BinBuffer, 0, BinLength);
            Boolean ima = (fupArchivo.PostedFile.ContentType == "image/jpeg") || (fupArchivo.PostedFile.ContentType == "image/pjpeg");
            byte[] imagenThumb = null;
            if (ima)
            {
                imagenThumb = ImgHdl.ImgResize.ResizeImageFile(BinBuffer, 80, ImgHdl.Horientation.Portrait);                
            }

            byte[] binaryFile = (this.chkCompress.Checked && ima) ? Utilidades.ResizeImageFile(fupArchivo.FileBytes) : fupArchivo.FileBytes;

            dsAnexoTableAdapters.AnexoEditorTableAdapter ta = new dsAnexoTableAdapters.AnexoEditorTableAdapter();
            ta.Insert(Convert.ToDecimal(this.txtAjusteId.Text), fupArchivo.FileName, this.txtDescripcion.Text, binaryFile, ima, imagenThumb);

            //  odsAnexoEditor.DataBind();
            txtDescripcion.Text = "";

            Response.Redirect("vRegistroAnexos.aspx?AjusteId=" + txtAjusteId.Text);

        }
    }
    protected void gwAnexos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            txtAnexoId.Text = e.CommandArgument.ToString();
            this.Panel1.Visible = false;
            odsAnexoEditor.Delete();
            gwAnexos.DataBind();
        }
    }

    protected void gwAnexos_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;

            HyperLink descargaHyperLink = (HyperLink)e.Row.FindControl("descargaHyperLink");
            descargaHyperLink.NavigateUrl = "javascript:GetBinary('vGetBinary.aspx?AjusteId=" + AuxRow["ajusteId"].ToString() + "&ArchivoId=" + AuxRow["archivoId"].ToString() + "')";
            if ((Boolean)AuxRow["imagen"])
            {
                descargaHyperLink.NavigateUrl = "javascript:WinPopUpMax('vViewImage.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&ArchivoId=" + AuxRow["archivoId"].ToString() + "')";                
                descargaHyperLink.ImageUrl = "vGetImage.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&ArchivoId=" + AuxRow["archivoId"].ToString();
            }            
        }
    }
    protected void btnAgregarImg_Click(object sender, EventArgs e)
    {
        DirectoryInfo d = new DirectoryInfo(Server.MapPath("~/Upload"));
        foreach (FileInfo f in d.GetFiles("*.jpg"))
        {
            try
            {
                //buffer para la imagen original
                byte[] buffer = new byte[f.OpenRead().Length];
                //abrimos el archivo para lectura y vaciamos su contenido en la variable buffer
                f.OpenRead().Read(buffer, 0, (int)f.OpenRead().Length);
                //creamos su thumbnail
                byte[] imagenThumb = ImgHdl.ImgResize.ResizeImageFile(buffer, 80, ImgHdl.Horientation.Portrait);

                byte[] newImage = (this.chkCompress.Checked)? CCSOL.Utiles.Utilidades.ResizeImageFile(buffer) : buffer;

                dsAnexoTableAdapters.AnexoEditorTableAdapter ta = new dsAnexoTableAdapters.AnexoEditorTableAdapter();
                //insertamos la imagen
                ta.Insert(Convert.ToDecimal(this.txtAjusteId.Text), f.Name, f.Name, newImage, true, imagenThumb);
            }
            catch (Exception ex)
            {

            }                        
        }
        Boolean falla = false;
        foreach (FileInfo f in d.GetFiles("*.jpg"))
        {
            try
            {                
                f.Delete();
                //File.Delete(f.FullName);               
            }
            catch (Exception ex)
            {
                falla = true;
            }
        }
        
        if (falla)
        {
            this.Panel1.Visible = true;
        }

        this.gwAnexos.DataBind();
    }
    protected void gwAnexos_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        //this.odsAnexoEditor.UpdateParameters.Add("uupdate", TypeCode.String, au.UserName);
        e.NewValues.Add("uupdate", au.UserName);        
    }
    protected void odsAnexoEditor_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        
    }
}
