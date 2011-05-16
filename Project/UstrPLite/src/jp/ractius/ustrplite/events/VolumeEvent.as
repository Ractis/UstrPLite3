package jp.ractius.ustrplite.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class VolumeEvent extends Event 
	{
		static public const CHANGE_VOLUME:String	= "changeVolume";
		
		public function VolumeEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{
			super( type, bubbles, cancelable );
			
		}
		
	}

}