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

public partial class Mantenimientos_vListaCoberturas : System.Web.UI.Page
{
    private  RGen.Utiles.AtribucionesUsuario au;
    protected void Page_Load(object sender, EventArgs e)
    {
       au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "../vLogin.aspx?urlAnterior=" + Request.RawUrl);

       
        String action = Utilidades.isNull(Request.QueryString["action"], "nuevo");
        switch (action)
        {
            case "nuevo": doNewActions();
                break;

            case "editar": doEditActions();
                break;
        }
    }

    private void doEditActions()
    {
        this.FormView1.DefaultMode = FormViewMode.Edit;
        this.FormView1.ChangeMode(FormViewMode.Edit);

        string insertedFlag = Utilidades.isNull(Request.QueryString["inserted"], "false");
        string updatedFlag = Utilidades.isNull(Request.QueryString["updated"], "false");
        if (insertedFlag == "true") {
           this.pnlMensajeConfirmacion.Visible = true;
        }
        if (updatedFlag == "true")
        {
            this.pnlMensajeConfirmacion.Visible = true;
            this.lblMensaje.Text = "La Cobertura ha sido actualizada exitosamente";
        }

        this.pnlNewItem.Style.Value = "display:block";
        this.pnlFilters.Style.Value = "display:none";

    }
    private void doNewActions()
    {
        this.FormView1.DefaultMode = FormViewMode.Insert;
        this.FormView1.ChangeMode(FormViewMode.Insert);

        string updatedFlag = Utilidades.isNull(Request.QueryString["inserted"], "false");
        if (updatedFlag == "true") {
           this.pnlMensajeConfirmacion.Visible = true;
            this.lblMensaje.Text = "La Cobertura ha sido actualizada exitosamente";
        }
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("ucrea", au.UserName);
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        this.pnlFilters.Style.Remove(HtmlTextWriterStyle.Display);
        this.pnlFilters.Style.Add(HtmlTextWriterStyle.Display, "block");

        this.pnlNewItem.Style.Remove(HtmlTextWriterStyle.Display);
        this.pnlNewItem.Style.Add(HtmlTextWriterStyle.Display, "none");

        this.GridView1.DataSourceID = "odsCoberturaLista";
    }
    public String getEstado(String estado)
    {
        string state = "Habilitado";
        if (estado != "A") state = "<b>Inhabilitado</b>";

        return state;
    }
    public String setImage(string estado)
    {
        String mensaje = "";
        if (estado == "A")
        {
            mensaje = "~/Images/btnsListas/icon_delete.jpg";
        }
        else
        {
            mensaje = "~/Images/btnsListas/icon_ok.jpg";
        }
        return mensaje;
    }

    public String setUrl(decimal RiesgoId)
    {
        return "return redirectUrl('" + this.Request.Path + "','editar'," + RiesgoId + ");";
        //return "document.location.href = '" + this.Request.Path + "?action=editar&FuncionalidadId="+ funcionalidadId +"';return false;";
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        //decimal currentId = (decimal)e.Values["riesgoId"];
    }
  
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues.Add("uupdate", au.UserName);
    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        String rawUrl = this.Request.RawUrl.Replace("&inserted=true", "");
        rawUrl = rawUrl.Replace("&updated=true","");

        rawUrl = rawUrl + "&updated=true";
       
        Response.Redirect(rawUrl);
        
    }
    protected void FormView1_DataBound(object sender, EventArgs e)
    {
        string action = Utilidades.isNull(Request.QueryString["action"],"nuevo");
        if (action == "editar") {
            this.lblCobertura.Text = "Cobertura : " + Utilidades.getInternalValueFromForm(this.FormView1, "txtCobertura");
        }
    }
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(this.Request.Path);
    }

    public String setClientClick(String estado)
    {
        String mensaje = "";
        if (estado == "A")
        {
            mensaje = "¿Desea Realmente Deshabilitar esta Cobertura?";
        }
        else
        {
            mensaje = "¿Desea Realmente Habilitar esta Cobertura?";
        }
        

        return "return confirm('" + mensaje + "');";
    }
    protected void odsCoberturaFRM_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        decimal? riesgoId = (decimal?)e.OutputParameters["riesgoId"];

        if (riesgoId != null)
        {
            Response.Redirect(this.Request.Path + "?action=editar&inserted=true&RiesgoId=" + riesgoId);
        }
        else
        {
            Response.Write("error");
        }
    }
    protected void odsCoberturaLista_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        try
        {
            this.lblListaTitulo.Text = "Lista de Coberturas ("+((DataTable)e.ReturnValue).Rows.Count.ToString() + ")";

            
        }
        catch (Exception ex)
        {
            //this.lblListaTitulo.Text = "0";
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
