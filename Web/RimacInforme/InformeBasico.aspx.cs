﻿using System;
using R3M.Controls;
using System.Web.UI;
using System.Web.UI.WebControls;
using App_Code.RimacInforme.Domain;

public partial class RimacInforme_InformeBasico : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        R3M.Controls.Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/informes.css"), FileType.Css);
        R3M.Controls.Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/jdialog.js"), FileType.Javascript);
    }

    protected void DoSave(object sender, EventArgs e)
    {
        DoSave();
    }

    private void DoSave()
    {
        this.FormViewInforme.UpdateItem(false);
    }

    protected void GotoPoliza(object sender, EventArgs e)
    {
        DoSave();
        Response.Redirect("~/vEditorPolizaAjuste.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Server.UrlEncode(Request.Url.ToString()));
    }

    protected void GotoDamage(object sender, EventArgs e)
    {
        DoSave();
        Response.Redirect("~/vRegistroBienesAfectados.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Server.UrlEncode(Request.Url.ToString()));
    }


    protected void GotoDocuments(object sender, EventArgs e)
    {

        /*DoSave();
        Response.Redirect("~/vDocumentos.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Server.UrlEncode(Request.Url.ToString()));*/
    }


    protected void FormViewInforme_DataBound(object sender, EventArgs e)
    {
        RimacInforme_detalleSublimitesAfectados ctrl = this.FormViewInforme.FindControl("detalleSublimitesAfectados1") as RimacInforme_detalleSublimitesAfectados;
        if (ctrl != null)
        {
            ctrl.AjusteId = Convert.ToDecimal(Request.QueryString["AjusteId"]);
            ctrl.BindData();
        }



        //this.FormViewInforme.ItemCreated += new EventHandler(FormViewInforme_ItemCreated);
        BindTipoDeMoneda();
    }

    private void BindTipoDeMoneda()
    {
        AjusteDto ajusteDto = this.FormViewInforme.DataItem as AjusteDto;
        if (ajusteDto == null) return;
        DropDownList dropDownListTipoMonedaReclamo = FormViewInforme.FindControl("_dropDownListTipoMonedaReclamo") as DropDownList;
        if (dropDownListTipoMonedaReclamo != null)
        {
            dropDownListTipoMonedaReclamo.ClearSelection();
            dropDownListTipoMonedaReclamo.SelectedValue = ajusteDto.ReclamoMonedaId.ToString();
        }

        DropDownList dropDownListTipoMonedaReserva = FormViewInforme.FindControl("_dropDownListTipoMonedaReserva") as DropDownList;
        if (dropDownListTipoMonedaReserva != null)
        {
            dropDownListTipoMonedaReserva.ClearSelection();
            dropDownListTipoMonedaReserva.SelectedValue = ajusteDto.ReservaMonedaId.ToString();

        }
    }

    protected void FormViewInforme_DataBinding(object sender, EventArgs e)
    {

    }

    protected void FormViewInforme_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {

        DropDownList _dropDownListTipoMonedaReclamo = this.FormViewInforme.FindControl("_dropDownListTipoMonedaReclamo") as DropDownList;
        if (_dropDownListTipoMonedaReclamo != null && _dropDownListTipoMonedaReclamo.SelectedValue != "-1")
        {
            e.NewValues["ReclamoMonedaId"] = _dropDownListTipoMonedaReclamo.SelectedValue;
        }

        DropDownList _dropDownListTipoMonedaReserva = this.FormViewInforme.FindControl("_dropDownListTipoMonedaReserva") as DropDownList;
        if (_dropDownListTipoMonedaReserva != null && _dropDownListTipoMonedaReserva.SelectedValue != "-1")
        {
            e.NewValues["ReservaMonedaId"] = _dropDownListTipoMonedaReserva.SelectedValue;
        }
    }

}
