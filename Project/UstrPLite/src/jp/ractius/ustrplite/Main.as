package jp.ractius.ustrplite
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	import flash.display.Sprite;
	import jp.ractius.ripple.gui.plaf.RLookAndFeel;
	import jp.ractius.ripple.ui.mouseCursor.MouseCursorManager;
	import jp.ractius.ripple.utils.Localization;
	import jp.ractius.ustrplite.browser.Browser;
	import jp.ractius.ustrplite.prefs.PrefManager;
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
		
		public function Main():void 
		{
		//	Localization.initialize( "english" );
			Localization.initialize();
			MouseCursorManager.initialize();
			Services.initialize();
			PrefManager.initialize();
			
			AsWingManager.setRoot( this );
			UIManager.setLookAndFeel( new RLookAndFeel() );
			
			addChild( Browser.inst );
			Browser.inst.changeSkin( UstrpliteConstants.BROWSER_SKIN_STD );
			
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