package jp.ractius.ripple.air 
{
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jp.ractius.ripple.events.WindowBoundsEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class WindowBounds extends EventDispatcher 
	{
		private var m_stage:Stage;
		private var m_nativeWindow:NativeWindow;
		private var m_minSize:Point;
		
		private var m_bounds:Rectangle;
		private var m_isMoved:Boolean	= false;
		private var m_isResized:Boolean	= false;
		
		public function WindowBounds( stage:Stage ) 
		{
			m_stage			= stage;
			m_nativeWindow	= stage.nativeWindow;
			
			m_bounds		= m_nativeWindow.bounds;
			m_minSize		= m_nativeWindow.minSize;
		}
		
		public function move( deltaX:int, deltaY:int ):void
		{
			moveX( deltaX );
			moveY( deltaY );
		}
		
		public function moveX( delta:int ):void { m_bounds.x += delta; _onMoved(); }
		public function moveY( delta:int ):void { m_bounds.y += delta; _onMoved(); }
		
		public function resize( deltaW:int, deltaH:int ):void
		{
			resizeW( deltaW );
			resizeH( deltaH );
		}
		
		public function resizeW( delta:int ):void
		{
			m_bounds.width = Math.max( m_minSize.x, m_bounds.width + delta );
			_onResized();
		}
		
		public function resizeH( delta:int ):void
		{
			m_bounds.height = Math.max( m_minSize.y, m_bounds.height + delta );
			_onResized();
		}
		
		public function setSize( w:int, h:int ):void
		{
			m_bounds.width = w;
			m_bounds.height = h;
			_onResized();
		}
		
		private function _onMoved():void	{ m_isMoved		= true; }
		private function _onResized():void	{ m_isResized	= true; }
		
		public function commit():void
		{
			if ( m_isMoved )
			{
				dispatchEvent( new WindowBoundsEvent( WindowBoundsEvent.MOVING ) );
				m_isMoved = false;
			}
			if ( m_isResized )
			{
				dispatchEvent( new WindowBoundsEvent( WindowBoundsEvent.RESIZING ) );
				m_isResized = false;
			}
			
			m_nativeWindow.bounds = m_bounds;
		}
		
		public function get minSize():Point { return m_minSize; }
		
		public function get stage():Stage { return m_stage; }
		
		public function get w():Number { return m_bounds.width; }
		public function get h():Number { return m_bounds.height; }
		
	}

}