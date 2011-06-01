package jp.ractius.ripple.air 
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.EventDispatcher;
	import flash.events.FullScreenEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jp.ractius.ripple.events.WindowBoundsEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class WindowBounds extends EventDispatcher 
	{
		private var m_isActive:Boolean;
		
		private var m_stage:Stage;
		private var m_nativeWindow:NativeWindow;
		private var m_minSize:Point;
		
		private var m_bounds:Rectangle;
		private var m_isMoved:Boolean	= false;
		private var m_isResized:Boolean	= false;
		
		public function WindowBounds( stage:Stage, isActive:Boolean = true ) 
		{
			m_isActive		= isActive;
			
			m_stage			= stage;
			m_nativeWindow	= stage.nativeWindow;
			
			m_bounds		= m_nativeWindow.bounds;
			m_minSize		= m_nativeWindow.minSize;
			
			m_stage.addEventListener( FullScreenEvent.FULL_SCREEN, onFullScreen );
			m_nativeWindow.addEventListener( NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, _onDisplayStateChange );
		}
		
		public function activate():void
		{
			if ( m_isActive ) return;
			
			m_isActive = true;
			commit();
		}
		
		public function deactivate():void
		{
			m_isActive = false;
		}
		
		private function onFullScreen( e:FullScreenEvent ):void 
		{
			if ( !m_isActive ) return;
			
			if ( !e.fullScreen )
			{
				commit();
			}
		}
		
		private function _onDisplayStateChange( e:NativeWindowDisplayStateEvent ):void 
		{
			if ( !m_isActive ) return;
			
			if ( e.beforeDisplayState == NativeWindowDisplayState.MINIMIZED )
			{
				e.preventDefault();
				commit( true );
			}
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
		
		public function commit( ignoreCheckMinimize:Boolean = false ):void
		{
			if ( !m_isActive ) return;
			
			if ( !ignoreCheckMinimize )
			{
				if ( m_nativeWindow.displayState == NativeWindowDisplayState.MINIMIZED )
				{
					return;
				}
			}
			
			if ( m_stage.displayState != StageDisplayState.NORMAL ) return;
			
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
		
		public function get bounds():Rectangle { return m_bounds; }
		
		public function set bounds( value:Rectangle ):void 
		{
			m_bounds = value;
			
			m_isMoved	= true;
			m_isResized	= true;
		}
		
	}

}