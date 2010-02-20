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

public partial class RgenControl : System.Web.UI.UserControl
{
    public string ajusteid;
    protected void Page_Load(object sender, EventArgs e)
    {
        ajusteid = Request.QueryString["AjusteId"]; 



        // Ene ste punto se debe validar el acceso del usuario al informe
        dsInformesTableAdapters.InformeListaTableAdapter informeAdapter = new dsInformesTableAdapters.InformeListaTableAdapter();

        // Informe basico
        decimal informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "B");
        if (informeId != 0) this.lnkInformeBasico.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString()+");";
        
        // Informe preliminar
        informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "P");
        if (informeId != 0) this.lnkInformePreliminar.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString() + ");";

        // Informe complementario
        informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "C");
        if (informeId != 0) this.lnkinformesComplementarios.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString() + ");";

        // Informe final
        informeId = (decimal)informeAdapter.InformeTipo(decimal.Parse(ajusteid), "F");
        if (informeId != 0) this.lnkInformeFinal.HRef = "javascript:VerInforme(" + ajusteid + "," + informeId.ToString() + ");";

        //this.news_content.InnerHtml = "scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
        cargaDataALosDivs();
        cargaLinks();
    }
    private void cargaLinks()
    {
       RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
       if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
       {
            this.lnkActividades.HRef = "vRegistroActividades.aspx?AjusteId=" + ajusteid;
            this.lnkActividades.Attributes.Add("onclick", "muestraPopUp(this);return false;");
            this.lnkAnexos.HRef = "vRegistroAnexos.aspx?AjusteId=" + ajusteid;
            this.lnkAnexos.Attributes.Add("onclick", "muestraPopUp(this);return false;");
            this.lnkComunicaciones.HRef="vRegistroComunicacion.aspx?AjusteId=" + ajusteid;
            this.lnkComunicaciones.Attributes.Add("onclick", "muestraPopUp(this);return false;");
            this.lnkGastos.HRef = "vRegistrarGasto.aspx?AjusteId=" + ajusteid;
            this.lnkGastos.Attributes.Add("onclick", "muestraPopUp(this);return false;");
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

            this.estadoAjuste.InnerHtml = ((fila.Status == null) ? " --- " : fila.Status);
            this.tipoAjuste.InnerHtml = "Tipo : " + ((fila.tajuste == null) ? " --- " : fila.tajuste);

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
