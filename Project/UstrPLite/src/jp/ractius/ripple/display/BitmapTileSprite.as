package jp.ractius.ripple.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import jp.ractius.ripple.utils.Algorithm;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BitmapTileSprite extends Sprite 
	{
		private var m_mask:DisplayObject;
		
		private var m_bmpData:BitmapData;
		private var m_bmps:Vector.< Vector.< Bitmap > >;
		
		private var m_nx:uint = 0;	// cols
		private var m_ny:uint = 0;	// rows
		
		public function BitmapTileSprite( bmpData:BitmapData ) 
		{
		/*	addChild( new MaskHolder(*/ m_mask = new RectShape() //) );
			
			m_bmpData = bmpData;
			m_bmps = new < Vector.<Bitmap> > [];
		}
		
		private function set _nx( val:uint ):void
		{
			if		( val < m_nx )	Algorithm.forN( m_nx - val, _removeCol );
			else if	( val > m_nx )	Algorithm.forN( val - m_nx, _appendCol );
		}
		
		private function set _ny( val:uint ):void
		{
			if		( val < m_ny )	Algorithm.forN( m_ny - val, _removeRow );
			else if	( val > m_ny )	Algorithm.forN( val - m_ny, _appendRow );
		}
		
		private function _createTile( idxX:uint, idxY:uint ):Bitmap
		{
			var bmp:Bitmap = new Bitmap( m_bmpData );
			bmp.x = m_bmpData.width  * idxX;
			bmp.y = m_bmpData.height * idxY;
			
			addChild( bmp );
			
			return bmp;
		}
		
		private function _appendCol():void
		{
			var col:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			Algorithm.forN( m_ny, function( i:int ):void
			{
				col.push( _createTile( m_nx, i ) );
			} );
			
			m_bmps.push( col );
			m_nx++;
		}
		
		private function _removeCol():void
		{
			var col:Vector.<Bitmap> = m_bmps.pop();
			
			Algorithm.forN( m_ny, function():void
			{
				removeChild( col.pop() );
			} );
			
			m_nx--;
		}
		
		private function _appendRow():void
		{
			Algorithm.forN( m_nx, function( i:int ):void
			{
				m_bmps[i].push( _createTile( i, m_ny ) );
			} );
			
			m_ny++;
		}
		
		private function _removeRow():void
		{
			Algorithm.forN( m_nx, function( i:int ):void
			{
				removeChild( m_bmps[i].pop() );
			} );
			
			m_ny--;
		}
		
		override public function set width( w:Number ):void
		{
			_nx = Math.ceil( w / m_bmpData.width );
			m_mask.width = w;
		}
		
		override public function set height( h:Number ):void
		{
			_ny = Math.ceil( h / m_bmpData.height );
			m_mask.height = h;
		}
		
	}

}