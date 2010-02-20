using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



using ASB;
using System.Collections.Generic;

public partial class GetAutoSuggestData : System.Web.UI.Page
{
    private string msTextBoxID;
    private string msMenuDivID;
    private string msDataType;
    private int mnNumMenuItems;
    private bool mbIncludeMoreMenuItem;
    private string msMenuItemCSSClass;
	private string msMoreMenuItemLabel;
    private string msKeyword;
    private List<String> msFilters;
    private Boolean msOnFocusShowAll;

    //Generate menu and return it
    private void Page_Load(object sender, System.EventArgs e)
    {
        //Turn off cache
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        msTextBoxID             = Request.QueryString["TextBoxID"];
        msMenuDivID             = Request.QueryString["MenuDivID"];
        msDataType              = Request.QueryString["DataType"];
        mnNumMenuItems          = Convert.ToInt32(Request.QueryString["NumMenuItems"]);
        mbIncludeMoreMenuItem   = Convert.ToBoolean(Request.QueryString["IncludeMoreMenuItem"]);
        msMoreMenuItemLabel     = Request.QueryString["MoreMenuItemLabel"];
        msMenuItemCSSClass      = Request.QueryString["MenuItemCSSClass"];
		msKeyword               = Request.QueryString["Keyword"];


        //RRRM - 13-08-2006
        //la combinación de campos de DATATYPE y FILTERS nos permite manejar el caso que se quiera hacer un select filtrando algo por algunos criterios
        //queda de todos modos bajo criterio del programador conocer el orden de los parámetros y el tipo de los mismos.
        this.msFilters = new List<string>();
        if (!String.IsNullOrEmpty(Request.QueryString["Filters"]))
        {
            String[] tempFilters = Request.QueryString["Filters"].Trim().Split(new char[] { ',', ';', '|' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (String s in tempFilters)
            {
                this.msFilters.Add(s);
            }
        }

        msOnFocusShowAll = Convert.ToBoolean(Request.QueryString["OnFocusShowAll"]);




        //Get menu item labels and values
        ArrayList aMenuItems = LoadMenuItems();
        
        //Generate html and write it to the page
        string sHtml = AutoSuggestBox.GenMenuItemsHtml(aMenuItems,
                                                        msTextBoxID,
                                                        mnNumMenuItems,
                                                        mbIncludeMoreMenuItem,
                                                        msMoreMenuItemLabel,
                                                        msMenuItemCSSClass);
        Response.Write(sHtml);
    }


    /// <summary>Get all cities that contain specified keyword</summary>
    /// <param name="sKeyword">Keyword to use in a query</param>
    /// <returns></returns>
    private ArrayList LoadCities()
    {
        ArrayList aOut = new ArrayList();

        string sConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=c:\\databases\\AutoSuggestBox_Demo.mdb;User Id=admin;Password=;";
        OleDbConnection oCn = new OleDbConnection(sConnString);

        //Return only specified number of results plus one more
        //Need one more to see if there are more results to display 'more' menu item
        string sSql = "SELECT TOP " + (mnNumMenuItems + 1) + " tblCity.Name as CityName, " +
            "tblCity.Code as CityCode, " +
            "tblCountry.Name as CountryName, " +
            "tblState.Name as StateName " +
            " FROM (tblCity INNER JOIN tblCountry ON tblCity.CountryID=tblCountry.ID) " +
            "		LEFT OUTER JOIN tblState ON tblCity.StateID=tblState.ID " +
            " WHERE (tblCity.Name LIKE '" + msKeyword.Replace("'", "''") + "%') " +
            " ORDER BY tblCity.Name";

        OleDbCommand oCmd = new OleDbCommand(sSql, oCn);
        oCn.Open();

        OleDbDataReader oReader = oCmd.ExecuteReader();

        string sCity;
        string sCityCode;
        string sState;
        string sCountry;

        string sLabel;

        ASBMenuItem oMenuItem;

        while (oReader.Read())
        {
            //Build label using City, Country & State
            sCity = oReader.GetString(0);
            sCityCode = oReader.GetString(1);
            sCountry = oReader.GetString(2);

            if (oReader.GetValue(3) == System.DBNull.Value)
                sState = "";
            else
                sState = oReader.GetString(3);


            sLabel = sCity;

            //Append either city or country
            if (sState != "")
                sLabel += ", " + sState;
            else
                sLabel += ", " + sCountry;

            oMenuItem = new ASBMenuItem();
            oMenuItem.Label = sLabel;
            oMenuItem.Value = sCityCode;

            aOut.Add(oMenuItem);
        }

        oReader.Close();
        oCn.Close();

        return aOut;
    }

    private ArrayList loadUbigeo()
    {
        ArrayList aOut = new ArrayList();

        dsUbigeoTableAdapters.UBIGEOTableAdapter ubigeoTA = new dsUbigeoTableAdapters.UBIGEOTableAdapter();
        dsUbigeo.UBIGEODataTable ubigeoDataTable = ubigeoTA.GetData( msKeyword.Replace("'", "''"));
               
        ASBMenuItem oMenuItem;

        foreach (dsUbigeo.UBIGEORow distrito in ubigeoDataTable) 
        {
            oMenuItem = new ASBMenuItem();
            oMenuItem.Label = distrito.ubigeo;
            oMenuItem.Value = distrito.ubigeoId;

            aOut.Add(oMenuItem);

        }
        
        return aOut;
        
    }

    private ArrayList loadTipoActividad()
    {
        ArrayList aOut = new ArrayList();

        /*
        dsUbigeoTableAdapters.UBIGEOTableAdapter ubigeoTA = new dsUbigeoTableAdapters.UBIGEOTableAdapter();
        dsUbigeo.UBIGEODataTable ubigeoDataTable = ubigeoTA.GetData(msKeyword.Replace("'", "''"));
        */

        dsTipoActividadTableAdapters.TipoActividadTableAdapter tipoActividadTA = new dsTipoActividadTableAdapters.TipoActividadTableAdapter();
        dsTipoActividad.TipoActividadDataTable tipoActividadDT = tipoActividadTA.GetData(msKeyword.Replace("'","''"));


        
        ASBMenuItem oMenuItem;

        foreach (dsTipoActividad.TipoActividadRow tipoActividadRow in tipoActividadDT)
        {
            oMenuItem = new ASBMenuItem();
            oMenuItem.Label = tipoActividadRow.TipoActividad;
            oMenuItem.Value = tipoActividadRow.tipoActividadId.ToString();

            aOut.Add(oMenuItem);

        }
        
        return aOut;
        
    }
    private ArrayList loadTipoSiniestro()
    {
        ArrayList aOut = new ArrayList();

        dsComboTableAdapters.TipoSiniestroPorNombreTableAdapter asTa = new dsComboTableAdapters.TipoSiniestroPorNombreTableAdapter();
        dsCombo.TipoSiniestroPorNombreDataTable asDt = asTa.GetData(msKeyword.Replace("'", "''"));

        ASBMenuItem oMenuItem;

        foreach (dsCombo.TipoSiniestroPorNombreRow fila in asDt)
        {
            oMenuItem = new ASBMenuItem();
            oMenuItem.Label = fila.tipoSiniestro;
            oMenuItem.Value = fila.tipoSiniestroId.ToString();

            aOut.Add(oMenuItem);

        }

        return aOut;

    }
    private ArrayList loadBrokers()
    {
        ArrayList aOut = new ArrayList();

        /*
        dsComboTableAdapters.brokerPorNombreTableAdapter asTa = new dsComboTableAdapters.brokerPorNombreTableAdapter();
        dsCombo.brokerPorNombreDataTable asDt = asTa.GetData(msKeyword.Replace("'", "''"));
        */

        dsAutoCompletesTableAdapters.BrokerAutoCompleteTableAdapter brokerTa = new dsAutoCompletesTableAdapters.BrokerAutoCompleteTableAdapter();
        dsAutoCompletes.BrokerAutoCompleteDataTable brokerDt = brokerTa.GetData(msKeyword.Replace("'", "''"), this.mnNumMenuItems);

        ASBMenuItem oMenuItem;

        foreach (dsAutoCompletes.BrokerAutoCompleteRow fila in brokerDt)
        {
            oMenuItem = new ASBMenuItem();
            oMenuItem.Label = fila.persona;
            oMenuItem.Value = fila.personaId.ToString();

            aOut.Add(oMenuItem);

        }

        return aOut;
    }
    private ArrayList loadEjecutivos()
    {
        ArrayList aOut = new ArrayList();

        if (this.msFilters[0] == "-1")
        {
            ASBMenuItem oMenuItem;
            oMenuItem = new ASBMenuItem();
            oMenuItem.Label = "Debe elegir una Aseguradora primero";
            oMenuItem.Value = "";
            oMenuItem.IsSelectable = false;
            aOut.Add(oMenuItem);
        }
        else
        {         
            /*
            dsComboTableAdapters.brokerPorNombreTableAdapter asTa = new dsComboTableAdapters.brokerPorNombreTableAdapter();
            dsCombo.brokerPorNombreDataTable asDt = asTa.GetData(msKeyword.Replace("'", "''"));
            */

            dsAutoCompletesTableAdapters.EjecutivoAutoCompleteTableAdapter EjecutivoTa = new dsAutoCompletesTableAdapters.EjecutivoAutoCompleteTableAdapter();
            dsAutoCompletes.EjecutivoAutoCompleteDataTable EjecutivoDt = EjecutivoTa.GetData(msKeyword.Replace("'", "''"), Convert.ToDecimal(this.msFilters[0]), this.mnNumMenuItems);

            ASBMenuItem oMenuItem;

            foreach (dsAutoCompletes.EjecutivoAutoCompleteRow fila in EjecutivoDt)
            {
                oMenuItem = new ASBMenuItem();
                oMenuItem.Label = fila.persona;
                oMenuItem.Value = fila.personaId.ToString();

                aOut.Add(oMenuItem);

            }
        }
        return aOut;

    }
    private ArrayList loadAsegurados()
    {
        ArrayList aOut = new ArrayList();

        dsComboTableAdapters.AseguradoPorNombreTableAdapter asTa = new dsComboTableAdapters.AseguradoPorNombreTableAdapter();
        dsCombo.AseguradoPorNombreDataTable asDt = asTa.GetData(msKeyword.Replace("'", "''"));

        ASBMenuItem oMenuItem;

        foreach (dsCombo.AseguradoPorNombreRow fila in asDt)
        {
            oMenuItem = new ASBMenuItem();
            oMenuItem.Label = fila.persona;
            oMenuItem.Value = fila.personaid.ToString();

            aOut.Add(oMenuItem);

        }

        return aOut;

    }

    private ArrayList loadCompanias()
    {
      ArrayList aOut = new ArrayList();

      dsAutoCompletesTableAdapters.companiasAutoCompleteByPersonNameTableAdapter companiasTa = new dsAutoCompletesTableAdapters.companiasAutoCompleteByPersonNameTableAdapter();
      dsAutoCompletes.companiasAutoCompleteByPersonNameDataTable companiasDt = companiasTa.GetData(msKeyword.Replace("'", "''"));


      ASBMenuItem oMenuItem;

      foreach (dsAutoCompletes.companiasAutoCompleteByPersonNameRow fila in companiasDt)
      {
        oMenuItem = new ASBMenuItem();
        oMenuItem.Label = fila.persona;
        oMenuItem.Value = fila.personaId.ToString();

        aOut.Add(oMenuItem);

      }

      return aOut;

    }    

    /// <summary>Load array of ASBMenuItems for a specific data type</summary>
    /// <param name="sDataType"></param>
    /// <param name="sKeyword"></param>
    /// <returns></returns>
    private ArrayList LoadMenuItems()
    {
        ArrayList aMenuItems;

        switch (msDataType)
        {
            case "City":
                aMenuItems = LoadCities();
                break;
            case "Distrito" :
                aMenuItems = this.loadUbigeo();
                break;
            case "TipoActividad":
                aMenuItems = this.loadTipoActividad();
                break;
            case "Asegurado":
                aMenuItems = this.loadAsegurados();
                break;
            case "Broker" :
                aMenuItems = this.loadBrokers();
                break;
            case "TipoSiniestro":
                aMenuItems = this.loadTipoSiniestro();
                break;
            case "Ejecutivo" :
                aMenuItems = this.loadEjecutivos();
                break;
            case "Companias":
                aMenuItems = this.loadCompanias();
                break;
            default:
                throw new Exception("GetAutoSuggestData  Type '" + msDataType + "' is not supported.");
        }
        
        return aMenuItems;
    }
   
}
