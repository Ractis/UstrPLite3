package jp.ractius.ripple.gui.buttons 
{
	import jp.ractius.ripple.utils.Localization;
	import org.aswing.Insets;
	import org.aswing.JButton;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RButton extends JButton 
	{
		
		public function RButton( name:String = "", toolTip:String = "" ) 
		{
			super( Localization.substitude( name ) );
			
			if ( toolTip != "" ) setToolTipText( Localization.substitude( toolTip ) );
			
			setMargin( new Insets( 3, 6, 5, 7 ) );
		}
		
	}

}