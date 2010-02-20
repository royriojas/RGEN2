using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AjaxPro;
using RGen;

namespace utiles.ajax
{
    /// <summary>
    /// Summary description for gestorAjax
    /// </summary>
    public class gestorAjax
    {
        public static gestorAjax Instance = new gestorAjax();

        public gestorAjax()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        [AjaxPro.AjaxMethod]
        public object[] getDiasEnLosEstados(string num_ajuste, int estado)
        {
            object[] Dias = new object[15];
            dsRgenControlTableAdapters.TiempoEnElEstadoTableAdapter  ta = new dsRgenControlTableAdapters.TiempoEnElEstadoTableAdapter();
            decimal num_ajuste_int = Convert.ToDecimal(num_ajuste);            

            for (int i = 0; i <= estado; i++)
            {
                dsRgenControl.TiempoEnElEstadoDataTable dt = ta.GetData(num_ajuste_int, i);
                if (dt.Rows.Count > 0)
                {
                    decimal dias = (decimal)(dt.Rows[0]["dias"]);
                    Dias[i] = (dias != -1) ? Convert.ToString(dias) : "--";
                }
                else
                {
                    Dias[i] = "--";
                }
            }
            return Dias;
        }

        
        public static string GetDatosAjuste(String num_ajuste)
        {
            
            return JavaScriptSerializer.Serialize(Instance.getDatosAjuste(num_ajuste));
        }

        [AjaxPro.AjaxMethod]
        public object[] getDatosAjuste(String num_ajuste)
        {

            int numAjuste = Convert.ToInt32(num_ajuste);

            dsAjaxTableAdapters.mensajesAjaxTableAdapter msAjax = new dsAjaxTableAdapters.mensajesAjaxTableAdapter();
            dsAjax.mensajesAjaxDataTable msTableAjax = msAjax.GetData(numAjuste);

            object[] msg = new object[15];

            if (msTableAjax.Rows.Count > 0)
            {
                dsAjax.mensajesAjaxRow mensajes = (dsAjax.mensajesAjaxRow)msTableAjax.Rows[0];
                msg[0] = mensajes.RegistroInicial;
                msg[1] = mensajes.RegistroAvanzado;
                msg[2] = mensajes.CoordinacionInspeccion;
                msg[3] = mensajes.Inspeccion;
                msg[4] = mensajes.InformeBasico;
                msg[5] = mensajes.InformePreliminar;
                msg[6] = mensajes.InformeComplementario;
                msg[7] = mensajes.convenioajuste;
                msg[8] = mensajes.InformeFinal;
                msg[9] = mensajes.cabecera;
                msg[10] = mensajes.SolicitudDocumentos;
                msg[11] = mensajes.UltimasComunicaciones;
                msg[12] = mensajes.UltimosAnexos;
                msg[13] = mensajes.UltimasActividades;
                msg[14] = mensajes.UltimosGastos;
                

            }

            return msg;
        }

        [AjaxPro.AjaxMethod]
        public String getTipoDeCambio(string MId)
        {
            decimal MonedaId = Convert.ToDecimal(MId);
            try
            {
                dsTipoCambioTableAdapters.ObtenerTipoCambioTableAdapter dsTCambio = new dsTipoCambioTableAdapters.ObtenerTipoCambioTableAdapter();
                dsTipoCambio.ObtenerTipoCambioDataTable tipoCambio = dsTCambio.GetData(MonedaId);
                dsTipoCambio.ObtenerTipoCambioRow fila = (dsTipoCambio.ObtenerTipoCambioRow)((DataRow)tipoCambio.Rows[0]);
                return Convert.ToString(Math.Round(fila.factor, 2));
            }
            catch (Exception ex)
            {
                return "-1";
            }
        }

        [AjaxPro.AjaxMethod]
        public String getNumeroAjuste(string valor)
        {
            decimal numAjuste = Convert.ToDecimal(valor);
            dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter ajuste = new dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter();
            dsAjax.AjaxDatosCabeceraAjusteDataTable AjusteDT = ajuste.GetData(numAjuste);
            dsAjax.AjaxDatosCabeceraAjusteRow AjusteDTRow = (dsAjax.AjaxDatosCabeceraAjusteRow)AjusteDT.Rows[0];            

            string resultado;
            try
            {
                resultado = (AjusteDTRow.numAjustePASA != null) ? AjusteDTRow.numAjustePASA : "Error en la conversión";

            }
            catch (Exception e)
            {
                resultado = "";
            }
            return "Ajuste " + AjusteDTRow.tajuste + " -  N°:" + resultado;


        }

        [AjaxPro.AjaxMethod]
        public int getEstadoActual(string valor)
        {
            decimal numAjuste = Convert.ToDecimal(valor);
            dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter ajuste = new dsAjaxTableAdapters.AjaxDatosCabeceraAjusteTableAdapter();
            dsAjax.AjaxDatosCabeceraAjusteDataTable AjusteDT = ajuste.GetData(numAjuste);
            dsAjax.AjaxDatosCabeceraAjusteRow AjusteDTRow = (dsAjax.AjaxDatosCabeceraAjusteRow)AjusteDT.Rows[0];
            int cod = (int)AjusteDTRow.codigoestado;
            //si es un ajuste de tipo normal 1 entonces el código que se retornará será el codigo 10;
            return cod;
            //return (AjusteDTRow.tajusteid == 1) ? cod : 10;
        }
        [AjaxPro.AjaxMethod]
        public int getTipoAjuste(String ajusteid)
        {
            int valor = -1;
            try
            {
                valor = (int) GestorAjuste.dameTipoAjuste(Convert.ToDecimal(ajusteid));
            }
            catch (Exception ex)
            {

            }
            return valor;
            
        }
        [AjaxPro.AjaxMethod]
        public int getEstadoDocumentos(string ajusteid)
        {
            //hacer el query para que bote si hay documentos solicitados para este ajuste, en caso contrario devolver 0
            dsAjaxTableAdapters.mensajesAjaxTableAdapter ta = new dsAjaxTableAdapters.mensajesAjaxTableAdapter();
            Int32 faltandocumentos =  Convert.ToInt32(ta.numeroDeDocumentosSolicitados(Convert.ToDecimal(ajusteid)));
            if (faltandocumentos > 0) return 1;
            else return 0;
           
        }

        public static string GetEstadoActual(string qStringAjusteId)
        {
            return JavaScriptSerializer.Serialize(Instance.getEstadoActual(qStringAjusteId));
        }

        public static string GetEstadoDocumentos(string qStringAjusteId)
        {
            return JavaScriptSerializer.Serialize(Instance.getEstadoDocumentos(qStringAjusteId));
        }

        public static string GetDiasEnLosEstados(string qStringAjusteId, string estadoActual)
        {
            return JavaScriptSerializer.Serialize(Instance.getDiasEnLosEstados(qStringAjusteId, int.Parse(estadoActual)));
        }

        public static string GetTipoAjuste(string qStringAjusteId)
        {
            return JavaScriptSerializer.Serialize(Instance.getTipoAjuste(qStringAjusteId));
        }
    }
}
