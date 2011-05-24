package jp.ractius.ustrplite.browser.skins 
{
	import flash.display.Stage;
	import jp.ractius.ripple.air.RNativeMenu;
	import jp.ractius.ripple.air.WindowMoveController;
	import jp.ractius.ustrplite.browser.Browser;
	import jp.ractius.ustrplite.gui.browser.MiniMainPanel;
	import jp.ractius.ustrplite.UstrpliteConstants;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class MiniSkin extends BaseSkin 
	{
		static public const NAME:String = UstrpliteConstants.BROWSER_SKIN_MINI;
		
		private var m_windowMove:WindowMoveController;
		private var m_menu:RNativeMenu;
		
		private var m_miniPanel:MiniMainPanel;
		
		public function MiniSkin( stage:Stage ) 
		{
			super( stage );
			
			windowBounds.setSize( 180 + 30, 50 + 30 );
			resizeFrame.visible = false;
			
			m_windowMove = new WindowMoveController( m_miniPanel, windowBounds );
			_initMenu( stage );
		}
		
		private function _initMenu( stage:Stage ):void 
		{
			m_menu = new RNativeMenu();
			m_menu.appendItem( "browser.miniMenu.switchSkin",	_onSwitchSkin );
			m_menu.appendSeparator();
			m_menu.appendToggleItem( "general.alwaysInFront",	stage.nativeWindow, "alwaysInFront" );
			m_menu.appendSeparator();
			m_menu.appendItem( "general.minimize",				onMinimize );
			m_menu.appendItem( "general.exit",					onExit );
		}
		
		private function _onSwitchSkin( ...e ):void 
		{
			Browser.inst.changeSkin( StandardSkin.NAME );
		}
		
		public function showMenu( x:Number, y:Number ):void
		{
			m_menu.display( stage, x, y );
		}
		
		override protected function createPanel():JPanel 
		{
			return m_miniPanel = new MiniMainPanel();
		}
		
	}

}