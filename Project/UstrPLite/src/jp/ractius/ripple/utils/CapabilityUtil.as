package jp.ractius.ripple.utils 
{
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author ractis
	 */
	public class CapabilityUtil 
	{
		
		public function CapabilityUtil() 
		{
			
		}
		
		static public function get isMac():Boolean
		{
			return ( Capabilities.os.indexOf( "Mac" ) >= 0 );
		}
		
	}

}