using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class RimacInforme_Coberturas : System.Web.UI.Page
{



    protected void Page_Load(object sender, EventArgs e)
    {
        message.Visible = false;
        if (Request.QueryString["IdAjuste"] == null)
        {
            showMessage("No se encontro el Ajuste");
        }

        if (Request.QueryString["Action"] == "Editar" && Request.QueryString["IdRamo"] != null)
        {
            FormViewCoberturasAplicables.ChangeMode(FormViewMode.Edit);
        }

        if (!String.IsNullOrEmpty(Request.QueryString["urlAnterior"]))
        {
            volverLink.NavigateUrl = Request.QueryString["urlAnterior"];
        }
        else
        {
            volverLink.Visible = false;
        }

    }

    private void showMessage(string msg)
    {
        message.Visible = true;
        message.InnerHtml = "<p>" + msg + "</p>";
    }

    protected void FormViewCoberturasAplicables_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        DropDownList ddlMoneda = FormViewCoberturasAplicables.FindControl("ddlMoneda") as DropDownList;
        if (ddlMoneda == null || ddlMoneda.SelectedValue == "-1")
        {
            e.Cancel = true;
            showMessage("Escoja una moneda por favor");
            return;
        }

        e.Values["IdAjuste"] = Request.QueryString["IdAjuste"];
        e.Values["MonedaSumaAsegurada"] = ddlMoneda.SelectedValue;


    }
    protected void FormViewCoberturasAplicables_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            showMessage("Error : " + e.Exception.Message);
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
        }
        else
        {
            GridViewCoberturas.DataBind();
        }
    }

    protected void FormViewCoberturasAplicables_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        DropDownList ddlMoneda = FormViewCoberturasAplicables.FindControl("ddlMoneda") as DropDownList;
        if (ddlMoneda == null || ddlMoneda.SelectedValue == "-1")
        {
            e.Cancel = true;
            showMessage("Escoja una moneda por favor");
            return;
        }

        e.NewValues["IdAjuste"] = Request.QueryString["IdAjuste"];
        e.NewValues["MonedaSumaAsegurada"] = ddlMoneda.SelectedValue;
    }

    protected void FormViewCoberturasAplicables_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            showMessage("Error : " + e.Exception.Message);
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
        }
        else
        {
            GridViewCoberturas.DataBind();
        }
    }

    protected void FormViewCoberturasAplicables_DataBound(object sender, EventArgs e)
    {

        DropDownList ddlMoneda = FormViewCoberturasAplicables.FindControl("ddlMoneda") as DropDownList;

        if (ddlMoneda == null) return;
        HiddenField ddlMonedaHdn = FormViewCoberturasAplicables.FindControl("ddlMonedaHdn") as HiddenField;
        if (ddlMonedaHdn != null && ddlMonedaHdn.Value != String.Empty)
        {
            try
            {
                ddlMoneda.ClearSelection();
                ddlMoneda.SelectedValue = ddlMonedaHdn.Value;
            }
            catch (Exception ex)
            {
                showMessage("Error : " + ex.Message);
            }
        }

    }

    protected void FormViewCoberturasAplicables_Delete(object sender, FormViewDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            showMessage("Error : " + e.Exception.Message);
            FormViewCoberturasAplicables.ChangeMode(FormViewMode.Edit);
        }
        else
        {
            showMessage("Cobertura eliminada!");
            Response.Redirect(string.Format("~/RimacInforme/Coberturas.aspx?IdAjuste={0}&nc={1}", Request.QueryString["IdAjuste"], DateTime.Now.Ticks));
        }
    }
}
