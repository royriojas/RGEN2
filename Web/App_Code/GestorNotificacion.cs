using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using RGen;
using RGen.Utiles;


/// <summary>
/// Summary description for GestorNotificacion
/// </summary>
public class GestorNotificacion
{
  public GestorNotificacion()
  {
    //
    // TODO: Add constructor logic here
    //
  }


  public static Boolean sendMail(Decimal ajusteId,
                                  String CodigoGenerado,
                                  String Codigo,
                                  String asunto,
                                  String Cuerpo,
                                  FileInfo f,
                                  DateTime FechaEnvio
      )
  {

    Contacto contactoAseguradora = GestorAjuste.dameContactoAseguradora(Convert.ToDecimal(ajusteId));
    Contacto contactoBroker = GestorAjuste.dameContactoBroker(Convert.ToDecimal(ajusteId));

    String to = "";
    String CC = ConfigurationManager.AppSettings["correoAdministrador"];

    String from = ConfigurationManager.AppSettings["correoAdministrador"];

    if (recibirNotificacionAseguradora(ajusteId, Codigo))
    {
      to = contactoAseguradora.Email;
    }
    if (recibirNotificacionBroker(ajusteId, Codigo))
    {
      to += "," + contactoBroker.Email;
    }
    return enviaNotificacion(CodigoGenerado, from, to, CC, asunto, Cuerpo, f, FechaEnvio);
  }

  public static Boolean sendMailPeriodicoAjustador(Decimal ajusteId,
                                String CodigoGenerado,
                                String asunto,
                                String Cuerpo,
                                FileInfo f,
                                decimal diasAPartirdeHoy)
  {

    if (GestorAjuste.dameAjuste(ajusteId).IsajustadorIdNull()) return false;

    Contacto contactoAseguradora = GestorAjuste.dameContactoAseguradora(Convert.ToDecimal(ajusteId));

    String to = GestorAjuste.dameCorreoAjustador(GestorAjuste.dameAjuste(ajusteId).ajustadorId);

    to += "," + contactoAseguradora.Email;

    String from = ConfigurationManager.AppSettings["correoAdministrador"];
    String CC = ConfigurationManager.AppSettings["correoAdministrador"];

    return enviaNotificacionPeriodica(CodigoGenerado, from, to, CC, asunto, Cuerpo, null, DateTime.Now.AddDays(Convert.ToDouble(diasAPartirdeHoy)), 7 * 24 * 60, 24 * 60);

  }

  public static bool hasVisibilityPermissionAseguradora(decimal AseguradoraId, String codigo)
  {
    dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter ta = new dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter();

    dsNotificaciones.FuncionalidadNivel2DataTable dt = ta.GetData(AseguradoraId, codigo);

    return (dt.Rows.Count > 0);

  }
  public static bool hasVisibilityPermissionBroker(decimal BrokerId, decimal AseguradoraId, String codigo)
  {
    dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter ta = new dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter();

    dsNotificaciones.FuncionalidadNivel2DataTable dt = ta.FuncionalidadByBrokerAndAseguradoraId(AseguradoraId, codigo, BrokerId);

    return (dt.Rows.Count > 0);

  }

  public static bool recibirNotificacionBroker(decimal ajusteId, string codigo)
  {
    if (GestorAjuste.dameAjuste(ajusteId).IsbrokerIdNull()) return false;

    decimal AseguradoraId = GestorAjuste.dameAjuste(ajusteId).aseguradoraId;
    decimal BrokerId = GestorAjuste.dameAjuste(ajusteId).brokerId;


    dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter ta = new dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter();

    dsNotificaciones.FuncionalidadNivel2DataTable dt = ta.FuncionalidadByBrokerAndAseguradoraId(AseguradoraId, codigo, BrokerId);

    return (dt.Rows.Count > 0);

  }

  public static bool recibirNotificacionAseguradora(decimal ajusteId, string codigo)
  {
    decimal AseguradoraId = GestorAjuste.dameAjuste(ajusteId).aseguradoraId;

    dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter ta = new dsNotificacionesTableAdapters.FuncionalidadNivel2TableAdapter();

    dsNotificaciones.FuncionalidadNivel2DataTable dt = ta.GetData(AseguradoraId, codigo);

    return (dt.Rows.Count > 0);
  }

  /// <summary>
  /// Envia una notificación simple. (no repetitiva)
  /// </summary>
  /// <param name="CodigoGenerado">El codigo que identifica univocamente la tarea de envío</param>
  /// <param name="from">de</param>
  /// <param name="to">para</param>
  /// <param name="CC">copia</param>
  /// <param name="asunto">asunto</param>
  /// <param name="cuerpo">cuerpo HTML</param>
  /// <param name="f">FileInfo del archivo a enviar, no puede ser nulo!!!!!!</param>
  /// <param name="fechaEnvio">cuando empieza a envíar</param>
  /// <returns>True si tuvo exito el agendamiento de la tarea</returns>
  public static Boolean enviaNotificacion(String CodigoGenerado,
                                           String from,
                                           String to,
                                           String CC,
                                           String asunto,
                                           String cuerpo,
                                           FileInfo f,
                                           DateTime fechaEnvio
                                           )
  {

    byte[] adjunto = null;
    String fileName = "";
    if (f != null)
    {
      adjunto = getBinaryFromFile(f);
      fileName = f.Name;
    }

    try
    {
      //GoNote.Service notificador = new GoNote.Service();
      //notificador.Url = ConfigurationManager.AppSettings["GoNote.Service"];
      ////return notificador.EnviaMensaje(1,
      ////                         CodigoGenerado,
      ////                         from,
      ////                         to,
      ////                         CC,
      ////                         asunto,
      ////                         cuerpo,
      ////                         adjunto,
      ////                         fileName,
      ////                         fechaEnvio);

      return RGenMailer.SendMessage(to, asunto, cuerpo, f.FullName);
    }
    catch
    {
      return false;
    }


  }
  /// <summary>
  /// Envia una notificación periódic
  /// </summary>
  /// <param name="CodigoGenerado">El codigo que identifica univocamente la tarea de envío</param>
  /// <param name="from">de</param>
  /// <param name="to">para</param>
  /// <param name="CC">copia</param>
  /// <param name="asunto">asunto</param>
  /// <param name="cuerpo">cuerpo HTML</param>
  /// <param name="f">FileInfo del archivo a enviar, no puede ser nulo!!!!!!</param>
  /// <param name="fechaEnvio">cuando empieza a envíar</param>
  /// <param name="duracion">tiempo límite de envío de las notificaciones (en minutos)</param>
  /// <param name="periodo">cada cuanto (en minutos) se enviarán las notificaciones</param>
  /// <returns>True si tuvo exito el agendamiento de la tarea</returns>
  public static Boolean enviaNotificacionPeriodica(String CodigoGenerado,
                                          String from,
                                            String to,
                                            String CC,
                                            String asunto,
                                            String cuerpo,
                                            FileInfo f,
                                            DateTime fechaEnvio,
                                            int duracion,
                                            int periodo
                                          )
  {

    byte[] adjunto = null;
    String fileName = "";
    if (f != null)
    {
      adjunto = getBinaryFromFile(f);
      fileName = f.Name;
    }

    try
    {
      //GoNote.Service notificador = new GoNote.Service();
      //notificador.Url = ConfigurationManager.AppSettings["GoNote.Service"];
      //return notificador.EnviaMensajeRecurrente(1,//Sistema RGen Codigo De Aplicación
      //                                          CodigoGenerado,
      //                                          from,
      //                                          to,
      //                                          CC,
      //                                          asunto,
      //                                          cuerpo,
      //                                          adjunto,
      //                                          fileName,
      //                                          fechaEnvio,
      //                                          duracion,
      //                                          periodo);
      return true;
    }
    catch
    {
      return false;
    }

  }
  /// <summary>
  /// Cancela el envío de una notificación Periódica
  /// </summary>
  /// <param name="codigo">Es el codigo del Request que se quiere cancelar </param>
  /// <returns></returns>
  public static Boolean cancelarMailPeriodico(String codigo)
  {
    try
    {
      if (codigo != "")
      {
        //GoNote.Service notificador = new GoNote.Service();
        //notificador.Url = ConfigurationManager.AppSettings["GoNote.Service"];
        //return notificador.CancelarRequest(codigo);
        return true;
      }
      return false;

    }
    catch
    {
      return false;
    }


  }

  public static String armaCuerpo(Decimal AjusteId, String path, String Mensaje)
  {
    string html_notificacion = "";
    try
    {
      html_notificacion = File.ReadAllText(path);
    }
    catch (Exception ex)
    {
      LoggerFacade.Log(ex);
      return "[ERROR]";
    }

    dsAjax.AjaxDatosCabeceraAjusteRow ajusteRow = GestorAjuste.dameAjuste(AjusteId);

    html_notificacion = html_notificacion.Replace("{SHORTDATE}", HttpUtility.HtmlEncode(DateTime.Now.ToShortDateString()));
    html_notificacion = html_notificacion.Replace("{NUMAJUSTE}", HttpUtility.HtmlEncode((GestorAjuste.dameNumeroAjuste(AjusteId))));

    html_notificacion = html_notificacion.Replace("{MENSAJE}", HttpUtility.HtmlEncode(Mensaje));

    if (!(ajusteRow.IsAseguradoNull()))
      html_notificacion = html_notificacion.Replace("{ASEGURADO}", HttpUtility.HtmlEncode(ajusteRow.Asegurado));
    if (!(ajusteRow.IsAseguradoraNull()))
      html_notificacion = html_notificacion.Replace("{ASEGURADORA}", HttpUtility.HtmlEncode(ajusteRow.Aseguradora));
    if (!(ajusteRow.IsBrokerNull()))
      html_notificacion = html_notificacion.Replace("{BROKER}", HttpUtility.HtmlEncode(ajusteRow.Broker));

    if (!(ajusteRow.numeroPoliza == null))
      html_notificacion = html_notificacion.Replace("{NUMPOLIZA}", HttpUtility.HtmlEncode(ajusteRow.numeroPoliza));

    html_notificacion = html_notificacion.Replace("{URLTOREDIRECTNAME}", "LISTA DE AJUSTES RIESGOS GENERALES");
    //html_notificacion = html_notificacion.Replace("{URLTOREDIRECT}", ConfigurationManager.AppSettings["ApplicationInstallURL"] + "vListaAjuste.aspx");
    html_notificacion = html_notificacion.Replace("{URLTOREDIRECT}", R3M.Common.Util.ResolveURL("./vListaAjuste.aspx"));


    return html_notificacion;



  }

  public static Boolean notificarInformes(Decimal AjusteId,
                                          String CodigoGenerado,
                                            String Codigo,
                                            String asunto,
                                            String Cuerpo,
                                            DateTime fechaEnvio,
                                            String path)
  {

    FileInfo f = new FileInfo(path);

    Contacto contactoAseguradora = GestorAjuste.dameContactoAseguradora(AjusteId);
    Contacto contactoBroker = GestorAjuste.dameContactoBroker(AjusteId);

    String to = "";

    String from = ConfigurationManager.AppSettings["correoAdministrador"];

    String cc = ConfigurationManager.AppSettings["correoAdministrador"];

    string codigoAux = "R_ATCH_" + Codigo.Substring(Codigo.IndexOf('_') + 1);

    if ((recibirNotificacionAseguradora(AjusteId, Codigo)) && (recibirNotificacionAseguradora(AjusteId, codigoAux)))
    {

      to = contactoAseguradora.Email;
      if (recibirNotificacionBroker(AjusteId, codigoAux))
      {
        cc += "," + contactoBroker.Email;
      }


      return enviaNotificacion(CodigoGenerado + "_attch", from, to, cc, asunto, Cuerpo, f, fechaEnvio);
    }
    else
    {
      if ((recibirNotificacionAseguradora(AjusteId, Codigo)))
      {

        to = contactoAseguradora.Email;
        if (recibirNotificacionBroker(AjusteId, Codigo))
        {
          cc += "," + contactoBroker.Email;
        }
        return enviaNotificacion(CodigoGenerado, from, to, cc, asunto, Cuerpo, null, fechaEnvio);
      }
      return false;
    }

  }



  #region getBinaryFromFile
  public static byte[] getBinaryFromFile(FileInfo f)
  {
    byte[] buffer = null;
    if (f.Exists)
    {
      try
      {
        buffer = new byte[f.OpenRead().Length];
        f.OpenRead().Read(buffer, 0, (int)f.OpenRead().Length);
      }
      catch (Exception ex)
      {

      }
    }
    return buffer;
  }
  #endregion

  #region getFromDB
  public static String getFromDB(decimal ajusteId, string tInforme)
  {
    /*SERVER PATH SOLO CON EL NOMBRE QUE OBTIENE DE LA BASE DE DATOS*/

    dsInformesTableAdapters.InformeListaTableAdapter informeAdapter = new dsInformesTableAdapters.InformeListaTableAdapter();

    //primero ubico q informe es el que estamos buscando
    decimal informeId = (decimal)informeAdapter.InformeTipo(ajusteId, tInforme);

    //obtengo el nombre del informe
    try
    {
      dsInformes.InformeListaDataTable informeTableAux = (dsInformes.InformeListaDataTable)informeAdapter.GetDataInforme(ajusteId, informeId);
      dsInformes.InformeListaRow informeRowAux = (dsInformes.InformeListaRow)informeTableAux.Rows[0];

      return informeRowAux.nombre;
    }
    catch
    {
      return null;
    }

  }
  #endregion




  public static bool cancelAllRequest(int? ajusteId)
  {
    try
    {
      if (ajusteId != null)
      {
        //int? sistemaId = 1;
        //GoNote.Service notificador = new GoNote.Service();
        //notificador.Url = ConfigurationManager.AppSettings["GoNote.Service"];
        ////Este metodo hay que usarlo con cuidado, los codigos deben siempre 
        ////terminar con el codigo identificador unico. 
        ////Ejm: my_codigo_autogenerado_321 en este caso el identificador unico es 321, por tanto 
        //return notificador.CancelarTodosLosRequest(ajusteId.ToString(), sistemaId);
        //throw new Exception("GONOTE.SERVICE IS DISABLED");
        return true;
      }
      return false;

    }
    catch
    {
      return false;
    }

  }
}
