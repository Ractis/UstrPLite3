package jp.ractius.ustrplite.player.modules 
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import jp.ractius.ripple.air.WindowBounds;
	import jp.ractius.ripple.events.WindowBoundsEvent;
	import jp.ractius.ustrplite.events.ResizeEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class SizeModule extends EventDispatcher 
	{
		private var m_bounds:WindowBounds;
		
		private var m_w:uint;
		private var m_h:uint;
		
		public function SizeModule( bounds:WindowBounds ) 
		{
			m_bounds = bounds;
			_copyFromBounds();
			
			m_bounds.addEventListener( WindowBoundsEvent.RESIZING, _onResizingBounds );
		}
		
		private function _copyFromBounds():void
		{
			m_w	= m_bounds.w;
			m_h = m_bounds.h;
		}
		
		private function _onResizingBounds( e:WindowBoundsEvent ):void 
		{
			_copyFromBounds();
			
			_fireResizeEvent();
		}
		
		public function setSize( w:uint, h:uint ):void
		{
			m_bounds.setSize( w, h );
			m_bounds.commit();
		}
		
		/**
		 * 指定のオブジェクトの width, height プロパティに、現在の値を適用
		 * @param	tgt
		 */
		public function applyTo( tgt:Object ):void
		{
			tgt.width	= m_w;
			tgt.height	= m_h;
		}
		
		private function _fireResizeEvent():void 
		{
			dispatchEvent( new ResizeEvent( ResizeEvent.RESIZE ) );
		}
		
		public function enlarge( n:uint = 1 ):void
		{
			for ( var i:uint = 0; i < n; i++ ) _enlargeImpl();
			_apply();
		}
		
		public function reduce( n:uint = 1 ):void
		{
			for ( var i:uint = 0; i < n; i++ ) _reduceImpl();
			_apply();
		}
		
		private function _enlargeImpl():void 
		{
			//TODO 
		}
		
		private function _reduceImpl():void 
		{
			//TODO
		}
		
		private function _apply():void 
		{
			//TODO
		}
		
		public function get w():uint { return m_w; }
		
		public function get h():uint { return m_h; }
		
	}

}