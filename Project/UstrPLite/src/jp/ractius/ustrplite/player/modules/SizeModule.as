package jp.ractius.ustrplite.player.modules 
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import jp.ractius.ustrplite.events.ResizeEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class SizeModule extends EventDispatcher 
	{	
		private var m_w:uint;
		private var m_h:uint;
		
		public function SizeModule( initW:uint, initH:uint ) 
		{
			m_w	= initW;
			m_h = initH;
		}
		
		public function setSize( w:uint, h:uint ):void
		{
			m_w = w;
			m_h = h;
			
			_fireResizeEvent();
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