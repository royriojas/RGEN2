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
using RGen.Utiles;

public partial class vCreaSolicitudDocumentos : System.Web.UI.Page
{
    private FileInfo archivo;
    protected void Page_Load(object sender, EventArgs e)
    {
        
            this.ImprimirSolicitudDatos.Disabled = false;
            this.verSolicitud.Visible = false;
            //this.DivResultado.Visible = false;

            switch (Request.QueryString["tipo"])
            {
                case "Solicitud": this.myTable.Style.Value = "display:none";
                    break;
                case "Agradecimiento": this.myTable.Style.Value = "display:block";
                    //  this.txtNumRecordatorio.Enabled = false;
                    this.txtNumRecordatorio.CssClass = "deshabilitado";
                    this.txtNumRecordatorio.ReadOnly = true;
                    break;
                case "Recordatorio": this.myTable.Style.Value = "display:block";
                    this.txtNumRecordatorio.Enabled = true;
                    this.txtNumCartaAsegurado.ReadOnly = true;
                    this.txtNumCartaAsegurado.CssClass = "deshabilitado";
                    break;
            }
          
            if (!IsPostBack)
            {
                this.txtDestinatario.Text = RGen.GestorAjuste.getNombreAsegurado(Convert.ToDecimal(Request.QueryString["AjusteId"]));
                this.txtCorreoAseguradora.Text = RGen.GestorAjuste.dameContactoAseguradora(Convert.ToDecimal(Request.QueryString["AjusteId"])).Email;
                this.txtCorreoBroker.Text = RGen.GestorAjuste.dameContactoBroker(Convert.ToDecimal(Request.QueryString["AjusteId"])).Email;
                this.txtCorreoOtros.Text = RGen.GestorAjuste.dameContactoAsegurado(Convert.ToDecimal(Request.QueryString["AjusteId"])).Email;
            }
        
    }
    protected void btnCrear_Click(object sender, EventArgs e)
    {
        this.crearSolicitud();
    }
    private void crearSolicitud()
    {

        //llamar al metodo estático para mostrar la solicitud impresa
        int numero = 0;
        try {
            numero = int.Parse((this.txtNumRecordatorio.Text));
        }
        catch (Exception ex) {
            numero = 0;
        }

        RGen.docs.GetPdf.GenerarSolicitudDocumentos(Convert.ToDecimal(Request.QueryString["AjusteId"]), Convert.ToDecimal(Request.QueryString["solicitudDocumentosId"]), this.txtDestinatario.Text,this.txtCargo.Text, DateTime.Today, this.txtNumCartaAsegurado.Text, numero,this.txtDescripcion.Text, Server.MapPath(""));

        //enviar el mail

        if (this.chkDestinatarioAseguradora.Checked ||
                    this.chkDestinatarioBroker.Checked ||
                    this.chkDestinatarioOtros.Checked)
        {
            string NombreFile = "SD-" + Request.QueryString["AjusteId"] + "-" + Request.QueryString["solicitudDocumentosId"] + ".pdf";
            archivo = new FileInfo(Server.MapPath("Informes") + "\\" + NombreFile);
         
            String nombreFileTemporal = Server.MapPath("Informes") + "\\SD-" + Request.QueryString["NumAjusteSolicitud"] + ".pdf";
            FileInfo archivoTemp = new FileInfo(nombreFileTemporal);
          
            if (archivo.Exists)
            {
                if (archivoTemp.Exists)
                {
                    File.Delete(nombreFileTemporal);
                }
                File.Copy(archivo.FullName, nombreFileTemporal);

            }

            archivo = new FileInfo(nombreFileTemporal);

         



            if (archivo.Exists)
            {
                RGenMailer myMailer = new RGenMailer();
                ArrayList to = new ArrayList();
                if ((this.txtCorreoAseguradora.Text != "") && (this.chkDestinatarioAseguradora.Checked))
                {
                    String[] ParaArreglo = this.txtCorreoAseguradora.Text.Split(new char[] { ',' });

                    to.AddRange(ParaArreglo);
                    //myMailer.enviaMensajeConAttachment                
                }
                if ((this.txtCorreoBroker.Text != "") && (this.chkDestinatarioBroker.Checked))
                {
                    String[] ParaArreglo = this.txtCorreoBroker.Text.Split(new char[] { ',' });

                    to.AddRange(ParaArreglo);
                    //myMailer.enviaMensajeConAttachment                
                }
                if ((this.txtCorreoOtros.Text != "") && (this.chkDestinatarioOtros.Checked))
                {
                    String[] ParaArreglo = this.txtCorreoOtros.Text.Split(new char[] { ',' });

                    to.AddRange(ParaArreglo);
                    //myMailer.enviaMensajeConAttachment                
                }

                //TODO: Revisar los permisos para realizar los envios pertinentes
                myMailer.enviaMensajeConAttachment(
                    to,
                    "AJUSTE N°" + RGen.GestorAjuste.dameNumeroAjuste(Convert.ToDecimal(Request.QueryString["AjusteId"])),
                    "<strong>Como documento Adjunto se ha Enviado una copia de la Solicitud de Documentos</strong>",
                    archivo.FullName);

                File.Delete(nombreFileTemporal);
            }
        }


        this.DivResultado.Attributes.CssStyle.Add(HtmlTextWriterStyle.Display, "Block");
        this.lblResutado.InnerHtml = "<strong>La Solicitud ha sido creada</strong> &nbsp;&nbsp;";
        //this.lblResutado.InnerHtml += "<button style=\"width:80px;\" id=\"verSolicitud\" class=\"FormButton\" onclick=\"javascript:verSolicitud();\">Ver Solicitud</button>";
        this.verSolicitud.Attributes.Add("onclick", "ShowReport('vViewPdf.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&SolDocId=" + Request.QueryString["solicitudDocumentosId"] + "&TI=SD');");



        this.verSolicitud.Visible = true;
        this.imgLoading.Visible = false;
        this.ImprimirSolicitudDatos.Visible = false;
    }
   
}
