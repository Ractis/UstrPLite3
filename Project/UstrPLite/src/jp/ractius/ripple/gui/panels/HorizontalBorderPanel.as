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
	public class HorizontalBorderPanel extends JPanel 
	{
		
		public function HorizontalBorderPanel( orderOfCreation:String = "LRC", hgap:int = 0 ) 
		{
			super( new BorderLayout( hgap, 0 ) );
			
			Algorithm.forEachChar( orderOfCreation, function( c:String ):void
			{
				switch ( c )
				{
				case "L":	append( createLeft(),	BorderLayout.WEST );	break;
				case "C":	append( createCenter(),	BorderLayout.CENTER );	break;
				case "R":	append( createRight(),	BorderLayout.EAST );	break;
				}
			} );
		}
		
		protected function createLeft():Component
		{
			// override me
			return new Component();
		}
		
		protected function createCenter():Component
		{
			// override me
			return new Component();
		}
		
		protected function createRight():Component
		{
			// override me
			return new Component();
		}
		
	}

}