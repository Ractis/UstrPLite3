package jp.ractius.ustrplite.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ResizeEvent extends Event 
	{
		static public const RESIZE:String = "resize";
		
		public function ResizeEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{
			super( type, bubbles, cancelable );
			
		}
		
	}

}