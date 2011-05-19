package jp.ractius.ustrplite.services.justintv.channel.parser 
{
	import flash.geom.Point;
	import jp.ractius.ustrplite.services.common.channel.BaseChannelStatus;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelStatusParser extends BaseChannelStatus
	{
		private var m_isLive:Boolean;
		private var m_videoSize:Point;
		
		public function ChannelStatusParser( channelName:String, data:String ) 
		{
			var idx:int = data.indexOf( "http://www.justin.tv/" + channelName );
			
			m_isLive = ( idx >= 0 );
			
			if ( !m_isLive ) return;
			
			var xml:XML = _parseStreamData( data, idx );
			
			m_videoSize = new Point( xml.video_width, xml.video_height );
		}
		
		private function _parseStreamData( data:String, basePos:int ):XML 
		{
			var begTag:String = "<stream>";
			var endTag:String = "</stream>";
			
			var beg:int = data.lastIndexOf( begTag, basePos );
			var end:int = data.indexOf( endTag, basePos ) + endTag.length;
			
			data = data.substring( beg, end );
			
			return new XML( data );
		}
		
		override public function get status():String	{ return genStatus( m_isLive ); }
		
		//------------------------------------------------------------------------------
		// for ExData
		//------------------------------------------------------------------------------
		public function get videoSize():Point { return m_videoSize; }
		
	}

}