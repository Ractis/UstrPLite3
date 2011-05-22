package jp.ractius.ripple.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BitmapScale9Sprite extends Sprite 
	{
		private var m_00:Bitmap;	// Top Left
		private var m_01:Bitmap;	// Top Center
		private var m_02:Bitmap;	// Top Right
		private var m_10:Bitmap;	// VCenter Left
		private var m_11:Bitmap;	// VCenter Center
		private var m_12:Bitmap;	// VCenter Right
		private var m_20:Bitmap;	// Bottom Left
		private var m_21:Bitmap;	// Bottom Center
		private var m_22:Bitmap;	// Bottom Right
		
		private var m_fixedW:Number;	// = leftW + rightW
		private var m_fixedH:Number;	// = topH + bottomH
		
		public function BitmapScale9Sprite( bmp:Bitmap, scale9Grid:Rectangle ) 
		{
			var s9g:Rectangle = scale9Grid;	// alias
			
			var lx:Number = 0;
			var lw:Number = s9g.left;
			var cx:Number = s9g.left;
			var cw:Number = s9g.width;
			var rx:Number = s9g.right;
			var rw:Number = bmp.width - rx;
			
			var ty:Number = 0;
			var th:Number = s9g.top;
			var cy:Number = s9g.top;
			var ch:Number = s9g.height;
			var by:Number = s9g.bottom;
			var bh:Number = bmp.height - by;
			
			m_00 = _createPart( bmp, lx, ty, lw, th );
			m_01 = _createPart( bmp, cx, ty, cw, th );
			m_02 = _createPart( bmp, rx, ty, rw, th );
			m_10 = _createPart( bmp, lx, cy, lw, ch );
			m_11 = _createPart( bmp, cx, cy, cw, ch );
			m_12 = _createPart( bmp, rx, cy, rw, ch );
			m_20 = _createPart( bmp, lx, by, lw, bh );
			m_21 = _createPart( bmp, cx, by, cw, bh );
			m_22 = _createPart( bmp, rx, by, rw, bh );
			
			m_fixedW = lw + rw;
			m_fixedH = th + bh;
		}
		
		override public function set width( w:Number ):void
		{
			var cw:Number = w - m_fixedW;
			var rx:Number = w - m_02.width;
			
			m_01.width = cw;
			m_11.width = cw;
			m_21.width = cw;
			
			m_02.x = rx;
			m_12.x = rx;
			m_22.x = rx;
		}
		
		override public function set height( h:Number ):void
		{
			var ch:Number = h - m_fixedH;
			var by:Number = h - m_20.height;
			
			m_10.height = ch;
			m_11.height = ch;
			m_12.height = ch;
			
			m_20.y = by;
			m_21.y = by;
			m_22.y = by;
		}
		
		private function _createPart( src:Bitmap, x:Number, y:Number, w:Number, h:Number ):Bitmap 
		{
			var tgt:BitmapData = new BitmapData( w, h, true, 0x00FFFFFF );
			
			var mtx:Matrix = new Matrix();
			mtx.translate( -x, -y );
			
			tgt.draw( src, mtx );
			
			var bmp:Bitmap = new Bitmap( tgt, PixelSnapping.NEVER, true );
			bmp.x = x;
			bmp.y = y;
			addChild( bmp );
			
			return bmp;
		}
		
	}

}