using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using RGen.Utiles;

public partial class vNuevoAseguradoRapido : System.Web.UI.Page
{
    private AtribucionesUsuario au = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        au = (AtribucionesUsuario)Session["datosUsuario"];

        //CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + this.Request.RawUrl);


    }


    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (au != null)
        {
            e.Values.Add("ucrea", au.UserName);

        }
        //e.Values.Add("chkPersonaJuridica", true);
    }
    protected void sdsAseguradoFRM_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {

        this.hdfAseguradoId.Value = e.Command.Parameters["@personaId"].Value.ToString();
        this.hdfAsegurado.Value = ((TextBox)this.FormView1.FindControl("PrimerNombreTextBox")).Text;

        this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "callParent", " xAddEventListener(window,'load',copyValues);", true);
    }
}
