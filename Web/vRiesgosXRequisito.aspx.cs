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

public partial class vRiesgosXRequisito : System.Web.UI.Page
{
  private RGen.Utiles.AtribucionesUsuario au;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (verificaCasoDeUso())
    {
      String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
      if (noShowBtn == "true")
      {
        this.lnkSeparar.Visible = false;
      }

      if (Request.QueryString["action"] == "editar")
      {
        this.FormView1.DefaultMode =
            ((Request.QueryString["requisitoId"] != null) && (Request.QueryString["requisitoId"] != "")) ? FormViewMode.Edit : FormViewMode.Insert;
        this.pnlGrilla.Visible = !((Request.QueryString["requisitoId"] != null) && (Request.QueryString["requisitoId"] != ""));
        this.divNuevoItem.Style.Value = "display:block";
        this.lblTitulo.Text = "Editar Requisito";

      }
      else
      {
        if (!IsPostBack)
        {
          this.FormView1.DefaultMode = FormViewMode.Insert;
          this.pnlGrilla.Visible = true;
          this.FormView1.Visible = true;
          this.Panel1.Visible = true;
          this.GridView1.DataBind();
        }
      }
    }
    else
    {
      String urlActual = Request.Url.ToString();
      Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
    }
  }
  protected bool verificaCasoDeUso()
  {
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
    return (au != null);
    //return true;
  }
  protected void cbxRiesgo_DataBound(object sender, EventArgs e)
  {
    RGen.Utiles.utilidades.addItemTodos(sender, "[TODOS]", "-1", IsPostBack);
  }
  protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
  {
    this.actualizaAsociaciones();
    Response.Redirect("vRiesgosxRequisito.aspx?action=mostrar");
  }

  private void actualizaAsociaciones()
  {
    int numFilas = this.GridView2.Rows.Count;
    if (numFilas > 0)
    {
      for (int i = 0; i < numFilas; i++)
      {
        CheckBox AuxCheckBox = (CheckBox)GridView2.Rows[i].FindControl("chk");

        if (AuxCheckBox.Checked)
        {
          sdsRiesgoDelRequisito.InsertParameters.Clear();
          sdsRiesgoDelRequisito.InsertParameters.Add("requisitoId", TypeCode.Decimal, Request.QueryString["requisitoId"]);
          sdsRiesgoDelRequisito.InsertParameters.Add("ramoId", TypeCode.Decimal, Convert.ToString(this.GridView2.Rows[i].Cells[1].Text));
          sdsRiesgoDelRequisito.Insert();
        }
        else
        {
          sdsRiesgoDelRequisito.DeleteParameters.Clear();
          sdsRiesgoDelRequisito.DeleteParameters.Add("requisitoId", TypeCode.Decimal, Request.QueryString["requisitoId"]);
          sdsRiesgoDelRequisito.DeleteParameters.Add("ramoId", TypeCode.Decimal, Convert.ToString(this.GridView2.Rows[i].Cells[1].Text));
          sdsRiesgoDelRequisito.Delete();
        }
      }
    }

  }
  protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    if (au != null)
    {

      this.sdsRequisito.InsertParameters.Add("ucrea", TypeCode.String, au.UserName);

    }

  }

  protected void sdsRequisito_Inserted(object sender, SqlDataSourceStatusEventArgs e)
  {
    String requisitoId = (e.Command.Parameters["@requisitoId"].Value).ToString();

    if (requisitoId != "")
    {
      Response.Redirect("vRiesgosXRequisito.aspx?action=editar&requisitoId=" + requisitoId);
    }
  }
  protected void sdsRequisito_Inserting(object sender, SqlDataSourceCommandEventArgs e)
  {
    utiles.debugClass.muestra(e.Command, Server.MapPath("log.txt"));
  }
  protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
  {
    this.sdsDocumentosRelacionadosAlRiesgo.DeleteParameters.Add("uupdate", TypeCode.String, "SYSTEM");
  }
  protected void Button1_Click(object sender, EventArgs e)
  {
    this.GridView1.DataBind();
  }
}
