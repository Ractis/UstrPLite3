package jp.ractius.ustrplite.gui.browser.column 
{
	import flash.display.BlendMode;
	import jp.ractius.ripple.gui.panels.VerticalBorderPanel;
	import jp.ractius.ustrplite.gui.browser.column.content.channel.ChannelsPanel;
	import jp.ractius.ustrplite.gui.browser.column.content.channel.FavoritesPanel;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JViewport;
	import org.aswing.SolidBackground;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ColumnPanel extends VerticalBorderPanel 
	{
		private var m_vp:JViewport;
		private var m_currentView:JPanel;
		
		private var m_scrollBarWidth:int;
		
		public function ColumnPanel() 
		{
			setName( "ColumnPanel" );
			
			setBackgroundDecorator( new SolidBackground( new ASColor( 0xFFFFFF ) ) );
			
			blendMode = BlendMode.LAYER;
			alpha = 0.9;
			
			// TEST
			m_vp.setView( m_currentView = new FavoritesPanel() );
		}
		
		override protected function createCenter():Component 
		{
			m_vp = new JViewport( null, true, false );
			m_vp.setVerticalAlignment( JViewport.TOP );
			
			var scrollPanel:JScrollPane = new JScrollPane( m_vp, JScrollPane.SCROLLBAR_ALWAYS );;
			m_scrollBarWidth = scrollPanel.getVerticalScrollBar().getPreferredWidth();
			
			return scrollPanel;
		}
		
		override public function setSize( newSize:IntDimension ):void 
		{
			m_currentView.setPreferredWidth( newSize.width - m_scrollBarWidth );
			
			super.setSize( newSize );
		}
		
	}

}