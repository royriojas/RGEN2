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
using R3M.Common;

/// <summary>
/// Summary description for GetPdf
/// </summary>

namespace RGen.docs
{
    public class GetPdf
    {
        public GetPdf()
        {
            //
            // TODO: Add constructor logic here
            //
        }



        public static void GenerarInforme(decimal ajusteId, string tipoInforme, bool estadoValidacion, bool observado, string usuario, string ApplicationPath)
        {
            //ReportDocument informeBasico = getInforme(ajusteId, tipoInforme, ApplicationPath);

            Byte[] informeEnBytes = GetInformeInBytes(ajusteId, tipoInforme);


            tipoInforme = GetTipoInforme(tipoInforme);

            //MODIFICAR CON LA AGREGACION DE LA EXTENCION DEL PDF
            decimal estadoACambiar = -1;
            string nombreInforme = "PASA-IB-" + ajusteId + "-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
            switch (tipoInforme)
            {

                case "B":
                    {
                        nombreInforme = "PASA-IB-" + ajusteId + "-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
                        estadoACambiar = 16;
                        break;
                    }
                case "P":
                    {
                        nombreInforme = "PASA-IP-" + ajusteId + "-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
                        estadoACambiar = 17;
                        break;
                    }
                case "C":
                    {
                        nombreInforme = "PASA-IC-" + ajusteId + "-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
                        estadoACambiar = 18;
                        break;
                    }
                case "F":
                    {
                        nombreInforme = "PASA-IF-" + ajusteId + "-" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + DateTime.Now.Millisecond + ".pdf";
                        estadoACambiar = 20;
                        break;
                    }
            }


            //saveToFileSytem(informeBasico, nombreInforme, ApplicationPath);
            SaveInformeToFileSystem(informeEnBytes, nombreInforme, ApplicationPath);
            dsReporteTableAdapters.InformeBasicoSelectTableAdapter tainforme = new dsReporteTableAdapters.InformeBasicoSelectTableAdapter();
            tainforme.Insert(ajusteId, nombreInforme, ApplicationPath + "\\informes\\" + nombreInforme, tipoInforme, estadoValidacion, observado, usuario);


            if ((estadoACambiar != -1) && (estadoValidacion))
            {
                dsEstadoTableAdapters.administraEstadosTableAdapter ta = new dsEstadoTableAdapters.administraEstadosTableAdapter();
                ta.cambiaEstadoAjuste(DateTime.Today, ajusteId, estadoACambiar, "SYSTEM");
            }

            if (estadoValidacion) enviaNotificacionInformes(tipoInforme, ajusteId, ApplicationPath + "\\informes\\");

            if (estadoValidacion) enviaNotificacionDias(tipoInforme, ajusteId);
        }

        private static string GetTipoInforme(string tipoInforme)
        {
            switch (tipoInforme)
            {

                case "IB":
                    {
                        tipoInforme = "B";
                        break;
                    }
                case "IP":
                    {
                        tipoInforme = "P";
                        break;
                    }
                case "IC":
                    {
                        tipoInforme = "C";

                        break;
                    }
                case "IF":
                    {
                        tipoInforme = "F";
                        break;
                    }
            }
            return tipoInforme;
        }

        private static void SaveInformeToFileSystem(byte[] informeEnBytes, string nombreInforme, String applicationPath)
        {
            //ExportOptions informeOpcion = new ExportOptions();
            //informeOpcion.ExportFormatType = ExportFormatType.PortableDocFormat;
            //informeOpcion.ExportDestinationType = ExportDestinationType.DiskFile;
            //DiskFileDestinationOptions destino = new DiskFileDestinationOptions();

            //destino.DiskFileName = applicationPath + "\\informes\\" + nombreInforme;

            //informeOpcion.ExportDestinationOptions = destino;

            //informeBasico.Export(informeOpcion);

            File.WriteAllBytes(applicationPath + "\\informes\\" + nombreInforme, informeEnBytes);

        }

        private static byte[] GetInformeInBytes(decimal ajusteId, string tipoInforme)
        {
            Byte[] informe;
            string InformeURL = "InformesPlantillas/InformeDefault.aspx?AjusteId={0}&TI={1}&nc={2}";
            string HeaderInformeURL = "InformesPlantillas/HeaderInformeDefault.aspx?AjusteId={0}&TI={1}&nc={2}";

            string tInforme = string.Empty;

            String codigoAseguradora = GestorAjuste.GetCodigoAseguradora(ajusteId);

            bool pacifico = (codigoAseguradora == "PACIFICO");
            bool rimac = (codigoAseguradora == "RIMAC");

            if (rimac)
            {
                HeaderInformeURL = null;
            }

            tipoInforme = GetTipoInforme(tipoInforme);


            switch (tipoInforme)
            {

                case "B":
                    {
                        if (pacifico)
                        {
                            InformeURL = "InformesPlantillas/InformePacificoBasico.aspx?AjusteId={0}&TI={1}&nc={2}";

                        }
                        if (rimac)
                        {
                            InformeURL = "InformesPlantillas/InformeBasicoRimac.aspx?AjusteId={0}&TI={1}&nc={2}";
                        }
                        tInforme = "IB";
                        //informe = Util.GetPdf(Util.ResolveURL(String.Format(InformeURL, ajusteId, "IB")), Util.ResolveURL(String.Format(HeaderInformeURL, ajusteId, "IB")));
                        break;
                    }
                case "P":
                    {
                        if (pacifico)
                        {
                            InformeURL = "InformesPlantillas/InformePacificoPreliminar.aspx?AjusteId={0}&TI={1}&nc={2}";
                        }
                        if (rimac)
                        {
                            InformeURL = "InformesPlantillas/InformePreliminarRimac.aspx?AjusteId={0}&TI={1}&nc={2}";
                        }
                        //informe = Util.GetPdf(Util.ResolveURL(String.Format(InformeURL, ajusteId, "IP")), Util.ResolveURL(String.Format(HeaderInformeURL, ajusteId, "IP")));
                        tInforme = "IP";
                        break;
                    }
                case "C":
                    {
                        if (pacifico)
                        {
                            InformeURL = "InformesPlantillas/InformePacificoPreliminar.aspx?AjusteId={0}&TI={1}&nc={2}";
                        }
                        //informe = Util.GetPdf(Util.ResolveURL(String.Format(InformeURL, ajusteId, "IC")), Util.ResolveURL(String.Format(HeaderInformeURL, ajusteId, "IC")));
                        tInforme = "IC";
                        break;
                    }
                case "F":
                    {
                        if (pacifico)
                        {
                            InformeURL = "InformesPlantillas/InformePacificoFinal.aspx?AjusteId={0}&TI={1}&nc={2}";
                        }
                        tInforme = "IF";

                    }
                    break;
            }

            informe = !string.IsNullOrEmpty(HeaderInformeURL)
                          ? Util.GetPdf(
                                Util.ResolveURL(String.Format(InformeURL, ajusteId, tInforme, DateTime.Now.Ticks)),
                                Util.ResolveURL(String.Format(HeaderInformeURL, ajusteId, tInforme)))
                          : Util.GetPdf(
                                Util.ResolveURL(String.Format(InformeURL, ajusteId, tInforme, DateTime.Now.Ticks)));
            return informe;

        }



        private static void enviaNotificacionInformes(string tipoInforme, decimal AjusteId, String path)
        {
            String nombreArchivo = GestorNotificacion.getFromDB(AjusteId, tipoInforme);
            path = path + nombreArchivo;
            String Cuerpo = "";
            String mensaje = "";
            String asunto = "";
            String codigo = "";
            String codigoGenerado = "";
            String codigoACancelar = "";
            tipoInforme = GetTipoInforme(tipoInforme);
            switch (tipoInforme)
            {
                case "B":
                    {
                        codigo = "N_INFORMEBASICO";
                        codigoGenerado = "informe_basico_" + AjusteId.ToString();
                        asunto = "Notificación de culminación del INFORME BASICO";
                        mensaje = "Se notifica que ha concluido el INFORME BASICO";
                        codigoACancelar = "dias_informe_basico_" + AjusteId.ToString();

                        break;
                    }
                case "P":
                    {
                        codigoGenerado = "informe_preliminar_" + AjusteId.ToString();
                        codigo = "N_INFORMEPRELIMINAR";
                        asunto = "Notificación de culminación del INFORME PRELIMINAR";
                        mensaje = "Se notifica que ha concluido el INFORME PRELIMINAR";
                        codigoACancelar = "dias_informe_preliminar_" + AjusteId.ToString();

                        break;
                    }
                case "C":
                    {
                        codigoGenerado = "informe_complementario_" + AjusteId.ToString();
                        codigo = "N_INFORMECOMPLEMENTARIO";
                        asunto = "Notificación de culminación del INFORME COMPLEMENTARIO";
                        mensaje = "Se notifica que ha concluido el INFORME COMPLEMENTARIO";
                        codigoACancelar = "dias_primer_informe_complementario_" + AjusteId.ToString();

                        break;
                    }
                case "F":
                    {
                        codigoGenerado = "informe_final_" + AjusteId.ToString();
                        codigo = "N_INFORMEFINAL";
                        asunto = "Notificación de culminación del INFORME FINAL";
                        mensaje = "Se notifica que ha concluido el INFORME FINAL";

                        if (GestorAjuste.dameTipoAjuste(AjusteId) == 2)
                            codigoACancelar = "dias_informe_final_rapido_" + AjusteId.ToString();

                        break;
                    }
            }

            Cuerpo = GestorNotificacion.armaCuerpo(AjusteId, HttpContext.Current.Server.MapPath("Conf/plantillaNotificacion.html"), mensaje);

            GestorNotificacion.notificarInformes(AjusteId, codigoGenerado, codigo, asunto, Cuerpo, DateTime.Now, path);

            GestorNotificacion.cancelarMailPeriodico(codigoACancelar);

        }

        private static void enviaNotificacionDias(string tipoInforme, decimal AjusteId)
        {
            String Cuerpo = "";
            String mensaje = "";
            String asunto = "";
            String codigoGenerado = "";
            decimal diasAPartir = 0;

            RGen.ControlDiasAseguradora control = RGen.GestorAjuste.dameControlAseguradora(RGen.GestorAjuste.dameAjuste(AjusteId).aseguradoraId);
            tipoInforme = GetTipoInforme(tipoInforme);
            if (control != null)
            {
                switch (tipoInforme)
                {
                    case "B":
                        {
                            codigoGenerado = "dias_informe_preliminar_" + AjusteId.ToString();
                            asunto = "Notificación de cumplimiento del plazo para el INFORME PRELIMINAR";
                            mensaje = "Se notifica que se ha cumplido el plazo de entrega del INFORME PRELIMINAR";
                            diasAPartir = control.DiasIP;
                            Cuerpo = GestorNotificacion.armaCuerpo(AjusteId, HttpContext.Current.Server.MapPath("Conf/plantillaNotificacion.html"), mensaje);

                            GestorNotificacion.sendMailPeriodicoAjustador(AjusteId, codigoGenerado, asunto, Cuerpo, null, diasAPartir);

                            break;
                        }
                    case "P":
                        {
                            codigoGenerado = "dias_primer_informe_complementario_" + AjusteId.ToString();
                            asunto = "Notificación de cumplimiento del plazo para el PRIMER INFORME COMPLEMENTARIO";
                            mensaje = "Se notifica que se ha cumplido el plazo de entrega del PRIMER INFORME COMPLEMENTARIO";
                            diasAPartir = control.DiasIC;
                            Cuerpo = GestorNotificacion.armaCuerpo(AjusteId, HttpContext.Current.Server.MapPath("Conf/plantillaNotificacion.html"), mensaje);

                            GestorNotificacion.sendMailPeriodicoAjustador(AjusteId, codigoGenerado, asunto, Cuerpo, null, diasAPartir);

                            break;
                        }

                }
            }

        }

        public static void GenerarSolicitudDocumentos(decimal ajusteId, decimal solicitudDocumentosId, string nombreDestinatario, string cargoDestinatario, DateTime fechaRemision, string numeroCarta, int numeroRecordatorio, string descripcion, string ApplicationPath)
        {
            ReportDocument solicitudDocumentos = getSolicitudDocumentos(ajusteId, solicitudDocumentosId, nombreDestinatario, cargoDestinatario, fechaRemision, numeroCarta, numeroRecordatorio, descripcion, ApplicationPath);

            string nombreInforme = "SD-" + ajusteId.ToString() + "-" + solicitudDocumentosId.ToString() + ".pdf";

            saveToFileSytem(solicitudDocumentos, nombreInforme, ApplicationPath);
        }

        private static void saveToFileSytem(ReportDocument informeBasico, string nombreInforme, string ApplicationPath)
        {
            ExportOptions informeOpcion = new ExportOptions();
            informeOpcion.ExportFormatType = ExportFormatType.PortableDocFormat;
            informeOpcion.ExportDestinationType = ExportDestinationType.DiskFile;
            DiskFileDestinationOptions destino = new DiskFileDestinationOptions();

            destino.DiskFileName = ApplicationPath + "\\informes\\" + nombreInforme;

            informeOpcion.ExportDestinationOptions = destino;

            informeBasico.Export(informeOpcion);
        }

        public static byte[] GetInformeNow(int ajusteId, string ApplicationPath)
        {
            ReportDocument informeBasico = getInforme(ajusteId, "NOW", ApplicationPath);

            MemoryStream oStream;
            oStream = (MemoryStream)informeBasico.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            return oStream.ToArray();
        }

        public static byte[] GetConvenioAjusteNow(decimal ajusteId, string ApplicationPath)
        {
            ReportDocument convenioAjuste = getConvenioAjuste(ajusteId, ApplicationPath);
            saveToFileSytem(convenioAjuste, "CA-" + ajusteId.ToString() + ".pdf", ApplicationPath);

            MemoryStream oStream;
            oStream = (MemoryStream)convenioAjuste.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            return oStream.ToArray();

        }

        public static byte[] GetHojaResumenNow(decimal ajusteId, string ApplicationPath)
        {
            ReportDocument hojaResumen = getHojaResumen(ajusteId, ApplicationPath);

            MemoryStream oStream;
            oStream = (MemoryStream)hojaResumen.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            return oStream.ToArray();
        }

        public static byte[] GetSolicitudDocumentosNow(decimal ajusteId, decimal solicitudDocumentosId, string nombreDestinatario, string cargoDestinatario, DateTime fechaRemision, string numeroCarta, int numeroRecordatorio, string descripcion, string ApplicationPath)
        {
            ReportDocument solicitudDocumentos = getSolicitudDocumentos(ajusteId, solicitudDocumentosId, nombreDestinatario, cargoDestinatario, fechaRemision, numeroCarta, numeroRecordatorio, descripcion, ApplicationPath);

            MemoryStream oStream;
            oStream = (MemoryStream)solicitudDocumentos.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            return oStream.ToArray();
        }

        private static ReportDocument getInforme(decimal ajusteId, string tipoInforme, string ApplicationPath)
        {
            bool tieneSeccionesAdicionales = true;
            bool tieneSeccionesFinales = false;
            string tituloInforme = "INFORME BÁSICO";
            string tipoMonto = "RESERVA NETA";
            decimal montoIndemnizacion = 0;
            tipoInforme = GetTipoInforme(tipoInforme);
            switch (tipoInforme)
            {

                case "B":
                    {
                        tieneSeccionesAdicionales = false;
                        break;
                    }
                case "P":
                    {
                        tieneSeccionesAdicionales = true;
                        tituloInforme = "INFORME PRELIMINAR";
                        break;
                    }
                case "C":
                    {
                        tieneSeccionesAdicionales = true;
                        tituloInforme = "INFORME COMPLEMENTARIO";
                        break;
                    }
                case "F":
                    {
                        tieneSeccionesAdicionales = true;
                        tieneSeccionesFinales = true;

                        if (GestorAjuste.dameTipoAjuste(ajusteId) != 2)
                        {
                            tituloInforme = "INFORME FINAL";
                        }
                        else
                        {
                            tituloInforme = "INFORME FINAL RÁPIDO";
                        }

                        tipoMonto = "INDEMNIZACIÓN";
                        montoIndemnizacion = GestorAjuste.dameTotalIndemnizacion(ajusteId);
                        break;
                    }
            }

            // Instancia del reporte
            String reportPath = ApplicationPath + "\\docs\\crInformeBasico.rpt";

            ReportDocument informeBasico = new ReportDocument();
            informeBasico.Load(reportPath);

            dsReporteTableAdapters.InformeBasicoImagenesTableAdapter dtImagenes = new dsReporteTableAdapters.InformeBasicoImagenesTableAdapter();
            DataTable imagenes = (DataTable)dtImagenes.GetData(Convert.ToInt32(ajusteId));
            if (imagenes.Rows.Count > 0)
                informeBasico.OpenSubreport("crIBImagen.rpt").SetDataSource(imagenes);
            else
                informeBasico.ReportDefinition.Sections["Imagenes"].SectionFormat.EnableSuppress = true;


            dsReporteTableAdapters.InformeBasicoDocumentacionSolicitadaTableAdapter dtdocumentacion = new dsReporteTableAdapters.InformeBasicoDocumentacionSolicitadaTableAdapter();
            try
            {
                DataTable documentacion = (DataTable)dtdocumentacion.GetData(Convert.ToInt32(ajusteId));
                if (documentacion.Rows.Count > 0)
                    informeBasico.OpenSubreport("crIBDocumentacion.rpt").SetDataSource(documentacion);
                else
                    informeBasico.ReportDefinition.Sections["documentacion"].SectionFormat.EnableSuppress = true;
            }
            catch (Exception Ex)
            {
                Console.Write(Ex.Message);
            }

            dsReporteTableAdapters.InformeBasicoReclamoTableAdapter dtreclamo = new dsReporteTableAdapters.InformeBasicoReclamoTableAdapter();
            DataTable reclamo = (DataTable)dtreclamo.GetData(Convert.ToInt32(ajusteId));
            ReportDocument reclamoReport = informeBasico.OpenSubreport("crIBReclamo.rpt");
            reclamoReport.SetDataSource(reclamo);


            //Aqui agrego el nuevo SubReporte Informacion Complementaria
            dsReporteTableAdapters.InformeBasicoReclamoTableAdapter dtinformacionComplementaria = new dsReporteTableAdapters.InformeBasicoReclamoTableAdapter();
            DataTable informacionComplementaria = (DataTable)dtinformacionComplementaria.GetData(Convert.ToInt32(ajusteId));
            ReportDocument informacionComplementariaReport = informeBasico.OpenSubreport("crIBInformacionComplementaria.rpt");
            informacionComplementariaReport.SetDataSource(informacionComplementaria);



            dsReporteTableAdapters.InformeBasicoInspeccionTableAdapter dtinspeccion = new dsReporteTableAdapters.InformeBasicoInspeccionTableAdapter();
            DataTable inspeccion = (DataTable)dtinspeccion.GetData(Convert.ToInt32(ajusteId));
            informeBasico.OpenSubreport("crIBInspeccion.rpt").SetDataSource(inspeccion);

            dsReporteTableAdapters.InformeBasicoOcurrenciaDetalleTableAdapter dtdetalleocurrencia = new dsReporteTableAdapters.InformeBasicoOcurrenciaDetalleTableAdapter();
            DataTable detalleocurrencia = (DataTable)dtdetalleocurrencia.GetData(Convert.ToInt32(ajusteId));
            if (detalleocurrencia.Rows.Count > 0)
                informeBasico.OpenSubreport("crIBDetalleOcurrencia.rpt").SetDataSource(detalleocurrencia);
            else
                informeBasico.ReportDefinition.Sections["detalleOcurrencia"].SectionFormat.EnableSuppress = true;

            dsReporteTableAdapters.InformeBasicoOcurrenciaCabeceraTableAdapter dtocurrencia = new dsReporteTableAdapters.InformeBasicoOcurrenciaCabeceraTableAdapter();
            DataTable ocurrencia = (DataTable)dtocurrencia.GetData(Convert.ToInt32(ajusteId));
            informeBasico.OpenSubreport("crIBOcurrencia.rpt").SetDataSource(ocurrencia);

            dsReporteTableAdapters.InformeBasicoClausulasTableAdapter dtclausulas = new dsReporteTableAdapters.InformeBasicoClausulasTableAdapter();
            DataTable clausulas = (DataTable)dtclausulas.GetData(Convert.ToInt32(ajusteId));
            if (clausulas.Rows.Count > 0)
                informeBasico.OpenSubreport("crIBClausulas.rpt").SetDataSource(clausulas);
            else
                informeBasico.ReportDefinition.Sections["Clausulas"].SectionFormat.EnableSuppress = true;



            dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter dtdeducibles = new dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter();
            DataTable deducibles = (DataTable)dtdeducibles.GetData(Convert.ToInt32(ajusteId));
            if (deducibles.Rows.Count > 0)
                informeBasico.OpenSubreport("crIBDeducibles.rpt").SetDataSource(deducibles);
            else
                informeBasico.ReportDefinition.Sections["deducibles"].SectionFormat.EnableSuppress = true;

            dsReporteTableAdapters.InformeBasicoPolizaDetalleTableAdapter dtdetallepoliza = new dsReporteTableAdapters.InformeBasicoPolizaDetalleTableAdapter();
            DataTable detallePoliza = (DataTable)dtdetallepoliza.GetData(Convert.ToInt32(ajusteId));
            if (detallePoliza.Rows.Count > 0)
                informeBasico.OpenSubreport("crIBDetallePoliza.rpt").SetDataSource(detallePoliza);
            else
                informeBasico.ReportDefinition.Sections["detallePoliza"].SectionFormat.EnableSuppress = true;



            dsReporteTableAdapters.InformeBasicoPolizaTableAdapter dtPoliza = new dsReporteTableAdapters.InformeBasicoPolizaTableAdapter();
            DataTable poliza = (DataTable)dtPoliza.GetData(Convert.ToInt32(ajusteId));
            informeBasico.OpenSubreport("crIBPoliza.rpt").SetDataSource(poliza);

            dsReporteTableAdapters.InformeBasicoFechaAvisoCoordinacionTableAdapter dtfechacoordinacion = new dsReporteTableAdapters.InformeBasicoFechaAvisoCoordinacionTableAdapter();
            DataTable fechaCoordinacion = (DataTable)dtfechacoordinacion.GetData(Convert.ToInt32(ajusteId));
            informeBasico.OpenSubreport("crIBFechaAviso.rpt").SetDataSource(fechaCoordinacion);

            dsReporteTableAdapters.InformeBasicoGeneralesTableAdapter dtgenerales = new dsReporteTableAdapters.InformeBasicoGeneralesTableAdapter();
            DataTable datosgenerales = (DataTable)dtgenerales.GetData(Convert.ToInt32(ajusteId));
            informeBasico.OpenSubreport("crIBGenerales.rpt").SetDataSource(datosgenerales);

            dsReporteTableAdapters.SeccionesAdicionalesAjusteTableAdapter seccionAdicionalAdapter = new dsReporteTableAdapters.SeccionesAdicionalesAjusteTableAdapter();
            DataTable seccionAdicionalTable = (DataTable)seccionAdicionalAdapter.GetData(Convert.ToInt32(ajusteId));

            if (seccionAdicionalTable.Rows.Count == 0) tieneSeccionesAdicionales = false;

            if (tieneSeccionesAdicionales)
            {
                informeBasico.OpenSubreport("SeccionAdicional").SetDataSource(seccionAdicionalTable);
            }
            else
                informeBasico.ReportDefinition.Sections["SeccionAdicional"].SectionFormat.EnableSuppress = true;

            //Secciones finales
            dsReporteTableAdapters.SeccionesTotalTableAdapter seccionFinalAdapter = new dsReporteTableAdapters.SeccionesTotalTableAdapter();
            DataTable seccionFinalTable = (DataTable)seccionFinalAdapter.GetData(Convert.ToDecimal((ajusteId)));

            if (seccionFinalTable.Rows.Count != 0 && tieneSeccionesFinales)
                informeBasico.OpenSubreport("SeccionFinal").SetDataSource(seccionFinalTable);
            else
                informeBasico.ReportDefinition.Sections["SeccionFinal"].SectionFormat.EnableSuppress = true;

            //Liquidación
            dsAjusteTableAdapters.ConvenioAjusteTableAdapter convenioAdapter = new dsAjusteTableAdapters.ConvenioAjusteTableAdapter();
            DataTable convenioTable = (DataTable)convenioAdapter.GetData(Convert.ToDecimal((ajusteId)));

            if (tieneSeccionesFinales)
                informeBasico.OpenSubreport("crIBLiquidacion.rpt").SetDataSource(convenioTable);
            else
                informeBasico.ReportDefinition.Sections["liquidacion"].SectionFormat.EnableSuppress = true;

            dsReporteTableAdapters.InformeBasicoCabeceraTableAdapter cabeceraAdapter = new dsReporteTableAdapters.InformeBasicoCabeceraTableAdapter();
            informeBasico.SetDataSource((DataTable)cabeceraAdapter.GetData(Convert.ToInt32(ajusteId)));

            informeBasico.SetParameterValue("tituloInforme", tituloInforme);
            informeBasico.SetParameterValue("tipoMonto", tipoMonto);
            informeBasico.SetParameterValue("montoIndemnizacion", montoIndemnizacion);

            return informeBasico;
        }

        private static ReportDocument getConvenioAjuste(decimal ajusteId, string ApplicationPath)
        {
            // Instancia del reporte
            String reportPath = ApplicationPath + "\\docs\\crConvenioAjuste.rpt";

            ReportDocument convenioAjuste = new ReportDocument();
            convenioAjuste.Load(reportPath);

            dsReporteTableAdapters.InformeBasicoCabeceraTableAdapter cabeceraAdapter = new dsReporteTableAdapters.InformeBasicoCabeceraTableAdapter();
            convenioAjuste.OpenSubreport("Cabecera").SetDataSource((DataTable)cabeceraAdapter.GetData(Convert.ToInt32(ajusteId)));

            dsReporteTableAdapters.ConvenioAjusteTableAdapter convenioAdapter = new dsReporteTableAdapters.ConvenioAjusteTableAdapter();
            convenioAjuste.SetDataSource((DataTable)convenioAdapter.GetData(Convert.ToDecimal(ajusteId)));

            convenioAjuste.SetParameterValue("montoIndemnizacion", GestorAjuste.dameTotalIndemnizacion(ajusteId));

            return convenioAjuste;
        }

        private static ReportDocument getHojaResumen(decimal ajusteId, string ApplicationPath)
        {
            // Instancia del reporte
            String reportPath = ApplicationPath + "\\docs\\crCaratula.rpt";

            ReportDocument hojaResumen = new ReportDocument();
            hojaResumen.Load(reportPath);

            dsAjusteTableAdapters.EncabezadoSelectTableAdapter hojaResumenAdapter = new dsAjusteTableAdapters.EncabezadoSelectTableAdapter();
            hojaResumen.SetDataSource((DataTable)hojaResumenAdapter.GetData(Convert.ToDecimal(ajusteId)));

            return hojaResumen;
        }

        private static ReportDocument getSolicitudDocumentos(decimal ajusteId, decimal solicitudDocumentosId, string nombreDestinatario, string cargoDestinatario, DateTime fechaRemision, string numeroCarta, int numeroRecordatorio, string descripcion, string ApplicationPath)
        {
            // Instancia del reporte
            //String reportPath = ApplicationPath + "\\docs\\crSolicitudDocs.rpt";
            String reportPath = ApplicationPath + "\\docs\\crSolicitudDocumentos.rpt";

            ReportDocument solicitudDocumentos = new ReportDocument();
            solicitudDocumentos.Load(reportPath);

            dsReporteTableAdapters.SolicitudDocsTableAdapter documentosAdater = new dsReporteTableAdapters.SolicitudDocsTableAdapter();
            dsReporte.SolicitudDocsDataTable documentosTable = documentosAdater.GetData(ajusteId, solicitudDocumentosId);
            solicitudDocumentos.OpenSubreport("Documentos").SetDataSource(documentosTable.Select(" estado = 'N'"));

            dsReporteTableAdapters.SolicitudDocumentoTableAdapter solicitudAdater = new dsReporteTableAdapters.SolicitudDocumentoTableAdapter();
            dsReporte.SolicitudDocumentoDataTable solicitudTable = solicitudAdater.GetData(ajusteId, solicitudDocumentosId);

            solicitudDocumentos.SetDataSource((DataTable)solicitudTable);

            solicitudDocumentos.SetParameterValue("personaNombre", nombreDestinatario);
            solicitudDocumentos.SetParameterValue("personaCargo", cargoDestinatario);
            solicitudDocumentos.SetParameterValue("fechaRemision", fechaRemision);
            solicitudDocumentos.SetParameterValue("numeroCarta", numeroCarta);
            solicitudDocumentos.SetParameterValue("numeroRecordatorio", numeroRecordatorio);
            solicitudDocumentos.SetParameterValue("descripcion", descripcion);

            return solicitudDocumentos;
        }

        public static Byte[] GetMyInformeNow(int AjusteId, string TipoInforme)
        {
            return GetInformeInBytes(Convert.ToDecimal(AjusteId), TipoInforme);
        }
    }
}