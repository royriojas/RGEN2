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

public partial class RgenControl_ : System.Web.UI.UserControl
{
    public string ajusteid;
    public decimal AjusteId;
    protected void Page_Load(object sender, EventArgs e)
    {
        ajusteid = Request.QueryString["AjusteId"];
        AjusteId = Convert.ToDecimal(ajusteid);

        RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];


        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.Url.ToString());

        // Ene ste punto se debe validar el acceso del usuario al informe
        dsInformesTableAdapters.InformeListaTableAdapter informeAdapter = new dsInformesTableAdapters.InformeListaTableAdapter();

        Boolean doEvaluateBroker = false;
        Boolean doEvaluateAseguradora = false;
        if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
        {
            doEvaluateBroker = true;
        }
        if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
        {
            doEvaluateAseguradora = true;
        }

        Boolean doInformeBasico = true;
        if (doEvaluateBroker)
        {
          doInformeBasico = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        if (doEvaluateAseguradora)
        {
          doInformeBasico = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        Boolean doInformePreliminar = true;
        if (doEvaluateBroker)
        {
          doInformePreliminar = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        if (doEvaluateAseguradora)
        {
          doInformePreliminar = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        Boolean doInformeComplementario = true;
        if (doEvaluateBroker)
        {
          doInformeComplementario = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        if (doEvaluateAseguradora)
        {
          doInformeComplementario = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        Boolean doInformeFinal = true;
        if (doEvaluateBroker)
        {
          doInformeFinal = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        if (doEvaluateAseguradora)
        {
          doInformeFinal = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_INFORMEBASICO");
        }
        Boolean doConvenio = true;
        if (doEvaluateBroker)
        {
          doConvenio = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_CONVENIOAJUSTE");
        }
        if (doEvaluateAseguradora)
        {
          doConvenio = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_CONVENIOAJUSTE");
        }

        // Informe basico
        decimal informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "B");
        if (informeId != 0 && (doInformeBasico)) this.lnkInformeBasico.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString() + ");";
        
        // Informe preliminar
        informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "P");
        if (informeId != 0 && (doInformePreliminar)) this.lnkInformePreliminar.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString() + ");";

        // Informe complementario
        informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "C");
        if (informeId != 0 && (doInformeComplementario)) this.lnkinformesComplementarios.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString() + ");";

        // Informe final
        informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "F");
        if (informeId != 0 && (doInformeFinal)) this.lnkInformeFinal.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString() + ");";

        informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "X"); //X means Convenio de Ajuste
        if (informeId != 0 && (doConvenio)) this.lnkConvenio.HRef = "javascript:VerConvenio(" + ajusteid + ");";

      
        //this.news_content.InnerHtml = "scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
        cargaDataALosDivs();
        cargaLinks();

    }

   

  
    private void cargaLinks()
    {
       RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
       Boolean doActividades = true;
       Boolean doAnexos = true;
       Boolean doComunicaciones = true;
       Boolean doGastos = true;
	   
       if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
       {
         doActividades = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORAACTIVIDADES");
         doAnexos = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORAANEXOS");
         doComunicaciones = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORACOMUNICACIONES");
         doGastos = GestorNotificacion.hasVisibilityPermissionAseguradora(GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORAGASTOS");  
              
           if (doActividades) this.lnkActividades.HRef = "vRegistroActividades.aspx?AjusteId=" + ajusteid;
           if (doActividades) this.lnkActividades.Attributes.Add("onclick", "muestraPopUp(this);return false;");
           if (doAnexos) this.lnkAnexos.HRef = "vRegistroAnexos.aspx?AjusteId=" + ajusteid;
           if (doAnexos) this.lnkAnexos.Attributes.Add("onclick", "muestraPopUp(this);return false;");
           if (doComunicaciones) this.lnkComunicaciones.HRef="vRegistroComunicacion.aspx?AjusteId=" + ajusteid;
           if (doComunicaciones) this.lnkComunicaciones.Attributes.Add("onclick", "muestraPopUp(this);return false;");
           if (doGastos) this.lnkGastos.HRef = "vRegistrarGasto.aspx?AjusteId=" + ajusteid;
           if (doGastos) this.lnkGastos.Attributes.Add("onclick", "muestraPopUp(this);return false;");
       }
       else if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
       {
         doActividades = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORAACTIVIDADES");
         doAnexos = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORAANEXOS");
         doComunicaciones = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORACOMUNICACIONES");
         doGastos = GestorNotificacion.hasVisibilityPermissionBroker(GestorAjuste.dameAjuste(AjusteId).brokerId, GestorAjuste.dameAjuste(AjusteId).aseguradoraId, "V_BITACORAGASTOS");

           if (doActividades) this.lnkActividades.HRef = "vRegistroActividades.aspx?AjusteId=" + ajusteid;
           if (doActividades) this.lnkActividades.Attributes.Add("onclick", "muestraPopUp(this);return false;");
           if (doAnexos) this.lnkAnexos.HRef = "vRegistroAnexos.aspx?AjusteId=" + ajusteid;
           if (doAnexos) this.lnkAnexos.Attributes.Add("onclick", "muestraPopUp(this);return false;");
           if (doComunicaciones) this.lnkComunicaciones.HRef = "vRegistroComunicacion.aspx?AjusteId=" + ajusteid;
           if (doComunicaciones) this.lnkComunicaciones.Attributes.Add("onclick", "muestraPopUp(this);return false;");
           if (doGastos) this.lnkGastos.HRef = "vRegistrarGasto.aspx?AjusteId=" + ajusteid;
           if (doGastos) this.lnkGastos.Attributes.Add("onclick", "muestraPopUp(this);return false;");
       }
       else {

           this.lnkActividades.HRef = "vRegistroActividades.aspx?AjusteId=" + ajusteid;
           this.lnkActividades.Attributes.Add("onclick", "window.parent.muestraPopUp(this);return false;");
           this.lnkAnexos.HRef = "vRegistroAnexos.aspx?AjusteId=" + ajusteid;
           this.lnkAnexos.Attributes.Add("onclick", "window.parent.muestraPopUp(this);return false;");
           this.lnkComunicaciones.HRef = "vRegistroComunicacion.aspx?AjusteId=" + ajusteid;
           this.lnkComunicaciones.Attributes.Add("onclick", "window.parent.muestraPopUp(this);return false;");
           this.lnkGastos.HRef = "vRegistrarGasto.aspx?AjusteId=" + ajusteid;
           this.lnkGastos.Attributes.Add("onclick", "window.parent.muestraPopUp(this);return false;");


       }

    }
    private void cargaDataALosDivs()
    {

        dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter datosAjusteTA = new dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter();
        decimal AjusteId = Convert.ToDecimal(Request.QueryString["AjusteId"]);
        dsAjax.AjaxDatosCabeceraAjusteDataTable datosAjusteDT = datosAjusteTA.GetData(AjusteId);
        if (datosAjusteDT.Rows.Count > 0)
        {
            dsAjax.AjaxDatosCabeceraAjusteRow fila = (dsAjax.AjaxDatosCabeceraAjusteRow)datosAjusteDT.Rows[0];

            this.estadoAjuste.InnerHtml = ((fila.Status == null) ? " --- " : fila.Status.ToString());
            this.tipoAjuste.InnerHtml = "Tipo : " + ((fila.tajuste == null) ? " --- " : fila.tajuste.ToString());
            this.DiasEnAjuste.InnerHtml = "Días : " + ((fila.NroDias == null) ? " --- " : fila.NroDias.ToString() );

        }
        String htmlMessage = "";

        dsInformacionRelevanteTableAdapters.InformacionRelevanteTableAdapter infRevTA = new dsInformacionRelevanteTableAdapters.InformacionRelevanteTableAdapter();
        dsInformacionRelevante.InformacionRelevanteDataTable infRevDT = infRevTA.GetData(AjusteId);

        int contador = 0;
        foreach (dsInformacionRelevante.InformacionRelevanteRow filaInfo in infRevDT)
        {
            if (contador != 0)
            {
                htmlMessage += "<hr style=\"border:#003366 solid 1px; margin-bottom:5px;\"></hr>";
            }
            htmlMessage += "<p style=\"margin:3px; \"><strong>(" + filaInfo.fcrea.ToShortDateString() + ") " + filaInfo.titulo + "</strong></p>";
            htmlMessage += "<p style=\"margin-bottom:3px;margin-top:3px; margin-right:3px; margin-left:20px;   \">" + filaInfo.contenido + "</p>";
            contador++;
        }

        this.news_content.InnerHtml = htmlMessage;

    }
}
