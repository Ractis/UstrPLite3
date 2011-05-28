package jp.ractius.ustrplite.gui.player.vanilla 
{
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.AssetPane;
	import org.aswing.BorderLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class InfoTip extends JPanel 
	{
		[Embed(source = 'assets/Volume.png')]	static public const VolumeIconImg:Class;
		[Embed(source = 'assets/Viewers.png')]	static public const ViewersIconImg:Class;
		
		private var m_label:JLabel;
		
		public function InfoTip( IconImg:Class ) 
		{
			super( new BorderLayout( -10 ) );
			
			m_label = new JLabel( "", null, JLabel.RIGHT );
			
			append( _createIconPanel( IconImg ),	BorderLayout.WEST );
			append( m_label,						BorderLayout.CENTER );
			
			setSize( new IntDimension( 50, 30 ) );
			validate();
			
			// Color
			m_label.setForeground( new ASColor( 0xDDDDDD ) );
			
			// Font
			var font:ASFont = m_label.getFont();
			font.changeSize( 8 );
			m_label.setFont( font );
			
			// Filter
			var filter:GlowFilter = new GlowFilter( 0x000000 );
			filter.strength = 3;
			m_label.setTextFilters( [ filter ] );
		}
		
		private function _createIconPanel( IconImg:Class ):JPanel
		{
			var panel:JPanel = new JPanel();
			panel.setClipMasked( false );
			panel.setPreferredSize( new IntDimension( 22, 25 ) );
			
			var icon:DisplayObject = new IconImg();
			icon.y = 3;
			panel.addChild( icon );
			
			return panel;
		}
		
		public function set label( v:String ):void
		{
			m_label.setText( v );
		}
		
	}

}