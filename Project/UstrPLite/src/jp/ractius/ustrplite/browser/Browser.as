package jp.ractius.ustrplite.browser 
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.events.Event;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import jp.ractius.ripple.display.NoScaleStageSprite;
	import jp.ractius.ripple.utils.CapabilityUtil;
	import jp.ractius.ustrplite.browser.skins.BaseSkin;
	import jp.ractius.ustrplite.browser.skins.MiniSkin;
	import jp.ractius.ustrplite.browser.skins.StandardSkin;
	import jp.ractius.ustrplite.configs.BrowserConfig;
	import jp.ractius.ustrplite.configs.ConfigManager;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.data.playing.PlayingStore;
	import jp.ractius.ustrplite.events.BrowserEvent;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Browser extends NoScaleStageSprite 
	{
		static private var s_inst:Browser;
		
		private var m_skins:Dictionary;
		private var m_currentSkin:BaseSkin;
		
		private var m_menu:BrowserMenu;
		private var m_nativeAppIcon:BrowserNativeAppIcon;
		
		public function Browser() 
		{
			super();
		}
		
		private function _exitApplication( e:Event ):void 
		{
			_saveConfig();
			NativeApplication.nativeApplication.exit();
		}
		
		private function _onDisplayStateChange( e:NativeWindowDisplayStateEvent ):void 
		{
			if ( e.afterDisplayState == NativeWindowDisplayState.MINIMIZED )
			{
				stage.nativeWindow.visible = false;
			}
		}
		
		override protected function onAddToStage():void 
		{
			super.onAddToStage();
			
			// init NativeAppIcon
			if ( CapabilityUtil.isSupportNativeAppIcon )
			{
				m_nativeAppIcon = new BrowserNativeAppIcon();
			}
			
			// init Skins
			m_skins = new Dictionary();
			m_skins[ StandardSkin.NAME ]	= new StandardSkin( stage );
			m_skins[ MiniSkin.NAME ]		= new MiniSkin( stage );
			
			// load Configs
			_loadConfig();
			
			// init Menu
			m_menu = new BrowserMenu();
			
			// Listeners
			var window:NativeWindow = stage.nativeWindow;
			window.addEventListener( NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, _onDisplayStateChange );
			window.addEventListener( Event.CLOSE, _exitApplication );
		}
		
		private function _loadConfig():void 
		{
			var cfg:BrowserConfig = _config;
			
			stage.nativeWindow.alwaysInFront = cfg.alwaysInFront;
			
			// WindowBounds
			for ( var skinName:String in m_skins )
			{
				var bounds:Rectangle = cfg.getWindowBounds( skinName );
				if ( !bounds ) continue;
				
				m_skins[ skinName ].windowBounds.bounds = bounds;
			}
			
			/// Skin
			var skin:String = cfg.skin;
			if ( !skin ) skin = UstrpliteConstants.BROWSER_SKIN_STD;	// DEFAULT
			Browser.inst.switchSkin( skin );
		}
		
		private function _saveConfig():void
		{
			var cfg:BrowserConfig = _config;
			
			cfg.alwaysInFront	= stage.nativeWindow.alwaysInFront;
			cfg.skin			= currentSkinName;
			
			for ( var skinName:String in m_skins )
			{
				cfg.setWindowBounds( skinName, m_skins[ skinName ].windowBounds.bounds );
			}
			
			cfg.save();
		}
		
		private function get _config():BrowserConfig
		{
			return BrowserConfig( ConfigManager.getConfig( UstrpliteConstants.CONFIG_BROWSER ) );
		}
		
		static public function get inst():Browser
		{
			if ( !s_inst )
			{
				s_inst = new Browser();
			}
			
			return s_inst;
		}
		
		public function getSkin( name:String ):BaseSkin
		{
			return m_skins[ name ];
		}
		
		public function switchSkin( name:String ):void
		{
			if ( m_currentSkin )
			{
				removeChild( m_currentSkin );
			}
			
			m_currentSkin = m_skins[ name ];
			addChild( m_currentSkin );
			
			dispatchEvent( new BrowserEvent( BrowserEvent.SWITCH_SKIN ) );
		}
		
		public function get currentSkinName():String
		{
			return m_currentSkin.skinName;
		}
		
		public function play( url:String, isInvoke:Boolean = false ):void
		{
			if ( !isInvoke )
			{
				var args:Array = url.split( " " );
				
				switch ( args[0].toLowerCase() )
				{
				case "changeskin":
				case "switchskin":
					if ( m_currentSkin is StandardSkin )	switchSkin( MiniSkin.NAME );
					else									switchSkin( StandardSkin.NAME );
					break;
					
				case "importfav":
					var url:String = args[1];
					if ( url )
					{
						var urlLoader:URLLoader = new URLLoader();
						urlLoader.addEventListener( Event.COMPLETE, function( e:Event ):void
						{
							FavoriteStore.inst.deserialize( e.target.data );
						} );
						urlLoader.load( new URLRequest( url ) );
					}
					break;
				}
			}
			
			var ch:ChannelData = ChannelStore.inst.getChannelByUri( url );
			PlayingStore.inst.play( ch );
		}
		
		public function addFav( url:String ):void
		{
			var ch:ChannelData = ChannelStore.inst.getChannelByUri( url );
			
			if ( !ch ) return;
			
			//TODO サービス毎の判定
			if ( ch.serviceName == "Ltb" ) return;
			
			FavoriteStore.inst.addFav( ch );
		}
		
		public function minimize( ...e ):void
		{
			stage.nativeWindow.minimize();
		}
		
		public function exit( ...e ):void
		{
			stage.nativeWindow.close();
		}
		
		public function showMenu( x:Number, y:Number ):void
		{
			m_menu.display( stage, x, y );
		}
		
	}

}