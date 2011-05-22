package jp.ractius.ripple.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import jp.ractius.ripple.RMath;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RoundRectShadowSprite extends Sprite 
	{
		private var m_blur2:Number;
		private var m_shadow:BitmapScale9Sprite;
		
		public function RoundRectShadowSprite( cornerRadius:Number, blur:Number, distance:Number = 2, alpha:Number = 0.5 ) 
		{
			m_blur2 = blur * 2;
			
			// setup Rect
			var rect:RoundRectShape = new RoundRectShape( cornerRadius );
			rect.filters = [ new DropShadowFilter( 0, 90, 0x000000, alpha, blur, blur, 1, 2, false, false, true ) ];
			
			var size:Number = cornerRadius * 2 + blur;
			if ( RMath.isEven( size ) ) size += 1;
			rect.setSize( size, size );
			
			// setup BitmapData
			var tgtSize:Number = size + m_blur2;
			var tgt:BitmapData = new BitmapData( tgtSize, tgtSize, true, 0x00FFFFFF );
			
			// draw to BitmapData
			var mtx:Matrix = new Matrix();
			mtx.translate( blur, blur );
			
			tgt.draw( rect, mtx );
			
			// setup shadow
			var pos:Number = tgt.width / 2 - 0.5;
			m_shadow = new BitmapScale9Sprite( new Bitmap( tgt ), new Rectangle( pos, pos, 1, 1 ) );
			m_shadow.x = -blur;
			m_shadow.y = -blur + distance;
			
			addChild( m_shadow );
		}
		
		override public function set width( w:Number ):void
		{
			m_shadow.width = w + m_blur2;
		}
		
		override public function set height( h:Number ):void
		{
			m_shadow.height = h + m_blur2;
		}
		
	}

}