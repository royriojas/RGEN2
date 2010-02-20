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
using RGen;

public partial class vEnviaMail : System.Web.UI.Page
{
    public String urlAnterior;
    public decimal ajusteId;
    public decimal informeId;
    private FileInfo archivo;
    private Contacto contactoAsegurado=null;
    private Contacto contactoAseguradora=null;
    private Contacto contactoBroker=null;

    protected void Page_Load(object sender, EventArgs e)
    {
        this.ajusteId = decimal.Parse(Request.QueryString["AjusteId"]);
        this.informeId = decimal.Parse(Request.QueryString["InformeId"]);

        String nombreInforme = this.nombreDelInforme(ajusteId, informeId);
        archivo = new FileInfo(Server.MapPath("Informes") + "\\" + nombreInforme);

        if (archivo.Exists)
        {
            this.txtNombreDelInforme.Text = archivo.Name;
        }
        else
        {
            Response.Redirect("vMuestraMensaje.aspx?mensaje=No se puede enviar el Informe contacte con Soporte, Error: El Archivo no existe");
        }

        if (!IsPostBack)
        {
            contactoAsegurado=GestorAjuste.dameContactoAsegurado(Convert.ToDecimal(ajusteId));
            contactoAseguradora=GestorAjuste.dameContactoAseguradora(Convert.ToDecimal(ajusteId));
            contactoBroker=GestorAjuste.dameContactoBroker(Convert.ToDecimal(ajusteId));

            this.txtPara.Text = contactoAsegurado.Email + ","
                                + contactoAseguradora.Email + ","
                                + contactoBroker.Email;


            this.txtAsunto.Text = "En referencia al Ajuste : " + RGen.GestorAjuste.dameNumeroAjuste(Convert.ToDecimal(ajusteId));
            urlAnterior = Request.QueryString["UrlAnterior"];

            this.btnVolver.PostBackUrl = urlAnterior;
            
            /*SERVER PATH SOLO CON EL NOMBRE QUE OBTIENE DE LA BASE DE DATOS*/
          
        }

    }

    private string nombreDelInforme(decimal ajusteId, decimal informeId)
    {
        dsInformesTableAdapters.InformeListaTableAdapter informeAdapter = new dsInformesTableAdapters.InformeListaTableAdapter();
        dsInformes.InformeListaDataTable informeTable = (dsInformes.InformeListaDataTable)informeAdapter.GetDataInforme(ajusteId, informeId);
        dsInformes.InformeListaRow informeRow = (dsInformes.InformeListaRow)informeTable.Rows[0];
        return informeRow.nombre;
    }


    private void enviar()
    {
        if (archivo.Exists)
        {
            try
            {
                RGenMailer myMailer = new RGenMailer();
                ArrayList to = new ArrayList();
                string enviadoA = null;
                contactoAseguradora = GestorAjuste.dameContactoAseguradora(Convert.ToDecimal(ajusteId));
                contactoBroker = GestorAjuste.dameContactoBroker(Convert.ToDecimal(ajusteId));

                if (contactoAseguradora != null) enviadoA = contactoAseguradora.Nombre;
                if (contactoBroker != null) enviadoA += "," + contactoBroker.Nombre;                
                
                if (this.txtPara.Text != "")
                {
                    odsActualizaEnvios.UpdateParameters.Add("ajusteId",TypeCode.Decimal,ajusteId.ToString());
                    odsActualizaEnvios.UpdateParameters.Add("informeId", TypeCode.Decimal, informeId.ToString());
                    odsActualizaEnvios.UpdateParameters.Add("enviadoA", TypeCode.String, enviadoA.ToString());
                    odsActualizaEnvios.Update();

                    String[] ParaArreglo = this.txtPara.Text.Split(new char[] { ',' });

                    to.AddRange(ParaArreglo);
                    //myMailer.enviaMensajeConAttachment                
                }

                myMailer.enviaMensajeConAttachment(to, this.txtAsunto.Text, this.txtContentArea.Text, archivo.FullName);

            }
            catch (Exception ex)
            {
                Response.Redirect("vMuestraMensaje.aspx?mensaje=No se puede enviar el Informe contacte con Soporte, Error: " + ex.Message);
            }
            this.txtAsunto.Text = "";
            this.txtContentArea.Text = "";
            this.txtPara.Text = "";
            this.txtNombreDelInforme.Text = "";


        }
    }


    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        this.enviar();
        this.ClientScript.RegisterStartupScript(this.GetType(), "closeScript", "try { window.parent.hidePopWin(false); } catch (e) {alert(e.message); }", true);
                                                                                       
    }
}
