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
		
		private var m_videoW:uint = 0;
		private var m_videoH:uint = 0;
		
		private var m_isChangeScale:Boolean = false;
		private var m_scale:Number;
		
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
			
			m_isChangeScale = false;
			
			_fireResizeEvent();
		}
		
		public function setSize( w:uint, h:uint ):void
		{
			m_bounds.setSize( w, h );
			m_bounds.commit();
		}
		
		public function setScale( scale:Number ):void
		{
			m_scale = scale;
			m_isChangeScale = true;
			
			if ( m_videoW == 0 || m_videoH == 0 ) return;
			
			setSize( m_videoW * scale, m_videoH * scale );
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
		
		public function setVideoSize( w:Number, h:Number ):void 
		{
			m_videoW = w;
			m_videoH = h;
			
			if ( m_isChangeScale )
			{
				setScale( m_scale );
			}
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
			setSize( m_w, m_h );
		}
		
		public function get w():uint { return m_w; }
		
		public function get h():uint { return m_h; }
		
	}

}