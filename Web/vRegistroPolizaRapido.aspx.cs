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

public partial class vRegistroPolizaRapido : System.Web.UI.Page
{

    public string huboPostBack = "false";
    public String AseguradoraId;
    protected void Page_Load(object sender, EventArgs e)
    {
        AseguradoraId = Request.QueryString["AseguradoraId"].ToString();
        AjaxPro.Utility.RegisterTypeForAjax(typeof(utiles.ajax.gestorAjax));

    }
    protected void imgbtnSave_Click(object sender, ImageClickEventArgs e)
    {
        int BinLength = fupArchivo.PostedFile.ContentLength;

        if (BinLength > 0)
        {
            byte[] BinBuffer = new byte[BinLength];
            fupArchivo.PostedFile.InputStream.Read(BinBuffer, 0, BinLength);
            string filename = fupArchivo.FileName;
            DateTime dateNow = DateTime.Now;
            fArchivo.Text = dateNow.Day.ToString() + dateNow.Month.ToString() + dateNow.Year.ToString() +
                                    dateNow.Hour.ToString() + dateNow.Minute.ToString() + dateNow.Second.ToString() + dateNow.Millisecond.ToString() +
                                  filename.Substring(filename.LastIndexOf("."));
            try
            {
                fupArchivo.SaveAs(Server.MapPath("Polizas") + "/" + fArchivo.Text);
            }
            catch (Exception ex)
            {
                Response.Redirect("vMuestraMensaje.aspx?mensaje=El archivo físico de la póliza no puede ser copiado a su ubicación por favor contacte con Sistemas, la razón de la falla fue : " + ex.Message);
            }

        }


        if (chkNuevoAsegurado.Checked)
        {
            if (rbgrpNaturalJuridica.SelectedValue == "0")
            {
                try
                {
                    odsNuevaPersonaNatural.Insert();
                }
                catch (Exception ex) 
                {                    
                    //Response.Redirect("vMuestraMensaje.aspx?mensaje=El registro de la persona natural ha fallado, por favor intente nuevamente, la razón de la falla fue : "+ ex.Message);
                }
            }
            else
            {
                try
                {
                    odsNuevaPersonaJuridica.Insert();
                }
                catch (Exception ex)
                {
                   // Response.Redirect("vMuestraMensaje.aspx?mensaje=El registro de la persona jurídica ha fallado, por favor intente nuevamente, la razón de la falla fue : " + ex.Message);
                }
            }

        }
        else
        {
            try
            {
                odsNueva.Insert();
            }
            catch (Exception ex)
            {
               /// Response.Redirect("vMuestraMensaje.aspx?mensaje=La creación de la póliza ha fallado, la razón de la falla fue : " + ex.Message);
            }
        }
    }


    protected void odsNuevaPersonaJuridica_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (Request.QueryString["indicador"] == null)
        {
            huboPostBack = "true";
        }
        else
        {
            string indicador = Request.QueryString["indicador"];
            if (indicador != "creacionrapida")
            {
                Response.Redirect("vBusquedaPoliza.aspx?AseguradoraId=" + Request.QueryString["AseguradoraId"] + "&AseguradoraNombre=" + Request.QueryString["NombreAseguradora"] + "&NumeroPoliza=" + this.txtNumPoliza.Text + "&IndicadorLlamada=AsignaPoliza&AjusteId=" + Request.QueryString["AjusteId"]);
            }
            else
            {
                Response.Redirect("vBusquedaPoliza.aspx?AseguradoraId=" + Request.QueryString["AseguradoraId"] + "&AseguradoraNombre=" + Request.QueryString["NombreAseguradora"] + "&NumeroPoliza=" + this.txtNumPoliza.Text + "&AjusteId=" + Request.QueryString["AjusteId"]);
            }
        }
            


    }
    protected void btnNuevoAsegurado_Click(object sender, EventArgs e)
    {

    }
    protected void cbxProducto_DataBound(object sender, EventArgs e)
    {
        RGen.Utiles.utilidades.addItemTodos(sender, "[Elija Uno]", "-1", IsPostBack);
        this.cbxRamo.DataBind();
       
    }
    protected void cbxRamo_DataBound(object sender, EventArgs e)
    {
        if (cbxProducto.SelectedValue == "-1")
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija Primero un Producto]", "-1", false);
            
        }
        else
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija Uno]", "-1", false);
        }
        this.cbxCobertura.DataBind();
    }

    protected void cbxCobertura_DataBound(object sender, EventArgs e)
    {
        if (cbxRamo.SelectedValue == "-1")
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija Primero un Ramo]", "-1", false);
        }
        else
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija Una]", "-1", false);
        }
    }
}
