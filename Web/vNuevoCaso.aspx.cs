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

public partial class vNuevoCaso : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }
  protected void LinkButton1_Click(object sender, EventArgs e)
  {
    this.FormView1.InsertItem(true);
  }
  protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    DropDownList ddl = ((DropDownList)this.FormView1.FindControl("DropDownList3"));
    if (ddl != null)
      e.Values["TipoSiniestroId"] = ddl.SelectedValue;

    DropDownList cbxProducto = ((DropDownList)this.FormView1.FindControl("cbxProducto"));
    if (cbxProducto != null)
      e.Values["productoId"] = cbxProducto.SelectedValue;

    DropDownList cbxRamo = ((DropDownList)this.FormView1.FindControl("cbxRamo"));
    if (cbxRamo != null)
      e.Values["ramoId"] = cbxRamo.SelectedValue;

    DropDownList cbxCobertura = ((DropDownList)this.FormView1.FindControl("cbxCobertura"));
    if (cbxCobertura != null)
      e.Values["riesgoId"] = cbxCobertura.SelectedValue;


    e.Values["ucrea"] = String.Format("{0}", Session["usuario"]);


  }
  protected void LinkButton1_Click1(object sender, EventArgs e)
  {
    this.FormView1.InsertItem(true);
  }
  protected void AjaxPanel1_AjaxCallEnd(object sender, EventArgs e)
  {

    MagicAjax.AjaxCallHelper.WriteLine("rewire();");

  }
  protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
  {
    args.IsValid = R3M.Common.Util.IsValidDateTime(args.Value);
  }
  protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
  {
    //Response.Redirect("vListaAjuste.aspx");
  }
  protected void DropDownList1_DataBound(object sender, EventArgs e)
  {

    RGen.Utiles.AtribucionesUsuario au;
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

    String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

    DropDownList ddl = (DropDownList)sender;
    ddl.ClearSelection();
    ListItem li = ddl.Items.FindByValue(valueToFind);

    if (li != null)
    {
      li.Selected = true;
      ddl.Enabled = false;
    }

  }
  protected void ddlAjustador_DataBound(object sender, EventArgs e)
  {
    RGen.Utiles.AtribucionesUsuario au;
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

    String valueToFind = au.UserId;

    DropDownList ddl = (DropDownList)sender;
    ddl.ClearSelection();
    ListItem li = ddl.Items.FindByValue(valueToFind);

    if (li != null)
    {
      li.Selected = true;
    }
    else
    {
      li = ddl.Items.FindByValue("46");
      li.Selected = true;
    }

  }

  protected void DropDownList3_DataBound(object sender, EventArgs e)
  {
    DropDownList ddl = ((DropDownList)this.FormView1.FindControl("DropDownList3"));
    if (ddl != null) ddl.Items.Insert(0, new ListItem("[Elija]", "-1"));
  }
  protected void odsAjusteNew_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
  {
    if (e.Exception == null)
    {
      this.pnlMesage.InnerHtml = String.Format("<p>El caso de Ajuste ha sido registrado satisfactoriamente con el número <a style='text-decoration:underline' href='{0}'> {1} </a> </p>", String.Format("vEditorCasoAjuste.aspx?AjusteId={0}", e.OutputParameters["ajusteId"]), e.OutputParameters["numeroAjuste"]);
      this.pnlMesage.Visible = true;
    }
    else
    {
      this.pnlMesage.InnerHtml = String.Format("<p>{0}</p>", e.Exception.Message);
      this.pnlMesage.Visible = true;
    }
  }



  protected void cbxRamo_DataBound(object sender, EventArgs e)
  {
    DropDownList ddl = ((DropDownList)this.FormView1.FindControl("cbxRamo"));
    if (ddl != null) ddl.Items.Insert(0, new ListItem("[Elija]", "-1"));
  }
  protected void cbxCobertura_DataBound(object sender, EventArgs e)
  {
    DropDownList ddl = ((DropDownList)this.FormView1.FindControl("cbxCobertura"));
    if (ddl != null) ddl.Items.Insert(0, new ListItem("[Elija]", "-1"));
  }
}
