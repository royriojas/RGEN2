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
using System.IO;

public partial class vEditorPoliza : System.Web.UI.Page
{
    public string qStringPolizaId;
    protected void Page_Load(object sender, EventArgs e)
    {
        qStringPolizaId = Request.QueryString["PolizaId"];
    }


    protected void cbxProducto_SelectedIndexChanged(object sender, EventArgs e)
    {
        ((TextBox)this.fvDatosGenerales.FindControl("productoidTextBox")).Text = (((DropDownList)this.fvDatosGenerales.FindControl("cbxProducto")).SelectedValue).ToString();
        //((SqlDataSource)(((DropDownList)this.fvDatosGenerales.FindControl("cbxRamo")).DataSource)).DataBind();
        ((DropDownList)this.fvDatosGenerales.FindControl("cbxRamo")).DataBind();

    }
    protected void cbxRamo_SelectedIndexChanged(object sender, EventArgs e)
    {   
        ((TextBox)this.fvDatosGenerales.FindControl("ramoidTextBox")).Text= (((DropDownList)this.fvDatosGenerales.FindControl("cbxRamo")).SelectedValue).ToString();
        //((SqlDataSource)(((DropDownList)this.fvDatosGenerales.FindControl("cbxCobertura")).DataSource)).DataBind();
        ((DropDownList)this.fvDatosGenerales.FindControl("cbxCobertura")).DataBind();
    }
    protected void cbxCobertura_SelectedIndexChanged(object sender, EventArgs e)
    {
        ((TextBox)this.fvDatosGenerales.FindControl("coberturaidTextBox")).Text = (((DropDownList)this.fvDatosGenerales.FindControl("cbxCobertura")).SelectedValue).ToString();
    }




    protected void fvDatosGenerales_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        
        //String msg = e.NewValues.ToString();
        FileUpload archivo= (FileUpload)fvDatosGenerales.FindControl("fupArchivo");
        String fArchivo ;
        int BinLength = archivo.PostedFile.ContentLength;
        if (BinLength > 0)
        {
            byte[] BinBuffer = new byte[BinLength];
            archivo.PostedFile.InputStream.Read(BinBuffer, 0, BinLength);
            string filename = archivo.FileName;
            DateTime dateNow = DateTime.Now;

            fArchivo = dateNow.Day.ToString() + dateNow.Month.ToString() + dateNow.Year.ToString() +
                                    dateNow.Hour.ToString() + dateNow.Minute.ToString() + dateNow.Second.ToString() + dateNow.Millisecond.ToString() +
                                  filename.Substring(filename.LastIndexOf("."));
            archivo.SaveAs(Server.MapPath("Polizas") + "/" + fArchivo);

            e.NewValues.Add("nombreArchivo", fArchivo);
        }
        e.NewValues.Add("productoid", (((DropDownList)this.fvDatosGenerales.FindControl("cbxProducto")).SelectedValue).ToString());
        e.NewValues.Add("ramoid", (((DropDownList)this.fvDatosGenerales.FindControl("cbxRamo")).SelectedValue).ToString());
        e.NewValues.Add("coberturaid", (((DropDownList)this.fvDatosGenerales.FindControl("cbxCobertura")).SelectedValue).ToString());


        
    }
    protected void fvDatosGenerales_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsPolizaTableAdapters.polizaEditorCompletoTableAdapter itemAdapter = new dsPolizaTableAdapters.polizaEditorCompletoTableAdapter();
            try
            {
                itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
                Response.Redirect("vListaPolizas.aspx");
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                if (ex.Message == "CASOSEXISTS")
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "_script", "alert('Esta poliza está asociada a varios ajustes no se puede eliminar');",true);
                }

            }                        
        }

    }
    protected void fvDatosGenerales_DataBinding(object sender, EventArgs e)
    {
        
    }
    protected void fvDatosGenerales_Load(object sender, EventArgs e)
    {

    }
    protected void fvDatosGenerales_DataBound(object sender, EventArgs e)
    {

        setDropDownValues(IsPostBack);

    }

    private void setDropDownValues(Boolean PostBack)
    {
        if (!PostBack)
        {
            try
            {
                (((DropDownList)this.fvDatosGenerales.FindControl("cbxProducto"))).DataBind();
                DropDownList dl = (((DropDownList)this.fvDatosGenerales.FindControl("cbxProducto")));
                dl.ClearSelection();
                dl.Items.FindByValue(((TextBox)this.fvDatosGenerales.FindControl("productoidTextBox")).Text).Selected = true;

                (((DropDownList)this.fvDatosGenerales.FindControl("cbxRamo"))).DataBind();
                dl = (((DropDownList)this.fvDatosGenerales.FindControl("cbxRamo")));
                dl.ClearSelection();
                dl.Items.FindByValue(((TextBox)this.fvDatosGenerales.FindControl("ramoidTextBox")).Text).Selected = true;

                (((DropDownList)this.fvDatosGenerales.FindControl("cbxCobertura"))).DataBind();
                dl = (((DropDownList)this.fvDatosGenerales.FindControl("cbxCobertura")));
                dl.ClearSelection();
                dl.Items.FindByValue(((TextBox)this.fvDatosGenerales.FindControl("coberturaidTextBox")).Text).Selected = true;
            }
            catch (Exception ex)
            {
                //Response.Write(ex.Message);
            }
        }

    }
    protected void fvDatosGenerales_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        Response.Redirect(this.Request.Url.ToString());
    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        this.fvDatosGenerales.UpdateItem(true);
    }
}
