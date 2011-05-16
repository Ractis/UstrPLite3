package jp.ractius.ustrplite.services.justintv.channel.parser 
{
	import jp.ractius.ustrplite.services.common.channel.BaseChannelInfo;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelInfoApiParser extends BaseChannelInfo
	{
		private var m_xml:XML;
		
		public function ChannelInfoApiParser( data:String ) 
		{
			m_xml = new XML( data );
		}
		
		override public function get isAvailable():Boolean	{ return m_xml.localName() == "channel"; }
		override public function get channelId():String		{ return userName; }
		override public function get userName():String		{ return m_xml.login; }
		override public function get title():String			{ return m_xml.title; }
		override public function get description():String 	{ return m_xml.status; }
		override public function get imageUrl():String		{ return m_xml.image_url_large; }
	}

}