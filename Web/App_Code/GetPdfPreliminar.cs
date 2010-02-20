using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.IO;

/// <summary>
/// Summary description for GetPdfPreliminar
/// </summary>
namespace RGen.docs
{
  public class GetPdfPreliminar
  {
    public GetPdfPreliminar()
    {
      //
      // TODO: Add constructor logic here
      //
    }


    public static byte[] GetInformePreliminar(int ajusteId, string ruta)
    {
      // Instancia del reporte

      String reportPath = ruta + "docs\\crInformePreliminar.rpt";

      //MODIFICAR CON LA AGREGACION DE LA EXTENCION DEL PDF
      String nombre = "PASA-IP-" + ajusteId + "-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
      ReportDocument informeBasico = new ReportDocument();
      informeBasico.Load(reportPath);

      dsReporteTableAdapters.InformeBasicoImagenesTableAdapter dtImagenes = new dsReporteTableAdapters.InformeBasicoImagenesTableAdapter();
      DataTable imagenes = (DataTable)dtImagenes.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBImagen.rpt").SetDataSource(imagenes);

      dsReporteTableAdapters.InformeBasicoDocumentacionSolicitadaTableAdapter dtdocumentacion = new dsReporteTableAdapters.InformeBasicoDocumentacionSolicitadaTableAdapter();
      DataTable documentacion = (DataTable)dtdocumentacion.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBDocumentacion.rpt").SetDataSource(documentacion);

      dsReporteTableAdapters.InformeBasicoReclamoTableAdapter dtreclamo = new dsReporteTableAdapters.InformeBasicoReclamoTableAdapter();
      DataTable reclamo = (DataTable)dtreclamo.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBReclamo.rpt").SetDataSource(reclamo);

      dsReporteTableAdapters.InformeBasicoInspeccionTableAdapter dtinspeccion = new dsReporteTableAdapters.InformeBasicoInspeccionTableAdapter();
      DataTable inspeccion = (DataTable)dtinspeccion.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBInspeccion.rpt").SetDataSource(inspeccion);

      dsReporteTableAdapters.InformeBasicoOcurrenciaDetalleTableAdapter dtdetalleocurrencia = new dsReporteTableAdapters.InformeBasicoOcurrenciaDetalleTableAdapter();
      DataTable detalleocurrencia = (DataTable)dtdetalleocurrencia.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBDetalleOcurrencia.rpt").SetDataSource(detalleocurrencia);

      dsReporteTableAdapters.InformeBasicoOcurrenciaCabeceraTableAdapter dtocurrencia = new dsReporteTableAdapters.InformeBasicoOcurrenciaCabeceraTableAdapter();
      DataTable ocurrencia = (DataTable)dtocurrencia.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBOcurrencia.rpt").SetDataSource(ocurrencia);



      dsReporteTableAdapters.InformeBasicoClausulasTableAdapter dtclausulas = new dsReporteTableAdapters.InformeBasicoClausulasTableAdapter();
      DataTable clausulas = (DataTable)dtclausulas.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBClausulas.rpt").SetDataSource(clausulas);


      dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter dtdeducibles = new dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter();
      DataTable deducibles = (DataTable)dtdeducibles.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBDeducibles.rpt").SetDataSource(deducibles);


      dsReporteTableAdapters.InformeBasicoPolizaDetalleTableAdapter dtdetallepoliza = new dsReporteTableAdapters.InformeBasicoPolizaDetalleTableAdapter();
      DataTable detallePoliza = (DataTable)dtdetallepoliza.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBDetallePoliza.rpt").SetDataSource(detallePoliza);



      dsReporteTableAdapters.InformeBasicoPolizaTableAdapter dtPoliza = new dsReporteTableAdapters.InformeBasicoPolizaTableAdapter();
      DataTable poliza = (DataTable)dtPoliza.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBPoliza.rpt").SetDataSource(poliza);



      dsReporteTableAdapters.InformeBasicoFechaAvisoCoordinacionTableAdapter dtfechacoordinacion = new dsReporteTableAdapters.InformeBasicoFechaAvisoCoordinacionTableAdapter();
      DataTable fechaCoordinacion = (DataTable)dtfechacoordinacion.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBFechaAviso.rpt").SetDataSource(fechaCoordinacion);



      dsReporteTableAdapters.InformeBasicoGeneralesTableAdapter dtgenerales = new dsReporteTableAdapters.InformeBasicoGeneralesTableAdapter();
      DataTable datosgenerales = (DataTable)dtgenerales.GetData(ajusteId);
      informeBasico.OpenSubreport("crIBGenerales.rpt").SetDataSource(datosgenerales);

      dsReporteTableAdapters.InformeBasicoCabeceraTableAdapter cabeceraAdapter = new dsReporteTableAdapters.InformeBasicoCabeceraTableAdapter();
      informeBasico.SetDataSource((DataTable)cabeceraAdapter.GetData(ajusteId));

      //informeBasico.FileName = "InformeBasico" + ajusteId + ".pdf";
      ExportOptions informeOpcion = new ExportOptions();
      informeOpcion.ExportFormatType = ExportFormatType.PortableDocFormat;
      informeOpcion.ExportDestinationType = ExportDestinationType.DiskFile;
      DiskFileDestinationOptions destino = new DiskFileDestinationOptions();

      nombre = "InformeBasicoAYP.pdf";
      destino.DiskFileName = ruta + "informes\\" + nombre;

      informeOpcion.ExportDestinationOptions = destino;

      informeBasico.Export(informeOpcion);

      //dsReporteTableAdapters.InformeBasicoSelectTableAdapter tainforme = new dsReporteTableAdapters.InformeBasicoSelectTableAdapter();
      //tainforme.Insert(ajusteId, nombre, ruta + "informes\\");

      MemoryStream oStream;
      oStream = (MemoryStream)informeBasico.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
      return oStream.ToArray();
    }
  }
}