package jp.ractius.ripple.air 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import jp.ractius.ripple.display.resizableFrame.ResizableFrame;
	import jp.ractius.ripple.events.ResizableFrameEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class WindowResizeController extends BaseWindowController 
	{
		private var m_activeH:String;
		private var m_activeV:String;
		
		private var m_lastMouseXFromEdge:int;
		private var m_lastMouseYFromEdge:int;
		
		public function WindowResizeController( frame:ResizableFrame, bounds:WindowBounds ) 
		{
			super( frame, bounds );
			
			frame.addEventListener( ResizableFrameEvent.ACTIVATE_FRAME, _onActivateFrame );
		}
		
		private function _onActivateFrame( e:ResizableFrameEvent ):void 
		{
			m_activeH = e.hori;
			m_activeV = e.vert;
			
			if ( m_activeH ) m_lastMouseXFromEdge = _posXFromEdge( lastMouseX );
			if ( m_activeV ) m_lastMouseYFromEdge = _posYFromEdge( lastMouseY );
		}
		
		private function _posXFromEdge( x:int ):int	{ return x - ( m_activeH == "L" ? 0 : bounds.w ); }
		private function _posYFromEdge( y:int ):int	{ return y - ( m_activeV == "T" ? 0 : bounds.h ); }
		
		protected function moveEdgeL( delta:int ):void
		{
			delta += Math.min( bounds.w - delta - bounds.minSize.x, 0 );	// 右へウィンドウが動いていくのを防ぐ
			bounds.resizeW( -delta );
			bounds.moveX( delta );
		}
		
		protected function moveEdgeR( delta:int ):void	{ bounds.resizeW( delta ); }
		
		protected function moveEdgeT( delta:int ):void
		{
			delta += Math.min( bounds.h - delta - bounds.minSize.y, 0 );	// 下へウィンドウが動いていくのを防ぐ
			bounds.resizeH( -delta );
			bounds.moveY( delta );
		}
		
		protected function moveEdgeB( delta:int ):void	{ bounds.resizeH( delta ); }
		
		override protected function onMouseMove( e:MouseEvent ):void 
		{
			if ( !isActive )
			{
				super.onMouseMove( e );
				return;
			}
			
			var deltaPos:Point = new Point();
			
			if ( m_activeH ) deltaPos.x = _posXFromEdge( e.stageX ) - m_lastMouseXFromEdge;
			if ( m_activeV ) deltaPos.y = _posYFromEdge( e.stageY ) - m_lastMouseYFromEdge;
			
			onAction( deltaPos );
			
			bounds.commit();
		}
		
		override protected function onAction( deltaPos:Point ):void 
		{
			switch ( m_activeH )
			{
			case "L":	moveEdgeL( deltaPos.x );	break;
			case "R":	moveEdgeR( deltaPos.x );	break;
			}
			
			switch ( m_activeV )
			{
			case "T":	moveEdgeT( deltaPos.y );	break;
			case "B":	moveEdgeB( deltaPos.y );	break;
			}
		}
		
		protected function get activeH():String { return m_activeH; }
		
		protected function get activeV():String { return m_activeV; }
		
	}

}