package jp.ractius.ustrplite.services.justintv.channel.parser 
{
	import jp.ractius.ustrplite.services.common.channel.BaseChannelStatus;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelStatusParser extends BaseChannelStatus
	{
		private var m_isLive:Boolean;
		
		public function ChannelStatusParser( channelName:String, data:String ) 
		{
			m_isLive = ( data.search( "http://www.justin.tv/" + channelName ) >= 0 );
		}
		
		override public function get status():String	{ return genStatus( m_isLive ); }
		
	}

}