package jp.ractius.ustrplite.gui.browser 
{
	import jp.ractius.ripple.gui.RTextBox;
	import jp.ractius.ripple.utils.Localization;
	import jp.ractius.ustrplite.browser.Browser;
	import jp.ractius.ustrplite.gui.browser.miniMenu.MiniMenuButton;
	import org.aswing.BorderLayout;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowLayout;
	import org.aswing.JPanel;
	import org.aswing.JSpacer;
	import org.aswing.SoftBox;
	import org.aswing.SoftBoxLayout;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class MiniMainPanel extends MainPanel 
	{
		static private const MARGIN:Number = 6;
		
		private var m_urlTb:RTextBox;
		
		public function MiniMainPanel() 
		{
			super();
			setName( "MiniMainPanel" );
		}
		
		override protected function createTop():Component 
		{
			var panel:JPanel = new JPanel( new FlowLayout( FlowLayout.LEFT, 8, 0, true ) );
			panel.setPreferredHeight( 22 );
			
			panel.append( new MiniMenuButton() );
			
			return panel;
		}
		
		override protected function createCenter():Component 
		{
			m_urlTb = new RTextBox( Localization.substitude( "browser.control.textBox.default" ) );
			m_urlTb.mainTf.addActionListener( _onActionUrlTf );
		
			var panel:SoftBox = SoftBox.createVerticalBox( 0, SoftBoxLayout.CENTER );
			panel.append( m_urlTb );
			
			var panelWrap:JPanel = new JPanel( new BorderLayout( MARGIN, 0 ) );
			panelWrap.append( panel,			BorderLayout.CENTER );
			panelWrap.append( new JSpacer(),	BorderLayout.WEST );
			panelWrap.append( new JSpacer(),	BorderLayout.EAST );
			
			return panelWrap;
		}
		
		private function _onActionUrlTf( e:AWEvent ):void 
		{
			Browser.inst.play( m_urlTb.getTextAndClear() );
		}
		
		override protected function createBottom():Component 
		{
			return new JPanel();
		}
		
	}

}