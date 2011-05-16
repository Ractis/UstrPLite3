package jp.ractius.ripple.display.resizableFrame 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import jp.ractius.ripple.events.ResizableFrameEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ResizableFrame extends Sprite 
	{
		private var m_edgeSize:Number;
		private var m_cornerSize:Number;
		
		private var m_frL:ResizableArea;
		private var m_frT:ResizableArea;
		private var m_frB:ResizableArea;
		private var m_frR:ResizableArea;
		private var m_frLT:ResizableArea;
		private var m_frLB:ResizableArea;
		private var m_frRT:ResizableArea;
		private var m_frRB:ResizableArea;
		
		public function ResizableFrame( edgeSize:Number = 7, cornerSize:Number = 20 ) 
		{
			m_edgeSize		= edgeSize;
			m_cornerSize	= cornerSize;
			
			m_frL	= _create( "L",  "" );
			m_frT	= _create(  "", "T" );
			m_frB	= _create(  "", "B" );
			m_frR	= _create( "R",  "" );
			m_frLT	= _create( "L", "T" );
			m_frLB	= _create( "L", "B" );
			m_frRT	= _create( "R", "T" );
			m_frRB	= _create( "R", "B" );
		}
		
		private function _create( hori:String, vert:String ):ResizableArea 
		{
			var area:ResizableArea = new ResizableArea( hori, vert, m_edgeSize, m_cornerSize );
			addChild( area );
			
			area.addEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown );
			
			return area;
		}
		
		private function _onMouseDown( e:MouseEvent ):void 
		{	
			var area:ResizableArea = ResizableArea( e.target );
			dispatchEvent( new ResizableFrameEvent( area.hori, area.vert ) );
		}
		
		override public function set width( w:Number ):void
		{
			m_frT.width		= w;
			m_frB.width		= w;
			m_frR.x			= w - m_edgeSize;
			m_frRT.x		= w - m_cornerSize;
			m_frRB.x		= w - m_cornerSize;
		}
		
		override public function set height( h:Number ):void
		{
			m_frL.height	= h;
			m_frR.height	= h;
			m_frB.y			= h - m_edgeSize;
			m_frLB.y		= h - m_cornerSize;
			m_frRB.y		= h - m_cornerSize;
		}
		
	}

}