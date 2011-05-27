package jp.ractius.ripple.air 
{
	import flash.display.InteractiveObject;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import jp.ractius.ripple.utils.CapabilityUtil;
	import jp.ractius.ripple.utils.Localization;
	
	/**
	 * スタック方式でアイテムを追加できる NativeMenu.
	 * @author ractis
	 */
	public class RNativeMenu extends NativeMenu 
	{
		private var m_currentMenu:NativeMenu;
		private var m_isUseLocalization:Boolean;
		
		private var m_keyMap:Dictionary = new Dictionary();
		
		public function RNativeMenu( isUseLocalization:Boolean = true ) 
		{
			m_currentMenu = this;
			m_isUseLocalization = isUseLocalization;
		}
		
		public function appendItem( name:String, listener:Function = null, key:String = "", isCtrl:Boolean = false, isShift:Boolean = false ):NativeMenuItem
		{
			var item:NativeMenuItem = new NativeMenuItem();
			_appendImpl( item, name, listener, key, isCtrl, isShift );
			return item;
		}
		
		public function appendToggleItem( name:String, tgt:Object, tgtProperty:String, key:String = "", isCrtl:Boolean = false, isShift:Boolean = false ):RNativeMenuToggleItem
		{
			var item:RNativeMenuToggleItem = new RNativeMenuToggleItem( tgt, tgtProperty );
			_appendImpl( item, name, _onSelectToggle, key, isCrtl, isShift );
			return item;
		}
		
		private function _onSelectToggle( e:Event ):void 
		{
			var item:RNativeMenuToggleItem = RNativeMenuToggleItem( e.target );
			item.toggle();
		}
		
		private function _appendImpl( item:NativeMenuItem, name:String, listener:Function, key:String, isCtrl:Boolean, isShift:Boolean ):void
		{
			if ( m_isUseLocalization )	item.label = Localization.substitude( name );
			else						item.label = name;
			
			item.keyEquivalent = key;
			item.keyEquivalentModifiers = _createKeyMods( isCtrl, isShift );
			if ( listener != null ) item.addEventListener( Event.SELECT, listener );
			
			_registerToKeyMap( item, key, isCtrl, isShift );
			
			m_currentMenu.addItem( item );
		}
		
		private function _registerToKeyMap( item:NativeMenuItem, key:String, isCtrl:Boolean, isShift:Boolean ):void 
		{
			var keyCode:uint = Keyboard[ key.toUpperCase() ];
			
			var menuKey:RNativeMenuKey = m_keyMap[ keyCode ];
			if ( !menuKey )
			{
				menuKey = new RNativeMenuKey();
				m_keyMap[ keyCode ] = menuKey;
			}
			
			menuKey.register( item, isCtrl, isShift );
		}
		
		public function appendSeparator():void
		{
			m_currentMenu.addItem( new NativeMenuItem( "", true ) );
		}
		
		public function pushSubmenu( name:String ):NativeMenu
		{
			var item:NativeMenuItem = appendItem( name );
			m_currentMenu = item.submenu = new NativeMenu();
			
			return m_currentMenu;
		}
		
		public function popSubmenu():void
		{
			m_currentMenu = m_currentMenu.parent;
		}
		
		private function _createKeyMods( isCtrl:Boolean, isShift:Boolean ):Array 
		{
			var keyMods:Array = [];
			
			if ( isCtrl )
			{
				if ( CapabilityUtil.isMac )	keyMods.push( Keyboard.COMMAND );
				else						keyMods.push( Keyboard.CONTROL );
			}
			
			if ( isShift ) keyMods.push( Keyboard.SHIFT );
			
			return keyMods;
		}
		
		public function registerKeyMap( tgt:InteractiveObject ):void
		{
			tgt.addEventListener( KeyboardEvent.KEY_DOWN, _onKeyDown );
		}
		
		private function _onKeyDown( e:KeyboardEvent ):void 
		{
			var menuKey:RNativeMenuKey = m_keyMap[ e.keyCode ];
			if ( !menuKey ) return;
			
			menuKey.fire( e.ctrlKey, e.shiftKey );
		}
		
	}

}