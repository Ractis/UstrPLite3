package jp.ractius.ripple.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ResizableFrameEvent extends Event 
	{
		static public const ACTIVATE_FRAME:String = "activateFrame";
		
		private var m_hori:String;
		private var m_vert:String;
		
		public function ResizableFrameEvent( hori:String, vert:String ) 
		{
			super( ACTIVATE_FRAME );
			
			m_hori = hori;
			m_vert = vert;
		}
		
		public function get hori():String { return m_hori; }
		
		public function get vert():String { return m_vert; }
		
	}

}