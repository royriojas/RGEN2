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
using System.Collections.Specialized;
using System.Net.Mail;
using System.Net.Mime;
using System.Net;
using System.Text.RegularExpressions;

namespace RGen.Utiles
{
  /// <summary>
  /// Summary description for RGenMailer
  /// </summary>
  public class RGenMailer
  {
    public event EventHandler MailSended;
    public String correoAdministrador;

    public static String AdminEmail = ConfigurationManager.AppSettings["correoAdministrador"];

    public RGenMailer()
    {
      correoAdministrador = ConfigurationManager.AppSettings["correoAdministrador"];
    }


    public static Boolean SendMessage(String To, String Subject, String Body, String attachmnt_url)
    {
      string file = attachmnt_url;

      //string direcciones = getDireccionesDeEnvio(para);
      if (ValidEmailAddress(To))
      {
        System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage(AdminEmail, To.Replace(";", ","), Subject, Body);

        message.IsBodyHtml = true;
        message.Priority = MailPriority.Normal;
        //message.

        // Create  the file attachment for this e-mail message.
        Attachment data = new Attachment(file, MediaTypeNames.Application.Octet);
        // Add time stamp information for the file.
        ContentDisposition disposition = data.ContentDisposition;
        disposition.CreationDate = System.IO.File.GetCreationTime(file);
        disposition.ModificationDate = System.IO.File.GetLastWriteTime(file);
        disposition.ReadDate = System.IO.File.GetLastAccessTime(file);
        // Add the file attachment to this e-mail message.
        message.Attachments.Add(data);
        //Send the message.

        SmtpClient client = new SmtpClient();
        client.Credentials = CredentialCache.DefaultNetworkCredentials;
        Boolean SendComplete = false;
        try
        {
          client.Send(message);
          SendComplete = true;
        }
        catch (Exception e)
        {
          LoggerFacade.Log(e);
        }
        finally
        {
          if (data != null) data.Dispose();
        }

        return SendComplete;
      }
      return false;

    }



    private static bool ValidEmailAddress(string To)
    {

      String[] ToEmailAddress = To.Split(',', ';');

      foreach (String email in ToEmailAddress)
      {
        if (!ValidEmail(email)) return false;
      }

      return true;

    }


    public String getDireccionesDeEnvio(ArrayList para)
    {
      String cadena = "";
      int contador = 0;
      foreach (String s in para)
      {
        if (isValidEmail(s))
        {
          if (contador > 0)
          {
            cadena += ",";
          }
          cadena += s;
          contador++;
        }
      }
      return (cadena.Length > 0) ? cadena : null;
    }


    private static bool ValidEmail(String email)
    {
      return (email.IndexOf(".") > 2) && (email.IndexOf("@") > 0);
    }

    private bool isValidEmail(string str)
    {
      return (str.IndexOf(".") > 2) && (str.IndexOf("@") > 0);
    }
    public void enviaMensajeConAttachment(ArrayList para, String Subject, String Body, String attachmnt_url)
    {


      string file = attachmnt_url;

      string direcciones = getDireccionesDeEnvio(para);

      if (direcciones != null)
      {



        System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage(correoAdministrador, direcciones, Subject, Body);

        message.IsBodyHtml = true;
        message.Priority = MailPriority.Normal;
        //message.

        // Create  the file attachment for this e-mail message.
        Attachment data = new Attachment(file, MediaTypeNames.Application.Octet);
        // Add time stamp information for the file.
        ContentDisposition disposition = data.ContentDisposition;
        disposition.CreationDate = System.IO.File.GetCreationTime(file);
        disposition.ModificationDate = System.IO.File.GetLastWriteTime(file);
        disposition.ReadDate = System.IO.File.GetLastAccessTime(file);
        // Add the file attachment to this e-mail message.
        message.Attachments.Add(data);
        //Send the message.

        SmtpClient client = new SmtpClient();
        client.Credentials = CredentialCache.DefaultNetworkCredentials;

        client.EnableSsl = (ConfigurationManager.AppSettings["UseSSLForEmail"] == "true");


        //client.SendCompleted += new SendCompletedEventHandler(client_SendCompleted);

        try
        {
          client.Send(message);
        }
        catch (Exception e)
        {
          LoggerFacade.Log(e);
        }






        data.Dispose();


      }

    }

    void client_SendCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
    {
      if (MailSended != null)
      {
        MailSended(sender, new EventArgs());
      }
    }
    public void enviaMensaje(ArrayList para, String Subject, String Body)
    {
      System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage(correoAdministrador, getDireccionesDeEnvio(para), Subject, Body);

      message.IsBodyHtml = true;
      message.Priority = MailPriority.Normal;
      //message.

      SmtpClient client = new SmtpClient();

      client.Send(message);

    }
    public void enviaMensaje(String para, String Subject, String Body)
    {
      System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage(correoAdministrador, para, Subject, Body);

      message.IsBodyHtml = true;
      message.Priority = MailPriority.Normal;
      //message.

      SmtpClient client = new SmtpClient();

      client.Send(message);
    }





  }

}