package jp.ractius.ripple.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class WindowBoundsEvent extends Event 
	{
		static public const MOVING:String	= "moving";
		static public const RESIZING:String	= "resizing";
		
		public function WindowBoundsEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{
			super( type, bubbles, cancelable );
		}
		
	}

}