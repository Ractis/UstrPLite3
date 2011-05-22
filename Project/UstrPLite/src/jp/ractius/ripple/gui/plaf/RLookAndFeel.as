package jp.ractius.ripple.gui.plaf 
{
	import org.aswing.plaf.ASFontUIResource;
	import org.aswing.plaf.basic.BasicLookAndFeel;
	import org.aswing.UIDefaults;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RLookAndFeel extends BasicLookAndFeel 
	{
		
		public function RLookAndFeel() 
		{
			
		}
		
		private function get _fontName():String
		{
			return "Meiryo";
		}
		
		override protected function initSystemFontDefaults( table:UIDefaults ):void 
		{
			var defaultSystemFonts:Array =
			[
				"systemFont",	new ASFontUIResource( _fontName, 11 ), 
				"menuFont",		new ASFontUIResource( _fontName, 11 ), 
				"controlFont",	new ASFontUIResource( _fontName, 11, false ), 
				"windowFont",	new ASFontUIResource( _fontName, 11, true )
			];
			table.putDefaults( defaultSystemFonts );
		}
		
	}

}