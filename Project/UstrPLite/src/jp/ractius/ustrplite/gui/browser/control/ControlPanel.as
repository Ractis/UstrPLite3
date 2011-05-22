package jp.ractius.ustrplite.gui.browser.control 
{
	import jp.ractius.ripple.gui.buttons.RButton;
	import jp.ractius.ripple.gui.panels.HorizontalBorderPanel;
	import jp.ractius.ustrplite.browser.Browser;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JPanel;
	import org.aswing.JSpacer;
	import org.aswing.JTextField;
	import org.aswing.SoftBox;
	import org.aswing.SoftBoxLayout;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ControlPanel extends HorizontalBorderPanel 
	{
		static private const NAME_PREFIX:String = "browser.control.";
		
		private var m_UrlTf:JTextField;
		
		public function ControlPanel() 
		{
			setName( "ControlPanel" );
		}
		
		override protected function createLeft():Component 
		{
			return new JSpacer( new IntDimension( 13 ) );
		}
		
		override protected function createCenter():Component 
		{
			var panel:SoftBox = SoftBox.createVerticalBox( 0, SoftBoxLayout.CENTER );
			panel.append( m_UrlTf = new JTextField() );
			
			return panel;
		}
		
		override protected function createRight():Component 
		{
			var panel:JPanel = new JPanel( new FlowLayout( FlowLayout.CENTER ) );
			
			_appendBtn( panel, "play", function( e:AWEvent ):void
			{
				Browser.inst.play( _getAndClearText() );
			} );
			
			_appendBtn( panel, "addFav", function( e:AWEvent ):void
			{
				Browser.inst.addFav( _getAndClearText() );
			} );
			
			panel.append( new JSpacer( new IntDimension( 1 ) ) );
			
			return panel;
		}
		
		private function _getAndClearText():String
		{
			var text:String = m_UrlTf.getText();
			m_UrlTf.setText( "" );
			return text;
		}
		
		private function _appendBtn( panel:JPanel, name:String, listener:Function ):void
		{
			var button:RButton = new RButton( NAME_PREFIX + name + ".label",
											  NAME_PREFIX + name + ".toolTip" );
			button.addActionListener( listener );
			
			panel.append( button );
		}
		
	}

}