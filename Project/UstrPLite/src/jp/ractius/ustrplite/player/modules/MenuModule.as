package jp.ractius.ustrplite.player.modules 
{
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import jp.ractius.ripple.air.RNativeMenu;
	import jp.ractius.ripple.utils.Localization;
	import jp.ractius.ustrplite.events.ChannelEvent;
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
		
		private var m_favoriteItem:NativeMenuItem;
		
		public function MenuModule( player:Player, option:IPlayerOption ) 
		{
			m_player	= player;
			m_playerOpt	= option;
			m_window	= m_player.stage.nativeWindow;
			m_popupUrl	= m_playerOpt.popupPlayerUrl;
			
			_initSizeMenu();
			_initWindowMenu();
			_initChannelMenu();
			
			appendItem( PREFIX + "refresh", player.refresh );
			if ( m_popupUrl )
			{
				appendItem( PREFIX + "playInPopup", _onPlayInPopup );
			}
			
			appendSeparator();
			appendItem( PREFIX + "close", _onClose, "escape" );
			
			player.contextMenu = this;
			registerKeyMap( player.stage );
			
			m_player.channel.addEventListener( ChannelEvent.CHANGE_FAVORITE, _onFavorite );
			_onFavorite();
		}
		
		private function _onFavorite( e:ChannelEvent = null ):void 
		{
			var isFav:Boolean = m_player.channel.isFavorite;
			
			m_favoriteItem.enabled = !isFav;
			
			var name:String = isFav ? PREFIX + "channel.isAlreadyFav" : "general.addFavFull";
			m_favoriteItem.label = Localization.substitude( name );
		}
		
		private function _initChannelMenu():void 
		{
			pushSubmenu( PREFIX + "channel.label" );
			
			m_favoriteItem = appendItem( "general.addFavFull", m_player.addFav );
			
			popSubmenu();
		}
		
		private function _initWindowMenu():void 
		{
			pushSubmenu( PREFIX + "window.label" );
			
			appendToggleItem( "general.alwaysInFront", m_window, "alwaysInFront" );
			appendSeparator();
			appendItem( PREFIX + "window.minimizeMute", m_player.minimizeMute );
			appendItem( "general.minimize", _onMinimize );
			appendToggleItem( PREFIX + "window.fullscreen", m_player, "isFullscreen" );
			
			popSubmenu();
		}
		
		private function _initSizeMenu():void 
		{
			pushSubmenu( PREFIX + "size.label" );
			
			var scale:String = "!" + Localization.substitude( PREFIX + "size.scale" );
			scale += " ";
			appendItem( scale + "50%",	function( ...e ):void { m_player.sizeMod.setScale( 0.5 ); }, "5", true );
			appendItem( scale + "100%",	function( ...e ):void { m_player.sizeMod.setScale( 1.0 ); }, "0", true );
			appendItem( scale + "200%",	function( ...e ):void { m_player.sizeMod.setScale( 2.0 ); }, "2", true );
			
			popSubmenu();
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