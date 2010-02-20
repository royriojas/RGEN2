using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for App
/// </summary>
namespace RGen
{
    public class App
    {
        public App()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static void grabaNumeroInicialAjuste(String numInicial)
        {
            parametrosTableAdapters.CorreosADMTableAdapter pTa = new parametrosTableAdapters.CorreosADMTableAdapter();
            pTa.actualizaNumeroAjusteInicial(numInicial);
        }
    }
    

}
