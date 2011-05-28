package jp.ractius.ustrplite.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerEvent extends Event 
	{
		static public const CHANGE_VIEWERS:String	= "changeViewers";
		
		public function PlayerEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}