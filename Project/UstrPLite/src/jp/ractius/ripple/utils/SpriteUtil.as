package jp.ractius.ripple.utils 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author ractis
	 */
	public class SpriteUtil 
	{
		
		public function SpriteUtil() 
		{
			
		}
		
		static public function applyToChildren( parent:DisplayObjectContainer, property:String, data:Object ):void
		{
			Algorithm.forN( parent.numChildren, function( i:int ):void
			{
				parent.getChildAt( i )[ property ] = data;
			} );
		}
		
		static public function applyWidthToChildren( parent:DisplayObjectContainer, width:Number ):void
		{
			applyToChildren( parent, "width", width );
		}
		
		static public function applyHeightToChildren( parent:DisplayObjectContainer, height:Number ):void
		{
			applyToChildren( parent, "height", height );
		}
		
	}

}