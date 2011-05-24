package jp.ractius.ustrplite.browser.skins 
{
	import flash.display.Stage;
	import jp.ractius.ustrplite.gui.browser.MainPanel;
	import jp.ractius.ustrplite.UstrpliteConstants;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class StandardSkin extends BaseSkin 
	{
		static public const NAME:String = UstrpliteConstants.BROWSER_SKIN_STD;
		
		public function StandardSkin( stage:Stage ) 
		{
			super( stage );
		}
		
		override protected function createPanel():JPanel 
		{
			return new MainPanel();
		}
		
	}

}