package jp.ractius.ustrplite.gui.browser.column.content.channel 
{
	import org.aswing.FlowLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.GridLayout;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelsPanel extends JPanel 
	{
		private var m_blockW:Number	= 135;
		private var m_margin:Number	= 5;
		
		private var m_gridPanel:JPanel;
		private var m_gridLayout:GridLayout;
		
		public function ChannelsPanel() 
		{
			super( new FlowLayout( FlowLayout.CENTER, 0, 5, true ) );
			setName( "ChannelsPanel" );
			
			m_gridLayout = new GridLayout( 0, 1, m_margin, m_margin )
			m_gridPanel = new JPanel( m_gridLayout );
			append( m_gridPanel );
		}
		
		override public function setSize( newSize:IntDimension ):void 
		{
			m_gridLayout.setColumns( Math.floor( ( newSize.width - m_margin ) / ( m_blockW + m_margin ) ) );
			m_gridPanel.doLayout();
			
			super.setSize( newSize );
		}
		
		public function get blockW():Number { return m_blockW; }
		
		public function set blockW(value:Number):void 
		{
			m_blockW = value;
		}
		
		public function get gridPanel():JPanel { return m_gridPanel; }
		
	}

}