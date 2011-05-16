package jp.ractius.ripple.display.resizableFrame 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ResizableArea extends Sprite 
	{
		static private const EDGE_LENGTH:Number = 200;
		
		private var m_hori:String;
		private var m_vert:String;
		
		private var m_thickness:Number;
		private var m_cornerSize:Number;
		
		public function ResizableArea( hori:String, vert:String, thickness:Number, cornerSize:Number ) 
		{
			alpha = 0;
			
			m_hori			= hori;
			m_vert			= vert;
			m_thickness		= thickness;
			m_cornerSize	= cornerSize;
			
			var g:Graphics = graphics;
			g.beginFill( hori && vert ? 0xFF0000 : 0x0000FF );
			
			if		( !hori )	_drawEdgeH();	// TOP or BOTTOM
			else if	( !vert )	_drawEdgeV();	// LEFT or RIGHT
			else				_drawCorner();	// corner
			
			g.endFill();
		}
		
		private function _drawEdgeH():void 
		{
			_drawRect( 0, 0, EDGE_LENGTH, m_thickness );
		}
		
		private function _drawEdgeV():void
		{
			_drawRect( 0, 0, m_thickness, EDGE_LENGTH );
		}
		
		private function _drawCorner():void
		{
			var posRB:Number = m_cornerSize - m_thickness;	// RIGHT or BOTTOM の基点位置
			
			// draw HORI line
			_drawRect( 0,
					   m_vert == "B" ? posRB : 0,
					   m_cornerSize,
					   m_thickness );
			
			// draw VERT line
			_drawRect( m_hori == "R" ? posRB : 0,
					   m_vert == "T" ? m_thickness : 0,
					   m_thickness,
					   m_cornerSize - m_thickness );
		}
		
		private function _drawRect( x:Number, y:Number, w:Number, h:Number ):void
		{
			graphics.drawRect( x, y, w, h );
		}
		
		public function get hori():String { return m_hori; }
		
		public function get vert():String { return m_vert; }
		
	}

}