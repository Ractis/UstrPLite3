package jp.ractius.ustrplite.gui.browser.column 
{
	import flash.display.BlendMode;
	import jp.ractius.ripple.gui.panels.VerticalBorderPanel;
	import jp.ractius.ustrplite.gui.browser.column.content.channel.FavoritesPanel;
	import org.aswing.ASColor;
	import org.aswing.Component;
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
		
		public function ColumnPanel() 
		{
			setName( "ColumnPanel" );
			
			setBackgroundDecorator( new SolidBackground( new ASColor( 0xFFFFFF ) ) );
			
			blendMode = BlendMode.LAYER;
			alpha = 0.9;
			
			// TEST
			m_vp.setView( new FavoritesPanel() );
		}
		
		override protected function createCenter():Component 
		{
			m_vp = new JViewport( null, true, false );
			m_vp.setVerticalAlignment( JViewport.TOP );
			
			return new JScrollPane( m_vp, JScrollPane.SCROLLBAR_ALWAYS );
		}
		
	}

}