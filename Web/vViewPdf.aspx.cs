
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using RGen.docs;

public partial class vViewPdf : System.Web.UI.Page
{
    protected decimal ajusteId;
    protected decimal informeId;
    protected decimal solicitudDocumentosId;
    protected string tipoInforme;

    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Request.QueryString["AjusteId"] == null)
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }

        if (Request.QueryString["AjusteId"] != null) this.ajusteId = decimal.Parse(Request.QueryString["AjusteId"]);
        if (Request.QueryString["InformeId"] != null) this.informeId = decimal.Parse(Request.QueryString["InformeId"]);
        if (Request.QueryString["SolDocId"] != null) this.solicitudDocumentosId = decimal.Parse(Request.QueryString["SolDocId"]);
        if (Request.QueryString["TI"] != null) this.tipoInforme = Request.QueryString["TI"];

        MemoryStream AuxStream;
        switch (tipoInforme)
        {
            case "NOW":
                AuxStream = Request.QueryString["SolDocId"] != null ? new MemoryStream(GetPdf.GetSolicitudDocumentosNow(ajusteId, solicitudDocumentosId, "Destino Temporal", "Cargo Temporal", DateTime.Today, "NroTemporal", 1,"Descripción Temporal" ,Server.MapPath(""))) : new MemoryStream(GetPdf.GetInformeNow(Convert.ToInt32(ajusteId), Server.MapPath("")));
                GetNOW(AuxStream);
                break;
            case "CA":
                AuxStream = new MemoryStream(GetPdf.GetConvenioAjusteNow(ajusteId, Server.MapPath("")));
                GetNOW(AuxStream);
                break;
            case "HR":
                AuxStream = new MemoryStream(GetPdf.GetHojaResumenNow(ajusteId, Server.MapPath("")));
                GetNOW(AuxStream);
                break;
            case "SD":
                GetFromFileSystem("SD-" + ajusteId.ToString() + "-" + solicitudDocumentosId.ToString() + ".pdf");
                break;
            default:
                GetFromDB(ajusteId, informeId);
                break;
        }
    }

    #region EsNuevo
    public bool esnuevo()
    {
        //if (tipoInforme == "Basico")
        //{
        //  dsReporteTableAdapters.TieneInformeBasicoTableAdapter dtinforme = new dsReporteTableAdapters.TieneInformeBasicoTableAdapter();
        //  DataTable informe = (DataTable)dtinforme.GetData(this.ajusteId);
        //  if (informe.Rows.Count > 0)
        //  {
        //    dsReporte.TieneInformeBasicoRow row = (dsReporte.TieneInformeBasicoRow)informe.Rows[0];
        //    this.nombre = Convert.ToString(row["nombre"]);
        //    return false;
        //  }
        //}
        //else if (tipoInforme == "Preliminar")
        //{
        //  dsReporteTableAdapters.TieneInformePreliminarTableAdapter dtinforme = new dsReporteTableAdapters.TieneInformePreliminarTableAdapter();
        //  DataTable informe = (DataTable)dtinforme.GetData(this.ajusteId);
        //  if (informe.Rows.Count > 0)
        //  {
        //    dsReporte.TieneInformePreliminarRow row = (dsReporte.TieneInformePreliminarRow)informe.Rows[0];
        //    this.nombre = Convert.ToString(row["nombre"]);
        //    return false;
        //  }
        //}

        return true;
    }
    #endregion

    #region GetFromDB
    private void GetFromDB(decimal ajusteId, decimal informeId)
    {
        /*SERVER PATH SOLO CON EL NOMBRE QUE OBTIENE DE LA BASE DE DATOS*/
        dsInformesTableAdapters.InformeListaTableAdapter informeAdapter = new dsInformesTableAdapters.InformeListaTableAdapter();
        dsInformes.InformeListaDataTable informeTable = (dsInformes.InformeListaDataTable)informeAdapter.GetDataInforme(ajusteId, informeId);
        dsInformes.InformeListaRow informeRow = (dsInformes.InformeListaRow)informeTable.Rows[0];

        GetFromFileSystem(informeRow.nombre);
    }
    #endregion

    #region GetFromFileSystem
    private void GetFromFileSystem(string fileName)
    {
        FileInfo archivo = new FileInfo(Server.MapPath("Informes") + "\\" + fileName);
        if (archivo.Exists)
        {
            Response.Clear();
            //Response.AddHeader("Content-disposition", "attachment; filename=\"" + archivo.Name + "\";");
            Response.ContentType = "application/pdf";
            Response.WriteFile(archivo.FullName);
            Response.End();
        }
    }
    #endregion

    #region GetNOW
    private void GetNOW(MemoryStream AuxStream)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/pdf";
        Response.BinaryWrite(AuxStream.ToArray());
        Response.End();
    }
    #endregion
}