using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using R3M.Common;

public partial class InformesPlantillas_InformePreliminarRimac : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected decimal AjusteId
    {
        get { return Convert.ToDecimal(Util.XDefault(Request.QueryString["AjusteId"], "-1")); }

    }

    protected bool IsComplementary
    {
        get { return Request.QueryString["TI"] == "IC"; }

    }



    protected void DoDataBound(object sender, EventArgs e)
    {
        HtmlGenericControl groupIPreliminar = FormViewInforme.FindControl("_groupIPreliminar") as HtmlGenericControl;
        if (groupIPreliminar != null)
        {
            groupIPreliminar.Visible = !IsComplementary;
        }
        HtmlGenericControl groupIPreliminar2 = FormViewInforme.FindControl("_groupIPreliminar2") as HtmlGenericControl;
        if (groupIPreliminar2 != null)
        {
            groupIPreliminar2.Visible = !IsComplementary && groupIPreliminar2.Visible;
        }
        HtmlGenericControl groupIComplementario = FormViewInforme.FindControl("_groupIComplementario") as HtmlGenericControl;
        if (groupIComplementario != null)
        {
            groupIComplementario.Visible = IsComplementary;
        } HtmlGenericControl groupIComplementario2 = FormViewInforme.FindControl("_groupIComplementario2") as HtmlGenericControl;
        if (groupIComplementario2 != null)
        {
            groupIComplementario2.Visible = IsComplementary;
        }




    }


    protected void DoEmpty(object sender, EventArgs e)
    {
        //_groupIPreliminar2
        HtmlGenericControl groupIPreliminar2 = FormViewInforme.FindControl("_groupIPreliminar2") as HtmlGenericControl;
        if (groupIPreliminar2 != null)
        {
            groupIPreliminar2.Visible = false;
        }
    }

    protected void OnEmptyDocuments(object sender, EventArgs e)
    {
        HtmlGenericControl documentosSeccion = FormViewInforme.FindControl("_documentosSeccion") as HtmlGenericControl;
        if (documentosSeccion != null)
        {
            documentosSeccion.Visible = false;
        }
    }

    protected void EmptyClausulas(object sender, EventArgs e)
    {
        HtmlGenericControl clausulasDiv = FormViewInforme.FindControl("_clausulasDiv") as HtmlGenericControl;
        if (clausulasDiv != null)
        {
            clausulasDiv.Visible = false;
        }
    }

    protected void EmptyDeducibles(object sender, EventArgs e)
    {
       
        HtmlGenericControl deduciblesDiv = FormViewInforme.FindControl("_deduciblesDiv") as HtmlGenericControl;
        if (deduciblesDiv != null)
        {
            deduciblesDiv.Visible = false;
        }
    }

    protected void EmptyDamage(object sender, EventArgs e)
    {
       
        HtmlGenericControl damageDiv = FormViewInforme.FindControl("_damageDiv") as HtmlGenericControl;
        if (damageDiv != null)
        {
            damageDiv.Visible = false;
        }
    }

    protected void EmptyTitulosAdicionalesComplementario(object sender, EventArgs e)
    {

        HtmlGenericControl titulosDiv = FormViewInforme.FindControl("_titulosDiv") as HtmlGenericControl;
        if (titulosDiv != null)
        {
            titulosDiv.Visible = false;
        }
    }

    protected void EmptyTitulosAdicionalesPreliminar(object sender, EventArgs e)
    {

        HtmlGenericControl titulosPreliminarDiv = FormViewInforme.FindControl("_titulosPreliminarDiv") as HtmlGenericControl;
        if (titulosPreliminarDiv != null)
        {
            titulosPreliminarDiv.Visible = false;
        }
    }
}
