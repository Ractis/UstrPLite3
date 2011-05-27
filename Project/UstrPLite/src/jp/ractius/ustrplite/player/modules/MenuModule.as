package jp.ractius.ustrplite.player.modules 
{
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.events.FullScreenEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import jp.ractius.ripple.air.RNativeMenu;
	import jp.ractius.ustrplite.player.Player;
	import jp.ractius.ustrplite.services.IPlayerOption;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class MenuModule extends RNativeMenu 
	{
		static private const PREFIX:String = "player.menu.";
		
		private var m_player:Player;
		private var m_playerOpt:IPlayerOption;
		private var m_window:NativeWindow;
		private var m_popupUrl:String;
		
		private var m_fullscreenItem:NativeMenuItem;
		
		public function MenuModule( player:Player, option:IPlayerOption ) 
		{
			m_player	= player;
			m_playerOpt	= option;
			m_window	= m_player.stage.nativeWindow;
			m_popupUrl	= m_playerOpt.popupPlayerUrl;
			
			pushSubmenu( PREFIX + "window.label" );
			appendToggleItem( "general.alwaysInFront", m_window, "alwaysInFront" );
			appendSeparator();
			appendItem( PREFIX + "window.minimizeMute", m_player.minimizeMute );
			appendItem( "general.minimize", _onMinimize );
			m_fullscreenItem = appendItem( PREFIX + "window.fullscreen", m_player.toggleFullscreen );
			popSubmenu();
			
			appendItem( PREFIX + "refresh", player.refresh );
			if ( m_popupUrl )
			{
				appendItem( PREFIX + "playInPopup", _onPlayInPopup );
				appendSeparator();
			}
			appendItem( PREFIX + "close", _onClose, "escape" );
			
			player.contextMenu = this;
			registerKeyMap( player.stage );
			
			m_player.stage.addEventListener( FullScreenEvent.FULL_SCREEN, _onFullscreenStage );
		}
		
		private function _onFullscreenStage( e:FullScreenEvent ):void 
		{
			m_fullscreenItem.checked = e.fullScreen;
		}
		
		private function _onMinimize( ...e ):void 
		{
			m_window.minimize();
		}
		
		private function _onPlayInPopup( ...e ):void 
		{
			m_window.close();
			
			var htmlLoader:HTMLLoader = HTMLLoader.createRootWindow();
			htmlLoader.load( new URLRequest( m_popupUrl ) );
			m_playerOpt.onBeginLoadPopupPlayer( htmlLoader );
		}
		
		private function _onClose( ...e ):void 
		{
			m_window.close();
		}
		
	}

}