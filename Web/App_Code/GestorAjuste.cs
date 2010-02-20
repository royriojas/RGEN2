using System;
using System.Web;
using Serializer;

/// <summary>
/// Summary description for gestorAjuste
/// </summary>
/// 

namespace RGen
{
    public class Contacto
    {
        private String nombre;

        public String Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }

        private String email;
        public String Email
        {
            get { return email; }
            set { email = value; }
        }



        private String telefono;
        public String Telefono
        {
            get { return telefono; }
            set { telefono = value; }
        }


        private decimal idDeLaEmpresa;

        private String nombreDeLaEmpresa;

        public Contacto()
        {
        }

    }

    public class ControlDiasAseguradora
    {
        private decimal aseguradoraId;
        private decimal diasIB;
        private decimal diasIP;
        private decimal diasIC;
        private decimal diasIFR;

        public decimal AseguradoraId
        {
            get { return aseguradoraId; }
            set { aseguradoraId = value; }
        }
        public decimal DiasIB
        {
            get { return diasIB; }
            set { diasIB = value; }
        }
        public decimal DiasIP
        {
            get { return diasIP; }
            set { diasIP = value; }
        }
        public decimal DiasIC
        {
            get { return diasIC; }
            set { diasIC = value; }
        }
        public decimal DiasIFR
        {
            get { return diasIFR; }
            set { diasIFR = value; }
        }


        public ControlDiasAseguradora()
        {

        }
    }

    public class GestorAjuste
    {

        public GestorAjuste()
        {

        }
        public static decimal dameCodigoEstado(decimal ajusteId)
        {
            dsEstadoTableAdapters.administraEstadosTableAdapter ta = new dsEstadoTableAdapters.administraEstadosTableAdapter();
            decimal codigoEstadoAjuste = (decimal)((ta.dameCodigoEstadoActual(ajusteId) != null) ? ta.dameCodigoEstadoActual(ajusteId) : -1);
            return codigoEstadoAjuste;
        }
        /// <summary>
        /// Devuelve el último estado del ajuste (en texto)
        /// </summary>
        /// <param name="ajusteId">Id del Ajuste</param>
        /// <returns>el último estado del ajuste (en texto) o "-1" si el ajuste no pudo ser ubicado</returns>
        public static String dameEstado(decimal ajusteId)
        {
            dsAjax.AjaxDatosCabeceraAjusteRow row = dameAjuste(ajusteId);
            if (row != null)
            {
                return row.Status;
            }
            else
            {
                return "-1";
            }
        }
        public static dsAjax.AjaxDatosCabeceraAjusteRow dameAjuste(decimal ajusteId)
        {
            dsAjax.AjaxDatosCabeceraAjusteRow ajus;
            try
            {
                dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter Ta = new dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter();
                dsAjax.AjaxDatosCabeceraAjusteDataTable DT = Ta.GetData(ajusteId);
                ajus = (dsAjax.AjaxDatosCabeceraAjusteRow)DT.Rows[0];
            }
            catch (Exception e)
            {
                LoggerFacade.Log(e);
                ajus = null;
            }
            return ajus;
        }

        public static decimal dameRiesgoIdDelAjuste(decimal ajusteId)
        {
            dsAjusteTableAdapters.AjusteTotalInsertTableAdapter ta = new dsAjusteTableAdapters.AjusteTotalInsertTableAdapter();
            try
            {
                return (decimal)ta.getRiesgoIdAjuste(ajusteId);
            }
            catch (Exception ex)
            {
                LoggerFacade.Log(ex);
                return 0;
            }
        }

        public static String dameNumeroAjuste(decimal ajusteId)
        {
            String NumeroAjuste;
            try
            {
                NumeroAjuste = dameAjuste(ajusteId).numAjustePASA;
            }
            catch (Exception ex)
            {
                LoggerFacade.Log(ex);
                NumeroAjuste = "";
            }
            return NumeroAjuste;
        }

        public static String getNombreAsegurado(decimal ajusteId)
        {
            return dameAjuste(ajusteId).Asegurado;
        }

        public static dsAjax.Ajuste_Total_SelectRow dameAjuste_Contactos(decimal ajusteId)
        {
            dsAjax.Ajuste_Total_SelectRow ajuste;
            try
            {
                dsAjaxTableAdapters.Ajuste_Total_SelectTableAdapter ta = new dsAjaxTableAdapters.Ajuste_Total_SelectTableAdapter();
                dsAjax.Ajuste_Total_SelectDataTable DT = ta.GetData(ajusteId);
                ajuste = (dsAjax.Ajuste_Total_SelectRow)DT.Rows[0];
            }
            catch (Exception e)
            {
                LoggerFacade.Log(e);
                ajuste = null;
            }

            return ajuste;
        }

        public static Contacto dameContactoAseguradora(decimal ajusteId)
        {
            dsAjax.Ajuste_Total_SelectRow ajuste = dameAjuste_Contactos(ajusteId);
            Contacto contacto;
            if (ajuste != null)
            {
                contacto = new Contacto();
                contacto.Email = ajuste.emailresponsable;
                contacto.Nombre = ajuste.nombreresponsable;
                contacto.Telefono = ajuste.telefonoresponsable;

            }
            else
            {
                return null;
            }
            return contacto;
        }
        public static Boolean elCasoEstaEnControlCalidad(decimal ajusteId)
        {
            Boolean enControl = false;

            dsAjusteTableAdapters.EstaEnControlCalidadTableAdapter ta = new dsAjusteTableAdapters.EstaEnControlCalidadTableAdapter();

            dsAjuste.EstaEnControlCalidadDataTable dt = ta.GetData(ajusteId);
            if (dt.Rows.Count > 0)
            {
                enControl = true;
            }
            return enControl;

        }
        public static String dameCorreoAjustador(decimal ajusteId)
        {
            dsAjusteTableAdapters.EmailAjustadorTableAdapter ta = new dsAjusteTableAdapters.EmailAjustadorTableAdapter();
            dsAjuste.EmailAjustadorDataTable dt = ta.GetData(ajusteId);
            dsAjuste.EmailAjustadorRow row = (dsAjuste.EmailAjustadorRow)dt.Rows[0];

            return row.email;

        }
        public static ControlDiasAseguradora dameControlAseguradora(decimal aseguradoraId)
        {
            try
            {
                dsAjusteTableAdapters.configuracionAseguradoraTableAdapter ta = new dsAjusteTableAdapters.configuracionAseguradoraTableAdapter();
                dsAjuste.configuracionAseguradoraDataTable dt = ta.GetData(aseguradoraId);

                if (dt.Rows.Count > 0)
                {

                    dsAjuste.configuracionAseguradoraRow row = (dsAjuste.configuracionAseguradoraRow)dt.Rows[0];

                    ControlDiasAseguradora control = new ControlDiasAseguradora();
                    control.AseguradoraId = row.aseguradoraId;
                    control.DiasIB = row.diasIB;
                    control.DiasIC = row.diasIC;
                    control.DiasIP = row.diasIP;
                    control.DiasIFR = row.diasIFR;

                    return control;
                }
            }
            catch (Exception e)
            {
                LoggerFacade.Log(e);
            }
            return null;

        }
        public static Contacto dameContactoBroker(decimal ajusteId)
        {
            dsAjax.Ajuste_Total_SelectRow ajuste = dameAjuste_Contactos(ajusteId);
            Contacto contacto;
            if (ajuste != null)
            {
                contacto = new Contacto();
                contacto.Email = ajuste.emailresponsablebroker;
                contacto.Nombre = ajuste.nombreresponsablebroker;
                contacto.Telefono = ajuste.telefonoresponsablebroker;

            }
            else
            {
                return null;
            }
            return contacto;
        }

        public static Contacto dameContactoAsegurado(decimal ajusteId)
        {
            dsAjax.Ajuste_Total_SelectRow ajuste = dameAjuste_Contactos(ajusteId);
            Contacto contacto;
            if (ajuste != null)
            {
                contacto = new Contacto();
                contacto.Email = ajuste.emailresponsablesiniestro;
                contacto.Nombre = ajuste.nombreresponsablesiniestro;
                contacto.Telefono = ajuste.telefonoresponsablesiniestro;

            }
            else
            {
                return null;
            }

            return contacto;
        }
        public static decimal dameTipoAjuste(decimal ajusteId)
        {
            try
            {
                dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter ajuste = new dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter();
                dsAjax.AjaxDatosCabeceraAjusteDataTable AjusteDT = ajuste.GetData(ajusteId);
                dsAjax.AjaxDatosCabeceraAjusteRow AjusteDTRow = (dsAjax.AjaxDatosCabeceraAjusteRow)AjusteDT.Rows[0];

                return AjusteDTRow.tajusteid;
            }
            catch (Exception ex)
            {
                LoggerFacade.Log(ex);
                return -1;
            }


        }
        public static decimal dameTotalIndemnizacion(decimal ajusteId)
        {
            try
            {
                dsAjaxTableAdapters.AjaxConvenioAjusteTableAdapter ajuste = new dsAjaxTableAdapters.AjaxConvenioAjusteTableAdapter();
                dsAjax.AjaxConvenioAjusteDataTable AjusteDT = ajuste.GetData(ajusteId);
                dsAjax.AjaxConvenioAjusteRow AjusteDTRow = (dsAjax.AjaxConvenioAjusteRow)AjusteDT.Rows[0];

                return AjusteDTRow.totalIndemnizacion;
            }
            catch (Exception ex)
            {
                LoggerFacade.Log(ex);
                return 0;
            }


        }


        public static void RechazaAjuste(int ajusteId, bool rechazado)
        {
            try
            {
                dsAjusteTableAdapters.QueriesTableAdapter qTa = new dsAjusteTableAdapters.QueriesTableAdapter();
                qTa.SetAjusteRechazado(rechazado, ajusteId);
            }
            catch (Exception ex)
            {
                LoggerFacade.Log(ex);
            }
        }

        public static Boolean AjusteRechazado(int ajusteId)
        {
            try
            {
                dsAjusteTableAdapters.QueriesTableAdapter qTa = new dsAjusteTableAdapters.QueriesTableAdapter();

                return Convert.ToBoolean(qTa.getAjusteRechazado(ajusteId));
            }
            catch (Exception ex)
            {
                LoggerFacade.Log(ex);
                return false;
            }
        }

        public static String GetCodigoAseguradora(decimal ajusteId)
        {
            dsAjusteNewTableAdapters.QueriesTableAdapter qta = new dsAjusteNewTableAdapters.QueriesTableAdapter();
            Object response = qta.proc_get_CodigoAseguradora_By_AjusteId(ajusteId);
            return response.ToString();
        }

        public static Boolean SystemFieldsInserted(decimal AjusteId)
        {
            dsAjusteNewTableAdapters.QueriesTableAdapter qTa = new dsAjusteNewTableAdapters.QueriesTableAdapter();
            Object response = qTa.sqlQuery_GetSeccionesSistema(AjusteId);
            return Convert.ToInt32(response) > 0;
        }

        public static void InsertSystemSubtitles(decimal @AjusteId, String UserName)
        {
            dsAjusteNewTableAdapters.RGN_SECCIONESAJUSTETableAdapter SecAjusteTA = new dsAjusteNewTableAdapters.RGN_SECCIONESAJUSTETableAdapter();

            

            sections secs;
            //TODO:check this works with the new version of the ObjectSerializer
            ObjectXmlSerializer.Load(HttpContext.Current.Server.MapPath("~/App_Data/AditionalSections.xml"), out secs);

            if ((secs == null) || (secs.Secs.Count <= 0)) return;
            foreach (section sss in secs.Secs)
            {
                SecAjusteTA.Insert(null, sss.Title, null, "", sss.Level.ToString(), AjusteId, DateTime.Now, DateTime.Now, "A", UserName, null, true, sss.KeyName);
            }
        }
    }
}
