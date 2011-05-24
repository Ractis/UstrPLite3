package jp.ractius.ripple.gui.buttons 
{
	import flash.events.MouseEvent;
	import jp.ractius.ripple.utils.Localization;
	import org.aswing.Insets;
	import org.aswing.JButton;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RButton extends JButton 
	{
		private var m_model:RButtonModel;
		
		public function RButton( name:String = "", toolTip:String = "" ) 
		{
			super( Localization.substitude( name ) );
			
			if ( toolTip != "" ) setToolTipText( Localization.substitude( toolTip ) );
			
			setMargin( new Insets( 3, 6, 5, 7 ) );
			
			m_model = new RButtonModel( getModel(), onState );
			
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		protected function onMouseDown( e:MouseEvent ):void 
		{
			e.stopPropagation();
		}
		
		protected function onState( type:String, isActive:Boolean ):void 
		{
			// override me
		}
		
		public function get model():RButtonModel { return m_model; }
		
	}

}