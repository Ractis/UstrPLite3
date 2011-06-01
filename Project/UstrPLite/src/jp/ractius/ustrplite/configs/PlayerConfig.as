package jp.ractius.ustrplite.configs 
{
	import flash.geom.Rectangle;
	import jp.ractius.ripple.utils.SerializeUtil;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerConfig extends BaseConfig 
	{
		
		public function PlayerConfig() 
		{
			super( UstrpliteConstants.CONFIG_PLAYER );
			
		}
		
		public function get alwaysInFront():Boolean { return data.alwaysInFront; }
		
		public function set alwaysInFront( value:Boolean ):void
		{
			data.alwaysInFront = value;
		}
		
		public function get windowBounds():Rectangle
		{
			if ( !data.windowBounds ) return null;
			
			return SerializeUtil.rawToRect( data.windowBounds );
		}
		
		public function set windowBounds( value:Rectangle ):void
		{
			data.windowBounds = SerializeUtil.rectToRaw( value );
		}
		
	}

}