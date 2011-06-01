package jp.ractius.ustrplite.browser.skins 
{
	import flash.display.Stage;
	import jp.ractius.ripple.air.WindowMoveController;
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
		
		private var m_miniPanel:MiniMainPanel;
		
		public function MiniSkin( stage:Stage ) 
		{
			super( stage, NAME );
			
			windowBounds.setSize( 180 + 30, 50 + 30 );
			resizeFrame.visible = false;
			
			m_windowMove = new WindowMoveController( m_miniPanel, windowBounds );
		}
		
		override protected function createPanel():JPanel 
		{
			return m_miniPanel = new MiniMainPanel();
		}
		
	}

}