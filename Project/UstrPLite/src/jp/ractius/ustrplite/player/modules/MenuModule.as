package jp.ractius.ustrplite.player.modules 
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jp.ractius.ripple.air.RNativeMenu;
	import jp.ractius.ustrplite.player.Player;
	/**
	 * ...
	 * @author ractis
	 */
	public class MenuModule extends RNativeMenu 
	{
		private var m_player:Player;
		
		public function MenuModule( player:Player ) 
		{
			m_player = player;
			
			appendItem( "player.menu.close", _onClose, "escape" );
			
			player.contextMenu = this;
			registerKeyMap( player.stage );
		}
		
		private function _onClose( ...e ):void 
		{
			m_player.stage.nativeWindow.close();
		}
		
	}

}