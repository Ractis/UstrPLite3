package jp.ractius.ripple.display 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RectShape extends Shape 
	{
		
		public function RectShape( color:uint = 0x000000 ) 
		{
			var g:Graphics = graphics;
			g.beginFill( color );
			g.drawRect( 0, 0, 200, 200 );
			g.endFill();
		}
		
	}

}