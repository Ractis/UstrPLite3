package jp.ractius.ustrplite.services.ustream.channel.parser 
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
		
		private function get _results():XMLList { return m_xml.results; }
		
		override public function get isAvailable():Boolean	{ return channelId != null; }
		override public function get status():String		{ return _results.status; }
		override public function get channelId():String		{ return _results.id; }
		override public function get userName():String		{ return _results.user.userName; }
		override public function get title():String			{ return _results.title; }
		override public function get description():String 	{ return _results.description; }
		override public function get hashTag():String		{ return _results.socialStream.hashtag; }
		override public function get imageUrl():String		{ return _results.imageUrl.medium; }
		
	}

}