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
/// Summary description for GestorInforme
/// </summary>
public class GestorInforme
{
  public GestorInforme()
  {
    //
    // TODO: Add constructor logic here
    //
  }

  public static String getSubtitle(String KeyName, decimal AjusteId)
  {
    dsSecInformeTableAdapters.QueriesTableAdapter qta = new dsSecInformeTableAdapters.QueriesTableAdapter();
    object section = qta.sqlQueryGetSection(KeyName, AjusteId);
    if (section != null)
      return section.ToString();
    return String.Empty;
  }
}
