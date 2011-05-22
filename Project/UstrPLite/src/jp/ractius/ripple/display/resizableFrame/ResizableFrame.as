package jp.ractius.ripple.display.resizableFrame 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import jp.ractius.ripple.events.ResizableFrameEvent;
	import jp.ractius.ripple.ui.mouseCursor.MouseCursorManager;
	
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
		
		private var m_isActive:Boolean = false;
		private var m_nextResizeCursor:String;
		
		public function ResizableFrame( edgeSize:Number = 7, cornerSize:Number = 20 ) 
		{
			alpha = 0;
			
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
			
			area.addEventListener( MouseEvent.MOUSE_DOWN,	_onMouseDown );
			area.addEventListener( MouseEvent.ROLL_OVER,	_onRollOver );
			area.addEventListener( MouseEvent.ROLL_OUT,		_onRollOut );
			
			return area;
		}
		
		private function _onRollOut( e:MouseEvent ):void 
		{
			if ( !m_isActive )
			{
				Mouse.cursor = MouseCursor.AUTO;
				
				// mouseDown 中は auto に変化しない問題の対策
				Mouse.hide();
				Mouse.show();
			}
		}
		
		private function _onRollOver( e:MouseEvent ):void 
		{
			var area:ResizableArea = ResizableArea( e.target );
			
			switch ( area.hori + area.vert )
			{
			case "T":
			case "B":
				m_nextResizeCursor = MouseCursorManager.RESIZE_0;
				break;
				
			case "RT":
			case "LB":
				m_nextResizeCursor = MouseCursorManager.RESIZE_45;
				break;
				
			case "R":
			case "L":
				m_nextResizeCursor = MouseCursorManager.RESIZE_90;
				break;
				
			case "RB":
			case "LT":
				m_nextResizeCursor = MouseCursorManager.RESIZE_135;
				break;
			}
			
			if ( !m_isActive )
			{
				Mouse.cursor = m_nextResizeCursor;
			}
		}
		
		private function _onMouseUp( e:MouseEvent ):void 
		{
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			if ( m_nextResizeCursor )	Mouse.cursor = m_nextResizeCursor;
			else						Mouse.cursor = MouseCursor.AUTO;
			
			m_isActive = false;
		}
		
		private function _onMouseDown( e:MouseEvent ):void 
		{	
			m_isActive = true;
			
			var area:ResizableArea = ResizableArea( e.target );
			dispatchEvent( new ResizableFrameEvent( area.hori, area.vert ) );
			
			stage.addEventListener( MouseEvent.MOUSE_UP, _onMouseUp );
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