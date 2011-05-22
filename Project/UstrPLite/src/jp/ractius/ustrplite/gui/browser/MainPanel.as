package jp.ractius.ustrplite.gui.browser 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import jp.ractius.ripple.gui.panels.VerticalBorderPanel;
	import jp.ractius.ustrplite.gui.browser.column.ColumnArrayPanel;
	import jp.ractius.ustrplite.gui.browser.control.ControlPanel;
	import jp.ractius.ustrplite.gui.browser.titleBar.TitleBar;
	import org.aswing.AssetBackground;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.JSpacer;
	import org.aswing.SoftBox;
	import org.aswing.SoftBoxLayout;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class MainPanel extends VerticalBorderPanel 
	{
		[Embed(	source = 'assets/Bevel.png',
				scaleGridTop	= "9",
				scaleGridBottom	= "10",
				scaleGridLeft	= "9",
				scaleGridRight	= "10")]	static private const BevelImg:Class;
		
		public function MainPanel() 
		{
			setName( "MainPanel" );
			setClipMasked( false );
			setBackgroundDecorator( new AssetBackground( new MainPanelBackground() ) );
			
			var fg:InteractiveObject = new BevelImg();
			fg.mouseEnabled = false;
			setForegroundDecorator( new AssetBackground( fg ) );
		}
		
		override protected function createTop():Component 
		{
			var panel:SoftBox = SoftBox.createVerticalBox( 0, SoftBoxLayout.CENTER );
			
			panel.append( new TitleBar() );
			panel.append( new JSpacer( new IntDimension( 0, 12 ) ) );
			panel.append( new ControlPanel() );
			panel.append( new JSpacer( new IntDimension( 0, 12 ) ) );
			
			return panel;
		}
		
		override protected function createCenter():Component 
		{
			return new ColumnArrayPanel();
		}
		
		override protected function createBottom():Component 
		{
			return new JSpacer( new IntDimension( 0, 15 ) );
		}
		
	}

}