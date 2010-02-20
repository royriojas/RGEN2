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

public partial class Test_TestNumber : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }
  protected void btnToNumber_Click(object sender, EventArgs e)
  {
    this.Label1.Text = R3M.Common.Util.getNumberAsLetters(Convert.ToDouble(this.TextBox1.Text));

  }
  protected void Button1_Click(object sender, EventArgs e)
  {
    /*  sections sect = ObjectXMLSerializer.ObjectXMLSerializer<sections>.Load(Server.MapPath("~/App_Data/AditionalSections.xml"));
    
      this.Label1.Text = sect.Secs.Count.ToString();*/

  }
  protected void Button1_Click1(object sender, EventArgs e)
  {
    this.Label1.Text = GestorInforme.getSubtitle("SUMA_ASEGURADA", 1257);
  }
}
