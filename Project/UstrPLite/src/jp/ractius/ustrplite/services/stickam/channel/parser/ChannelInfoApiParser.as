package jp.ractius.ustrplite.services.stickam.channel.parser 
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
		
		override public function get isAvailable():Boolean	{ return userName != null; }
		override public function get status():String		{ return genStatus( m_xml.status == "live" ); }
		override public function get channelId():String		{ return userName; }
		override public function get userName():String		{ return m_xml.user_name; }
		override public function get title():String			{ return m_xml.screen_name; }
		override public function get description():String 	{ return m_xml.message; }
		override public function get imageUrl():String		{ return m_xml.profile_image; }
		
	}

}