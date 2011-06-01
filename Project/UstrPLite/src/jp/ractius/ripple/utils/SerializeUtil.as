package jp.ractius.ripple.utils 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ractis
	 */
	public class SerializeUtil 
	{
		
		public function SerializeUtil() 
		{
			
		}
		
		static public function rectToRaw( v:Rectangle ):Object
		{
			var raw:Object = new Object();
			raw.x = v.x;
			raw.y = v.y;
			raw.w = v.width;
			raw.h = v.height;
			
			return raw;
		}
		
		static public function rawToRect( v:Object ):Rectangle
		{
			var rect:Rectangle = new Rectangle( v.x, v.y, v.w, v.h );
			return rect;
		}
		
	}

}