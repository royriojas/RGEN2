using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

/// <summary>
/// Summary description for gestorParametros
/// </summary>
namespace RGen.Gestores
{
    public class gestorParametros
    {
        public gestorParametros()
        {
            
            //
            // TODO: Add constructor logic here
            //
        }
        public static ArrayList getCorreosAdministrativos()
        {
            parametrosTableAdapters.CorreosADMTableAdapter ta = new parametrosTableAdapters.CorreosADMTableAdapter();
            parametros.CorreosADMDataTable tb = ta.GetData();

            ArrayList correos = new ArrayList();
            foreach (parametros.CorreosADMRow row in tb)
            {
                correos.Add(row.valorParametro);
            }
            return correos;
        }
        public static String getNumeroActualSolicitud()
        {
            try
            {
                dsCartasTableAdapters.numeroComunicacionActualTableAdapter ta = new dsCartasTableAdapters.numeroComunicacionActualTableAdapter();
                return (String)ta.generaNumeroComunicacion();
            }
            catch (Exception ex)
            {
                return "";
            }
        }
        public static void actualizaNumeroCarta()
        {
            try
            {
                dsCartasTableAdapters.numeroComunicacionActualTableAdapter ta = new dsCartasTableAdapters.numeroComunicacionActualTableAdapter();
                ta.actualizaNumeroCartaUpdate();
            }
            catch (Exception ex)
            {

            }
        }

    }

}