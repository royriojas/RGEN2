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
using System.IO;

public partial class vVistaPrevia : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {

        string InformeURL = "InformesPlantillas/InformeDefault.aspx?AjusteId={0}&TI={1}&nc=" + DateTime.Now.Ticks.ToString();
        string HeaderInformeURL = "InformesPlantillas/HeaderInformeDefault.aspx?AjusteId={0}&TI={1}&nc=" + DateTime.Now.Ticks.ToString();

        String tipoInforme = Request.QueryString["TI"];




        decimal ajusteId = -1;
        try
        {
            ajusteId = Convert.ToDecimal(Request.QueryString["AjusteId"]);
        }
        catch (Exception ex)
        {
            LoggerFacade.Log(ex);
        }


        String codigoAseguradora = GestorAjuste.GetCodigoAseguradora(ajusteId);
        //if (String.IsNullOrEmpty(response)) 



        bool aseguradoraIsPacifico = (codigoAseguradora == "PACIFICO");
        bool aseguradoraIsRimac = (codigoAseguradora == "RIMAC");

        if (aseguradoraIsRimac)
        {
            HeaderInformeURL = "";
        }

        switch (tipoInforme)
        {

            case "IB":
                {
                    if (aseguradoraIsPacifico)
                    {
                        InformeURL = "InformesPlantillas/InformePacificoBasico.aspx?AjusteId={0}&TI={1}&nc=" + DateTime.Now.Ticks.ToString();
                    }

                    if (aseguradoraIsRimac)
                    {
                        InformeURL = "InformesPlantillas/InformeBasicoRimac.aspx?AjusteId={0}&TI={1}&nc=" +
                                     DateTime.Now.Ticks;

                    }
                    break;
                }
            case "IP":
                {
                    if (aseguradoraIsPacifico)
                    {
                        InformeURL = "InformesPlantillas/InformePacificoPreliminar.aspx?AjusteId={0}&TI={1}&nc=" + DateTime.Now.Ticks.ToString();
                    }
                    if (aseguradoraIsRimac)
                    {
                        InformeURL = "InformesPlantillas/InformePreliminarRimac.aspx?AjusteId={0}&TI={1}&nc=" +
                                     DateTime.Now.Ticks;

                    }
                    break;
                }
            case "IC":
                {
                    if (aseguradoraIsPacifico)
                    {
                        InformeURL = "InformesPlantillas/InformePacificoPreliminar.aspx?AjusteId={0}&TI={1}&nc=" + DateTime.Now.Ticks.ToString();
                    }
                    if (aseguradoraIsRimac)
                    {
                        InformeURL = "InformesPlantillas/InformePreliminarRimac.aspx?AjusteId={0}&TI={1}&nc=" +
                                     DateTime.Now.Ticks;

                    }
                    break;
                }
            case "IF":
                {
                    if (aseguradoraIsPacifico)
                    {
                        InformeURL = "InformesPlantillas/InformePacificoFinal.aspx?AjusteId={0}&TI={1}&nc=" + DateTime.Now.Ticks.ToString();
                    }
                    if (aseguradoraIsRimac)
                    {
                        InformeURL = "InformesPlantillas/InformeFinalRimac.aspx?AjusteId={0}&TI={1}&nc=" +
                                     DateTime.Now.Ticks;

                    }
                }
                break;
        }

        InformeURL = String.Format(InformeURL, Request.QueryString["AjusteId"], tipoInforme);
        HeaderInformeURL = String.Format(HeaderInformeURL, Request.QueryString["AjusteId"], tipoInforme);



        //if (aseguradoraIsPacifico)
        //{
        //  this.UcLoadCss1.PathToFileToLoad = "InformesPlantillas/inf.css";
        //}
        //else
        //{
        //  this.UcLoadCss1.PathToFileToLoad = "InformesPlantillas/inf.css";

        //}
        UcLoadCss1.PathToFileToLoad = "InformesPlantillas/inf.css?nc=" + DateTime.Now;
        //if (aseguradoraIsPacifico)

        if (aseguradoraIsRimac)
            UcLoadCss1.PathToFileToLoad = "InformesPlantillas/infRimac.css?nc=" + DateTime.Now;

        ltlHeader.Text = string.Empty;
        if (!String.IsNullOrEmpty(HeaderInformeURL))
        {
            StringWriter sw = new StringWriter();
            Server.Execute(HeaderInformeURL, sw);
            ltlHeader.Text = sw.ToString();
        }

        StringWriter sw2 = new StringWriter();
        Server.Execute(InformeURL, sw2);
        ltlBody.Text = sw2.ToString();
        //Response.Redirect(InformeURL);
    }
}
