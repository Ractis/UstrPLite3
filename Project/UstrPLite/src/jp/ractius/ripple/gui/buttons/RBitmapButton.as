package jp.ractius.ripple.gui.buttons 
{
	import org.aswing.geom.IntRectangle;
	import org.aswing.Insets;
	/**
	 * ...
	 * @author ractis
	 */
	public class RBitmapButton extends RButton 
	{
		
		public function RBitmapButton( toolTip:String = "" ) 
		{
			super( "", toolTip );
			
			setMargin( new Insets( 0, 0, 0, 0 ) );
		}
		
		override protected function paint( b:IntRectangle ):void 
		{
			//super.paint(b);
		}
		
	}

}