package jp.ractius.ripple.gui.panels 
{
	import jp.ractius.ripple.utils.Algorithm;
	import org.aswing.BorderLayout;
	import org.aswing.Component;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class VerticalBorderPanel extends JPanel 
	{
		
		public function VerticalBorderPanel( orderOfCreation:String = "TBC", vgap:int = 0 ) 
		{
			super( new BorderLayout( 0, vgap ) );
			
			Algorithm.forEachChar( orderOfCreation, function( c:String ):void
			{
				switch ( c )
				{
				case "T":	append( createTop(),	BorderLayout.NORTH );	break;
				case "C":	append( createCenter(),	BorderLayout.CENTER );	break;
				case "B":	append( createBottom(),	BorderLayout.SOUTH );	break;
				}
			} );
		}
		
		protected function createTop():Component
		{
			// override me
			return new Component();
		}
		
		protected function createCenter():Component
		{
			// override me
			return new Component();
		}
		
		protected function createBottom():Component
		{
			// override me
			return new Component();
		}
		
	}

}