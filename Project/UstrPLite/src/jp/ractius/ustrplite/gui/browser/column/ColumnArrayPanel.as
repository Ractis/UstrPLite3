package jp.ractius.ustrplite.gui.browser.column 
{
	import jp.ractius.ripple.gui.panels.HorizontalBorderPanel;
	import org.aswing.Component;
	import org.aswing.GridLayout;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ColumnArrayPanel extends HorizontalBorderPanel 
	{
		private var m_cols:JPanel;
		
		public function ColumnArrayPanel() 
		{
			super( "LRC", 10 );
			setName( "ColumnArrayPanel" );
			
			_appendColumn();
		}
		
		private function _appendColumn():void
		{
			m_cols.append( new ColumnPanel() );
		}
		
		override protected function createCenter():Component 
		{
			m_cols = new JPanel( new GridLayout( 1, 0, /*hgap = */10 ) );
			
			return m_cols;;
		}
		
	}

}