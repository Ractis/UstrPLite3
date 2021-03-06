package jp.ractius.ripple.gui 
{
	import flash.display.DisplayObject;
	import org.aswing.ASColor;
	import org.aswing.border.LineBorder;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.JTextField;
	/**
	 * ...
	 * @author ractis
	 */
	public class GuiUtil 
	{
		
		public function GuiUtil() 
		{
			
		}
		
		static public function drawDebugBorder( tgt:Component, color:uint = 0x00FF00 ):void
		{
			tgt.setBorder( new LineBorder( null, new ASColor( color ), 3 ) );
		}
		
		static public function getTextAndClear( tf:JTextField ):String
		{
			var text:String = tf.getText();
			tf.setText( "" );
			return text;
		}
		
		static public function initLayout( tgt:Component ):void
		{
			tgt.pack();
			tgt.validate();
		}
		
		static public function applyIntDim( size:IntDimension, tgt:DisplayObject ):void
		{
			tgt.width	= size.width;
			tgt.height	= size.height;
		}
		
	}

}