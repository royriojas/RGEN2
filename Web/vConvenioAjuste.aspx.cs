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
using RGen.Utiles;
using System.Globalization;
using RGen;

public partial class vConvenioAjuste : System.Web.UI.Page
{
    public string qStringAjusteId
    {
        get
        {
            object obQString = ViewState["qStringAjusteId"];
            if (obQString == null) return "";
            return Convert.ToString(obQString);
        }
        set
        {
            ViewState["qStringAjusteId"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        qStringAjusteId = Request.QueryString["AjusteId"];

        if (!IsPostBack) {
            this.chkRechazo.Checked = GestorAjuste.AjusteRechazado(Convert.ToInt32(qStringAjusteId));
            this.convenioAjusteFormView.Visible = !this.chkRechazo.Checked;
        }
        
        this.chkRechazo.CheckedChanged += new EventHandler(chkRechazo_CheckedChanged);

    }

    public Boolean isValidDecimal(string str_decimal)
    {
        decimal decTotalPerdida;
        Boolean isValid = decimal.TryParse(str_decimal, out decTotalPerdida);

        //return isValid && (decTotalPerdida != decimal.Zero);
        return isValid;
    }
    public Boolean isValidDeducible(string str_decimal)
    {
        decimal decTotalPerdida;
        Boolean isValid = decimal.TryParse(str_decimal, out decTotalPerdida);

        return isValid;
    }

    protected void convenioAjusteFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        string valueTotalPerdida = utilidades.getInternalValueFromForm(this.convenioAjusteFormView, "txtTotalPerdida");
        string valueIndemnizacion = utilidades.getInternalValueFromForm(this.convenioAjusteFormView, "txtTotalIndemnizacion");
        string valueDeducible = utilidades.getInternalValueFromForm(this.convenioAjusteFormView, "txtDeducible");

        NumberFormatInfo numberFormat = CultureInfo.CurrentCulture.NumberFormat;

        if (!(isValidDecimal(valueTotalPerdida) && isValidDecimal(valueIndemnizacion) && isValidDeducible(valueDeducible)))
        {
            this.pnlConfirmacion.Visible = true;
            this.pnlConfirmacion.Style.Remove(HtmlTextWriterStyle.BackgroundColor);
            this.pnlConfirmacion.Style.Add(HtmlTextWriterStyle.BackgroundColor, "RED");
            this.lblError.Text = "Ocurrió un error en las cantidades: Verifique por favor que el separador de decimales sea : " + numberFormat.NumberDecimalSeparator;
            e.Cancel = true;
        }


    }
    public String muestraSimbolo(Object simbolo)
    {

        string returnValue = Convert.ToString(simbolo);
        if (string.IsNullOrEmpty(returnValue))
        {
            returnValue = "";
        }
        return returnValue;
    }

    protected void convenioAjusteFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        this.pnlConfirmacion.Visible = true;
        /*this.pnlConfirmacion.Style.Remove(HtmlTextWriterStyle.BackgroundColor);
        this.pnlConfirmacion.Style.Add(HtmlTextWriterStyle.BackgroundColor, "RED");*/
        this.lblError.Text = "El convenio ha sido actualizado, haga click en ver PDF para poder imprimir el convenio";
        //e.Cancel = true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        notificarConvenioAjuste();
    }

    private void notificarConvenioAjuste()
    {
        Decimal ajusteId = Convert.ToDecimal(qStringAjusteId);
        String cuerpo = GestorNotificacion.armaCuerpo(ajusteId, Server.MapPath("Conf/plantillaNotificacion.html"), "Se notifica la aceptación del CONVENIO DE AJUSTE");

        String path = Server.MapPath("Informes") + "\\" + "CA-" + qStringAjusteId + ".pdf";
        GestorNotificacion.notificarInformes(ajusteId, "ConvenioAjuste_" + qStringAjusteId, "N_CONVENIOAJUSTE", "Notificación de CONVENIO DE AJUSTE", cuerpo, DateTime.Now, path);
    }
    protected void chkRechazo_CheckedChanged(object sender, EventArgs e)
    {
        RGen.GestorAjuste.RechazaAjuste(Convert.ToInt32(qStringAjusteId), this.chkRechazo.Checked);

        this.convenioAjusteFormView.Visible = !this.chkRechazo.Checked;
    }

    protected void AjaxPanel1_AjaxCallEnd(object sender, EventArgs e)
    {
        if (this.convenioAjusteFormView.Visible) MagicAjax.AjaxCallHelper.Write("ReApplyJavascripts();");
    }
}
