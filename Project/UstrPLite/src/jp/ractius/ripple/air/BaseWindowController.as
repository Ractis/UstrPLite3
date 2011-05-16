package jp.ractius.ripple.air 
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseWindowController  
	{
		private var m_tgt:InteractiveObject;
		private var m_stage:Stage;
		private var m_bounds:WindowBounds;
		
		private var m_isActive:Boolean;
		private var m_lastMouseX:int;
		private var m_lastMouseY:int;
		
		public function BaseWindowController( tgt:InteractiveObject, bounds:WindowBounds ) 
		{
			m_tgt		= tgt;
			m_stage		= bounds.stage;
			m_bounds	= bounds;
			
			m_stage.addEventListener(	MouseEvent.MOUSE_MOVE,	onMouseMove );
			m_tgt.addEventListener(		MouseEvent.MOUSE_DOWN,	_onMouseDown );
		}
		
		protected function updateLastMousePos( e:MouseEvent ):void
		{
			m_lastMouseX = Math.round( e.stageX );
			m_lastMouseY = Math.round( e.stageY );
		}
		
		protected function deltaMousePos( e:MouseEvent ):Point
		{
			return new Point( Math.round( e.stageX ) - m_lastMouseX,
							  Math.round( e.stageY ) - m_lastMouseY );
		}
		
		protected function onAction( deltaPos:Point ):void 
		{
			// override me
		}
		
		protected function onMouseMove( e:MouseEvent ):void 
		{
			if ( !m_isActive )
			{
				updateLastMousePos( e );
			}
			else
			{
				onAction( deltaMousePos( e ) );
			}
		}
		
		private function _onMouseDown( e:MouseEvent ):void 
		{
			m_isActive = true;
			
			m_stage.addEventListener( MouseEvent.MOUSE_UP, _onMouseUp );
		}
		
		private function _onMouseUp( e:MouseEvent ):void 
		{
			e.target.removeEventListener( e.type, arguments.callee );
			
			m_isActive = false;
		}
		
		protected function get bounds():WindowBounds { return m_bounds; }
		
		protected function get lastMouseX():int { return m_lastMouseX; }
		
		protected function get lastMouseY():int { return m_lastMouseY; }
		
		protected function get isActive():Boolean { return m_isActive; }
		
	}

}