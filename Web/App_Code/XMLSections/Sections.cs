using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Serialization;
using System.Collections.Generic;
/// <summary>
/// Summary description for Sections
/// </summary>
/// 
[XmlRoot("sections")]
public class sections
{
  public sections()
  {
    //
    // TODO: Add constructor logic here
    //
  }

  private List<section> _secs = new List<section>();
  [XmlElement("section")]
  public List<section> Secs
  {
    get
    {
      return _secs;
    }
    set
    {
      _secs = value;
    }
  }
}

public class section
{

  public section()
  {
    
  }

  private String _keyName;
  public String KeyName
  {
    get
    {
      return _keyName;
    }
    set
    {
      _keyName = value;
    }
  }

  private String _title;
  public String Title
  {
    get
    {
      return _title;
    }
    set
    {
      _title = value;
    }
  }

  private Int32 _level;
  public Int32 Level
  {
    get
    {
      return ((_level >= 1) && (_level <= 2)) ? _level : 1;
    }
    set
    {
      _level = value;
    }
  }
}
