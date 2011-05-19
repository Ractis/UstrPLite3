package jp.ractius.ustrplite.crostr.livetube.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class VideoSizeEvent extends Event 
	{
		static public const GET_VIDEO_SIZE:String = "getVideoSize";
		
		private var m_w:uint;
		private var m_h:uint;
		
		public function VideoSizeEvent( w:uint, h:uint ) 
		{
			m_w = w;
			m_h = h;
			
			super( GET_VIDEO_SIZE );
		}
		
		public function get w():uint { return m_w; }
		
		public function get h():uint { return m_h; }
		
	}

}