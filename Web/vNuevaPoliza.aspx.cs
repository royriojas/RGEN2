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

public partial class vNuevaPoliza : System.Web.UI.Page
{
    public string huboPostBack = "false";
    protected void Page_Load(object sender, EventArgs e)
    {
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
            fupArchivo.SaveAs(Server.MapPath("Polizas") + "/" + fArchivo.Text);

        }

        if (chkNuevoAsegurado.Checked)
        {
            if (rbgrpNaturalJuridica.SelectedValue == "0")
            {
                odsNuevaPersonaNatural.Insert();
            }
            else
            {
                odsNuevaPersonaJuridica.Insert();
            }
            this.txtAsegurado.Text = "";
            this.txtAsegurado.SelectedValue = "";
        }
        else
        {
            odsNueva.Insert();
        }
        String asegurado = (this.txtAsegurado.Text != "") ? this.txtAsegurado.Text : this.txtNombreRazonSocial.Text;

        Response.Redirect("vListaPolizas.aspx?Asegurado=" + asegurado);
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
    protected void cbxAseguradora_DataBound(object sender, EventArgs e)
    {
        RGen.Utiles.utilidades.addItemTodos(sender, "[Elija Una]", "-1", IsPostBack);
    }
    protected void cbxProducto_SelectedIndexChanged(object sender, EventArgs e)
    {
      
    }
}
