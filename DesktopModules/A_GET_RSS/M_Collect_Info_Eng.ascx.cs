using System;
using System.Xml;
using System.Xml.Schema;
using System.Collections.Generic;
using DotNetNuke.Entities.Modules;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class DesktopModules_C_Collect_Info_Eng_M_Collect_Info_Eng : PortalModuleBase
{
    String ConnectionString ;
    protected void Page_Load(object sender, EventArgs e)
    {
	  ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString();

	  //	Chanel 
     	  NewsRSS rss = new NewsRSS();

        NewsRSS.RssChannel channel = new NewsRSS.RssChannel();

        channel.Title = "DAA Website";

        channel.Link = "http://daa.uit.edu.vn";

        channel.Description = "University of Information Technology";

        rss.AddRssChannel(channel);        

	  //	Add items 
	  using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
           scon.Open();
           using (SqlCommand scom = new SqlCommand("SELECT Top 10 [ItemID], [Title], [PublishDate], [Description] FROM [Announcements] WHERE (Datediff(day,[PublishDate],getdate())>=0 ) AND([ModuleID] = 404) AND (Datediff(day,getdate(),[ExpireDate]) > 0 or [ExpireDate] Is Null) ORDER BY [PublishDate] DESC", scon))
           {
        		SqlDataReader sreader = scom.ExecuteReader();
		      while (sreader.Read())
        		{
				NewsRSS.RssItem item = new NewsRSS.RssItem();

			      item.Title = sreader.GetValue(1).ToString() + " (" + DateTime.Parse((sreader.GetValue(2).ToString())).ToShortDateString() + ")";

			      item.Link = "http://daa.uit.edu.vn/Th%C3%B4ngb%C3%A1om%E1%BB%9Bi.aspx?" + sreader.GetValue(0).ToString();

			      item.Description = getContent(sreader.GetValue(3).ToString());

			      rss.AddRssItem(item);
			}      
           }
        }
	  
	  //	Return rss document
	  Response.Clear();

      Response.ContentType = "text/xml";

      Response.Write(rss.RssDocument);

      Response.End();

    }

    public String getContent(String s)
    {
        String temp = s;
        int l = temp.Length < 250 ? temp.Length : 250;
        if (l > 0 )
        {
            temp = (temp.Substring(0, l));
            try
            {
                temp = Server.HtmlDecode(temp);
                if (temp.Contains(" "))
                    temp = (temp.Substring(0, temp.LastIndexOf(' ')));
                char m = temp[temp.Length - 1];
                if (m=='+'||m=='-'||m=='%'||m=='#'||
                    m=='&'||m=='$'||m=='('||m=='*'||m==')')
                    temp = temp.Remove(temp.Length - 1, 1);

                while (temp.Contains("<img"))
                {
                    for (int i = temp.IndexOf("<img"); i < temp.Length;i++ )
                        if (temp[i] == '>')
                        {
                            temp = temp.Remove(temp.IndexOf("<img"), i - temp.IndexOf("<img")+1);
                            break;
                        }
                }
            }
            catch (Exception ex) { }
        }
        return temp;
    }

}

public class NewsRSS
{
    private XmlDocument _rss = null;
    public struct RssChannel
    {
        public string Title;
        public string Link;
        public string Description;
    }

    public struct RssItem
    {
        public string Title;
        public string Link;
        public string Description;
    }

    private static XmlDocument addRssChannel(XmlDocument xmlDocument, RssChannel channel)
    {
        XmlElement channelElement = xmlDocument.CreateElement("channel");

        XmlNode rssElement = xmlDocument.SelectSingleNode("rss");

        rssElement.AppendChild(channelElement);

        XmlElement titleElement = xmlDocument.CreateElement("title");

        titleElement.InnerText = channel.Title;

        channelElement.AppendChild(titleElement);

        XmlElement linkElement = xmlDocument.CreateElement("link");

        linkElement.InnerText = channel.Link;

        channelElement.AppendChild(linkElement);

        XmlElement descriptionElement = xmlDocument.CreateElement("description");

        descriptionElement.InnerText = channel.Description;

        channelElement.AppendChild(descriptionElement);

        // Generator information

        XmlElement generatorElement = xmlDocument.CreateElement("generator");

        generatorElement.InnerText = "Your RSS Generator name and version ";

        channelElement.AppendChild(generatorElement);

        return xmlDocument;
    }

    private static XmlDocument addRssItem(XmlDocument xmlDocument, RssItem item)
    {
        XmlElement itemElement = xmlDocument.CreateElement("item");

        XmlNode channelElement = xmlDocument.SelectSingleNode("rss/channel");

        XmlElement titleElement = xmlDocument.CreateElement("title");

        titleElement.InnerText = item.Title;

        itemElement.AppendChild(titleElement);

        XmlElement linkElement = xmlDocument.CreateElement("link");

        linkElement.InnerText = item.Link;

        itemElement.AppendChild(linkElement);

        XmlElement descriptionElement = xmlDocument.CreateElement("description");

        descriptionElement.InnerText = item.Description;

        itemElement.AppendChild(descriptionElement);

        // append the item

        channelElement.AppendChild(itemElement);

        return xmlDocument;
    }
   
    public NewsRSS()
    {
        _rss = new XmlDocument();
        XmlDeclaration xmlDeclaration = _rss.CreateXmlDeclaration("1.0", "utf-8", null);
        _rss.InsertBefore(xmlDeclaration, _rss.DocumentElement);

        XmlElement rssElement = _rss.CreateElement("rss");
        XmlAttribute rssVersionAttribute = _rss.CreateAttribute("version");

        rssVersionAttribute.InnerText = "2.0";
        rssElement.Attributes.Append(rssVersionAttribute);

        _rss.AppendChild(rssElement);
        
    }

    public void AddRssChannel(RssChannel channel)
    {
        _rss = addRssChannel(_rss, channel);
    }

    public void AddRssItem(RssItem item)
    {
        _rss = addRssItem(_rss, item);
    }

    public string RssDocument
    {
        get
        {
            return _rss.OuterXml;
        }
    }

    public XmlDocument RssXMLDocument
    {
        get 
        {
            return _rss;
        }
    }

	
}