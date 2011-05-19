package jp.ractius.ripple.air 
{
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	/**
	 * キー毎に割り当てられるメニューアイテムを管理するクラス.
	 * @author ractis
	 */
	internal class RNativeMenuKey  
	{
		private var m_item:NativeMenuItem;
		private var m_itemC:NativeMenuItem;
		private var m_itemS:NativeMenuItem;
		private var m_itemCS:NativeMenuItem;
		
		public function RNativeMenuKey() 
		{
			
		}
		
		public function register( item:NativeMenuItem, isCtrl:Boolean, isShift:Boolean ):void
		{
			if ( isCtrl && isShift )	m_itemCS	= item;
			else if ( isCtrl )			m_itemC		= item;
			else if ( isShift )			m_itemS		= item;
			else						m_item		= item;
		}
		
		public function fire( isCtrl:Boolean, isShift:Boolean ):void
		{
			if ( isCtrl && isShift )	_fireImpl( m_itemCS );
			else if ( isCtrl )			_fireImpl( m_itemC );
			else if ( isShift )			_fireImpl( m_itemS );
			else						_fireImpl( m_item );
		}
		
		private function _fireImpl( item:NativeMenuItem ):void 
		{
			if ( !item ) return;
			
			item.dispatchEvent( new Event( Event.SELECT ) );
		}
		
	}

}