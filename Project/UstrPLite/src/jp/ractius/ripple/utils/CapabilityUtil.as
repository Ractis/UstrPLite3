package jp.ractius.ripple.utils 
{
	import flash.desktop.NativeApplication;
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
		
		static public function get isSupportNativeAppIcon():Boolean
		{
			return NativeApplication.supportsDockIcon ||
				   NativeApplication.supportsSystemTrayIcon;
		}
		
	}

}