using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using utiles;

/// <summary>
/// Summary description for LoggerFacade
/// </summary>
public class LoggerFacade
{

  private static Logger logger = null;

  public LoggerFacade()
  {
    //
    // TODO: Add constructor logic here
    //
  }

  private static bool NoLogEnabled()
  {
    return !(ConfigurationManager.AppSettings["debugMode"] == "on");
  }
  public static void Log(String Message)
  {
    if (NoLogEnabled()) return;

    GetLogger();

    logger.addLogItem(new LogItem(Message));
    logger.writeLog();

  }

  private static void GetLogger()
  {
    if (logger == null) logger = new Logger(HttpContext.Current.Server.MapPath("log.txt"));
  }

  public static void Log(Exception ex)
  {
    if (NoLogEnabled()) return;

    GetLogger();

    logger.addLogItem(new LogItem(ex.Message));
    logger.writeLog();
  }
}
