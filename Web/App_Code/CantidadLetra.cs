using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


namespace R3M.Common
{
  /// <summary>
  /// Summary description for CantidadLetra
  /// </summary>
  public class CantidadLetra
  {
    private string[] sUnidades = {"", "un", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez", 
									"once", "doce", "trece", "catorce", "quince", "dieciseis", "diecisiete", "dieciocho", "diecinueve", "veinte", 
									"veintiún", "veintidos", "veintitres", "veinticuatro", "veinticinco", "veintiseis", "veintisiete", "veintiocho", "veintinueve"};

    private string[] sDecenas = { "", "diez", "veinte", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa" };

    private string[] sCentenas = { "", "cien", "ciento", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos" };


    private string sResultado = "";


    public string ConvertirCadena(string sNumero)
    {
      double dNumero;
      double dNumAux = 0;
      char x;
      string sAux;

      sResultado = " ";
      try
      {
        dNumero = Convert.ToDouble(sNumero);
      }
      catch
      {
        return "";
      }

      if (dNumero > 999999999999)
        return "";

      if (dNumero > 999999999)
      {
        dNumAux = dNumero % 1000000000000;
        sResultado += Numeros(dNumAux, 1000000000) + " mil ";
      }

      if (dNumero > 999999)
      {
        dNumAux = dNumero % 1000000000;
        sResultado += Numeros(dNumAux, 1000000) + " millones ";
      }

      if (dNumero > 999)
      {
        dNumAux = dNumero % 1000000;
        sResultado += Numeros(dNumAux, 1000) + " mil ";
      }

      dNumAux = dNumero % 1000;
      sResultado += Numeros(dNumAux, 1);


      //Enseguida verificamos si contiene punto, si es así, los convertimos a texto.
      sAux = dNumero.ToString();

      if (sAux.IndexOf(".") >= 0)
        sResultado += ObtenerDecimales(sAux);

      //Las siguientes líneas convierten el primer caracter a mayúscula.
      sAux = sResultado;
      x = char.ToUpper(sResultado[1]);
      sResultado = x.ToString();

      for (int i = 2; i < sAux.Length; i++)
        sResultado += sAux[i].ToString();

      return sResultado;
    }


    public string ConvertirCadena(double dNumero)
    {
      double dNumAux = 0;
      char x;
      string sAux;

      sResultado = " ";

      if (dNumero > 999999999999)
        return "";

      if (dNumero > 999999999)
      {
        dNumAux = dNumero % 1000000000000;
        sResultado += Numeros(dNumAux, 1000000000) + " mil ";
      }

      if (dNumero > 999999)
      {
        dNumAux = dNumero % 1000000000;
        sResultado += Numeros(dNumAux, 1000000) + " millones ";
      }

      if (dNumero > 999)
      {
        dNumAux = dNumero % 1000000;
        sResultado += Numeros(dNumAux, 1000) + " mil ";
      }

      dNumAux = dNumero % 1000;
      sResultado += Numeros(dNumAux, 1);


      //Enseguida verificamos si contiene punto, si es así, los convertimos a texto.
      sAux = dNumero.ToString();

      if (sAux.IndexOf(".") >= 0)
        sResultado += ObtenerDecimales(sAux);

      //Las siguientes líneas convierten el primer caracter a mayúscula.
      sAux = sResultado;
      x = char.ToUpper(sResultado[1]);
      sResultado = x.ToString();

      for (int i = 2; i < sAux.Length; i++)
        sResultado += sAux[i].ToString();

      return sResultado;
    }


    private string Numeros(double dNumAux, double dFactor)
    {
      double dCociente = dNumAux / dFactor;
      double dNumero = 0;
      int iNumero = 0;
      string sNumero = "";
      string sTexto = "";

      //			MessageBox.Show(dNumAux.ToString(), "NumAux", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
      //			MessageBox.Show(dCociente.ToString(), "Cociente", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
      //if (dCociente >= 100)
      //{
      //  //MessageBox.Show("Son centenas de millon", "", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
      //  dNumero = dCociente / 100;
      //  sNumero = dNumero.ToString();
      //  //				MessageBox.Show(sNumero.ToString(), "sNumero Centenas", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
      //  iNumero = int.Parse(sNumero[0].ToString());
      //  //				MessageBox.Show(iNumero.ToString(), "iNumero Centenas", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
      //  sTexto += this.sCentenas[iNumero] + " ";
      //}

      if (dCociente == 100)
      {
        dNumero = dCociente / 100;
        sNumero = dNumero.ToString();
        iNumero = int.Parse(sNumero[0].ToString());
        sTexto += this.sCentenas[iNumero] + " ";
      }
      if (dCociente > 100)
      {
        dNumero = dCociente / 100;
        sNumero = dNumero.ToString();
        iNumero = int.Parse(sNumero[0].ToString());
        sTexto += this.sCentenas[iNumero + 1] + " ";
      }

      dCociente = dCociente % 100;
      if (dCociente >= 30)
      {
        dNumero = dCociente / 10;
        sNumero = dNumero.ToString();
        iNumero = int.Parse(sNumero[0].ToString());
        if (iNumero > 0)
          sTexto += this.sDecenas[iNumero] + " ";

        dNumero = dCociente % 10;
        sNumero = dNumero.ToString();
        iNumero = int.Parse(sNumero[0].ToString());
        if (iNumero > 0)
          sTexto += "y " + this.sUnidades[iNumero] + " ";
      }

      else
      {
        dNumero = dCociente;
        //				MessageBox.Show(dCociente.ToString(), "dCociente Unidades", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
        sNumero = dNumero.ToString();
        //				MessageBox.Show(sNumero.ToString(), "sNumero Unidades", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
        if (sNumero.Length > 1)
          if (sNumero[1] != '.')
            iNumero = int.Parse(sNumero[0].ToString() + sNumero[1].ToString());
          else
            iNumero = int.Parse(sNumero[0].ToString());
        else
          iNumero = int.Parse(sNumero[0].ToString());
        //				MessageBox.Show(iNumero.ToString(), "iNumero Unidades", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
        sTexto += this.sUnidades[iNumero] + " ";
      }

      //			MessageBox.Show(sTexto, "sTexto", MessageBoxButtons.OK, MessageBoxIcon.None, MessageBoxDefaultButton.Button1);
      return sTexto;
    }

    private string ObtenerDecimales(string sNumero)
    {
      string[] sNumPuntos;
      string sTexto = "";
      double dNumero = 0;

      sNumPuntos = sNumero.Split('.');

      //			if (sNumPuntos[1].Length > 3)
      //				sNumPuntos[1] = sNumPuntos[1].Remove (3, sNumPuntos[1].Length -3);

      dNumero = Convert.ToDouble(sNumPuntos[1]);
      sTexto = "punto " + Numeros(dNumero, 1);

      return sTexto;
    }
  }
}