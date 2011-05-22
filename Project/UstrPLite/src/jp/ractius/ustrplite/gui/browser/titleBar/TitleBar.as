package jp.ractius.ustrplite.gui.browser.titleBar 
{
	import jp.ractius.ripple.air.WindowMoveController;
	import jp.ractius.ripple.display.DirectionalShadowShape;
	import jp.ractius.ripple.gui.panels.HorizontalBorderPanel;
	import jp.ractius.ustrplite.browser.Browser;
	import org.aswing.AssetBackground;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class TitleBar extends HorizontalBorderPanel 
	{
		static public const HEIGHT:Number = 26;
		
		private var m_shadow:DirectionalShadowShape;
		
		public function TitleBar() 
		{
			super( "CRL" );
			setName( "TitleBar" );
			setClipMasked( false );
			setPreferredHeight( HEIGHT );
			
			setBackgroundDecorator( new AssetBackground( new TitleBarOverlay() ) );
			
			m_shadow = new DirectionalShadowShape( 0, 18, 0.6 );
			m_shadow.y = HEIGHT;
			addChild( m_shadow );
			
			//TODO windowMove
			new WindowMoveController( this, Browser.inst.windowBounds );
		}
		
		override public function setSize( newSize:IntDimension ):void 
		{
			super.setSize( newSize );
			
			m_shadow.width = newSize.width;
		}
		
		override protected function createCenter():Component 
		{
			return super.createCenter();
		}
		
	}

}