package jp.ractius.ustrplite.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BrowserEvent extends Event 
	{
		static public const SWITCH_SKIN:String	= "switchSkin";
		
		public function BrowserEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{
			super( type, bubbles, cancelable );
			
		}
		
	}

}