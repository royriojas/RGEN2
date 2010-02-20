using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections.Generic;

/// <summary>
/// Summary description for debugClass
/// </summary>
namespace utiles
{


  public class LogItem
  {
    private DateTime timeStamp;
    private String contentLine;

    public DateTime TimeStamp
    {
      get
      {
        return this.timeStamp;
      }
      set
      {
        this.timeStamp = value;
      }
    }
    public String ContentLine
    {
      get
      {
        return this.contentLine;
      }
      set
      {
        this.contentLine = value;
      }
    }

    public LogItem(String ContentLine)
    {
      this.timeStamp = DateTime.Now;
      this.contentLine = ContentLine;
    }
    public override String ToString()
    {
      return this.timeStamp.ToString() + " -- " + this.contentLine + "\r\n";
    }
  }
  public class Logger
  {
    private String fileName;
    private List<LogItem> LogItems;

    public Logger(String path)
    {
      this.fileName = path;
      LogItems = new List<LogItem>();
      LogItems.Add(new LogItem(" ------------------------------ INICIO TRANSACCION --------------------------------"));
    }
    public void addLogItem(LogItem item)
    {
      LogItems.Add(item);
    }
    public void writeLog()
    {
      String ItemsString = "";
      foreach (LogItem it in LogItems)
      {
        ItemsString += it.ToString();
      }
      try
      {
        File.AppendAllText(this.fileName, ItemsString, System.Text.Encoding.UTF8);

      }
      catch (System.IO.IOException ex)
      {

      }
    }
  }
  public class debugClass
  {
    public debugClass()
    {
      //
      // TODO: Add constructor logic here
      //
    }


    private static bool NoMustDebug()
    {
      return !(ConfigurationManager.AppSettings["debugMode"] == "on");
    }
    public static string muestra(System.Data.Common.DbCommand cmd, String location_of_file)
    {

      if (NoMustDebug()) return String.Empty;
      try
      {
        string cadenastr = cmd.CommandText + " ";
        string cadenastr_parameter_name = cmd.CommandText + " ";

        for (int i = 0; i < cmd.Parameters.Count; i++)
        {
          cadenastr_parameter_name += cmd.Parameters[i].ParameterName + ", \r\n";
          cadenastr = cadenastr + (((cmd.Parameters[i].Value == "") || ((cmd.Parameters[i].Value == null))) ? "null" : cmd.Parameters[i].Value) + ",\r\n";
        }

        FileStream fs = File.Create(location_of_file);
        StreamWriter sw = new StreamWriter(fs);
        sw.Write(cadenastr_parameter_name + " \n" + cadenastr);

        sw.Close();
        fs.Close();
        return (cadenastr);
      }
      catch (Exception ex)
      {
        LoggerFacade.Log(ex);
      }

      return String.Empty;


    }



    public static string muestra(System.Data.Common.DbCommand cmd)
    {
      if (NoMustDebug()) return String.Empty;

      string cadenastr = cmd.CommandText + " ";
      string cadenastr_parameter_name = cmd.CommandText + " ";

      for (int i = 0; i < cmd.Parameters.Count; i++)
      {
        cadenastr_parameter_name += cmd.Parameters[i].ParameterName + ", \r\n";
        cadenastr = cadenastr + (((cmd.Parameters[i].Value == "") || ((cmd.Parameters[i].Value == null))) ? "null" : cmd.Parameters[i].Value) + ",\r\n";
      }

      return (cadenastr);
    }
  }
}