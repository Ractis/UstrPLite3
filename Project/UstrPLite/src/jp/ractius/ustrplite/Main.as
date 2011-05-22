package jp.ractius.ustrplite
{
	import flash.display.Sprite;
	import jp.ractius.ripple.gui.plaf.RLookAndFeel;
	import jp.ractius.ripple.ui.mouseCursor.MouseCursorManager;
	import jp.ractius.ripple.utils.Localization;
	import jp.ractius.ustrplite.browser.Browser;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.player.PlayerWindow;
	import jp.ractius.ustrplite.prefs.PrefManager;
	import jp.ractius.ustrplite.services.IChannelUri;
	import jp.ractius.ustrplite.services.IService;
	import jp.ractius.ustrplite.services.Services;
	import org.aswing.AsWingManager;
	import org.aswing.event.AWEvent;
	import org.aswing.JTextField;
	import org.aswing.UIManager;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends Sprite 
	{
		
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
		}
		
	}
	
}