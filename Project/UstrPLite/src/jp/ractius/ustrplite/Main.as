package jp.ractius.ustrplite
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.ractius.ripple.gui.plaf.RLookAndFeel;
	import jp.ractius.ripple.ui.mouseCursor.MouseCursorManager;
	import jp.ractius.ripple.utils.Localization;
	import jp.ractius.ustrplite.browser.Browser;
	import jp.ractius.ustrplite.configs.ConfigManager;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.services.Services;
	import org.aswing.AsWingManager;
	import org.aswing.UIManager;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends Sprite 
	{
		private var m_updater:ApplicationUpdaterUI;
		
		private var m_channelUpdateTimer:Timer;
		
		public function Main():void 
		{
		//	Localization.initialize( "english" );
			Localization.initialize();
			MouseCursorManager.initialize();
			Services.initialize();
			ConfigManager.initialize();
			
			AsWingManager.setRoot( this );
			UIManager.setLookAndFeel( new RLookAndFeel() );
			
			addChild( Browser.inst );
			Browser.inst.changeSkin( UstrpliteConstants.BROWSER_SKIN_STD );
			
			_initUpdater();
			_executeTimer();
			
			NativeApplication.nativeApplication.addEventListener( InvokeEvent.INVOKE, _onInvoke );
		}
		
		private function _onInvoke( e:InvokeEvent ):void 
		{
			if ( e.arguments.length == 0 ) return;
			
			Browser.inst.play( e.arguments[0] );
		}
		
		private function _executeTimer():void 
		{
			m_channelUpdateTimer = new Timer( 10 * 60 * 1000 );
			
			m_channelUpdateTimer.addEventListener( TimerEvent.TIMER, function( e:Event ):void
			{
				ChannelStore.inst.updateInfoAll();
			} );
			
			m_channelUpdateTimer.start();
		}
		
		private function _initUpdater():void 
		{
			m_updater = new ApplicationUpdaterUI();
			
			m_updater.updateURL = "http://ractis.rdy.jp/update/ustp/update-descriptor-v3-alpha.xml";
			m_updater.isCheckForUpdateVisible = false;
			
			m_updater.addEventListener( UpdateEvent.INITIALIZED, function( e:UpdateEvent ):void
			{
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				m_updater.checkNow();
			} );
			m_updater.initialize();
		}
		
	}
	
}