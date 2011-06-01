package jp.ractius.ustrplite.configs 
{
	import flash.geom.Rectangle;
	import jp.ractius.ripple.utils.SerializeUtil;
	import jp.ractius.ustrplite.UstrpliteConstants;
	/**
	 * ...
	 * @author ractis
	 */
	public class BrowserConfig extends BaseConfig 
	{
		
		public function BrowserConfig() 
		{
			super( UstrpliteConstants.CONFIG_BROWSER );
			
		}
		
		public function get alwaysInFront():Boolean { return data.alwaysInFront; }
		
		public function set alwaysInFront( value:Boolean ):void
		{
			data.alwaysInFront = value;
		}
		
		public function get skin():String { return data.skin; }
		
		public function set skin( value:String ):void
		{
			data.skin = value;
		}
		
		public function getWindowBounds( name:String ):Rectangle
		{
			if ( !data.windowBounds ) return null;
			
			return SerializeUtil.rawToRect( data.windowBounds[ name ] );
		}
		
		public function setWindowBounds( name:String, bounds:Rectangle ):void
		{
			if ( !data.windowBounds )
			{
				data.windowBounds = new Object();
			}
			
			data.windowBounds[ name ] = SerializeUtil.rectToRaw( bounds );
		}
		
	}

}