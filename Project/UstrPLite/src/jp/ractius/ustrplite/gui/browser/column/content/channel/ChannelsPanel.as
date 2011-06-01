package jp.ractius.ustrplite.gui.browser.column.content.channel 
{
	import flash.display.NativeMenu;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.playing.PlayingStore;
	import org.aswing.event.ContainerEvent;
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
		private var m_margin:Number	= 10;
		
		private var m_gridPanel:JPanel;
		private var m_gridLayout:GridLayout;
		
		public function ChannelsPanel() 
		{
			super( new FlowLayout( FlowLayout.CENTER, 0, 0, false ) );
			setName( "ChannelsPanel" );
			
			m_gridLayout = new GridLayout( 0, 1, m_margin, m_margin )
			m_gridPanel = new JPanel( m_gridLayout );
			append( m_gridPanel );
			
		//	GuiUtil.drawDebugBorder( m_gridPanel )
			
			m_gridPanel.addEventListener( ContainerEvent.COM_ADDED,		_updatePrefferedSize );
			m_gridPanel.addEventListener( ContainerEvent.COM_REMOVED,	_updatePrefferedSize );
		}
		
		private function _updatePrefferedSize( ...e ):void
		{
			var size:IntDimension = m_gridLayout.preferredLayoutSize( m_gridPanel );
			m_gridPanel.setPreferredSize( size );
			setPreferredSize( size );
		}
		
		override public function setPreferredWidth( preferredWidth:int ):void 
		{
			var cols:int = Math.floor( ( preferredWidth - m_margin * 2 ) / ( m_blockW + m_margin ) );
			if ( cols != m_gridLayout.getColumns() )
			{
				m_gridLayout.setColumns( cols );
				m_gridPanel.revalidate();
			}
			
			_updatePrefferedSize();
		}
		
		protected function appendBlock( channel:ChannelData, menu:NativeMenu ):ChannelBlockPanel
		{
			var panel:ChannelBlockPanel = new ChannelBlockPanel( channel );
			panel.setPreferredWidth( blockW );
			
			panel.addEventListener( MouseEvent.CLICK, function( e:Event ):void
			{
				PlayingStore.inst.play( e.target.channel );
			} );
			
			panel.contextMenu = menu;
			
			m_gridPanel.append( panel );
			
			return panel;
		}
		
		public function get blockW():Number { return m_blockW; }
		
		public function set blockW( value:Number ):void 
		{
			m_blockW = value;
		}
		
		public function get gridPanel():JPanel { return m_gridPanel; }
		
	}

}