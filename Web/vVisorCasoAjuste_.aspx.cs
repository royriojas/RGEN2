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
using RGen;

public partial class vVisorCasoAjuste_ : System.Web.UI.Page
{
    public string qStringAjusteId;
    RGen.Utiles.AtribucionesUsuario au;
    public decimal AjusteId;

    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(utiles.ajax.gestorAjax));
        qStringAjusteId = Request.QueryString["AjusteId"];
        qStringAjusteId = (qStringAjusteId == null) ? "57" : qStringAjusteId;
        AjusteId = Convert.ToDecimal(qStringAjusteId);
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"]; au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        //utiles.ajax.gestorAjax g = new utiles.ajax.gestorAjax();
//        g.getDiasEnLosEstados(qStringAjusteId,2);
        verificaPermisosInformes();
    }

    private void verificaPermisosInformes()
    {
        if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
        {
            btnInformacionRelevante.Visible = tienePermisosBroker(true);
        }
        if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
        {
            btnInformacionRelevante.Visible = tienePermisosAseguradora(true);
        }
    }

    private Boolean tienePermisosBroker(Boolean valor)
    {
        Boolean doInforme = valor;

        doInforme = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;
        
        doInforme = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;
        
        doInforme = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;
        
        doInforme = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;
        
        return doInforme;
    }

    private Boolean tienePermisosAseguradora(Boolean valor)
    {
        Boolean doInforme = valor;

        doInforme = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;

        doInforme = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;

        doInforme = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;

        doInforme = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        if (!doInforme) return doInforme;

        return doInforme;

    }
}
