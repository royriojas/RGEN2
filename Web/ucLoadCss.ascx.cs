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

public partial class ucLoadCss : System.Web.UI.UserControl
{
  public String PathToFileToLoad
  {
    get
    {
      String localPath = (ViewState["PathToFileToLoad"]!=null)?ViewState["PathToFileToLoad"].ToString():"";      
      return R3M.Common.Util.ResolveURL(localPath);
    }
    set
    {
      ViewState["PathToFileToLoad"] = value;
    }
  }


  protected override void OnPreRender(EventArgs e)
  {
    base.OnPreRender(e);

    foreach (Control c in this.Page.Header.Controls)
    {
      if (c is HtmlLink)
      {
        if (((HtmlLink)c).Attributes["href"] == PathToFileToLoad) return;
      }

    }

    HtmlLink link = new HtmlLink();
    link.Attributes.Add("href", PathToFileToLoad);
    link.Attributes.Add("media", "screen");
    link.Attributes.Add("rel", "stylesheet");
    link.Attributes.Add("type", "text/css");

    this.Page.Header.Controls.Add(link);
  }

  protected void Page_Load(object sender, EventArgs e)
  {


  }
}
