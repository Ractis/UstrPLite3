package jp.ractius.ustrplite.gui.browser.titleBar 
{
	import flash.events.Event;
	import jp.ractius.ripple.air.WindowMoveController;
	import jp.ractius.ripple.display.DirectionalShadowShape;
	import jp.ractius.ripple.gui.HSpacer;
	import jp.ractius.ripple.gui.panels.HorizontalBorderPanel;
	import jp.ractius.ustrplite.browser.Browser;
	import jp.ractius.ustrplite.browser.skins.StandardSkin;
	import jp.ractius.ustrplite.gui.browser.miniMenu.MiniMenuButton;
	import org.aswing.AssetBackground;
	import org.aswing.Component;
	import org.aswing.FlowLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JPanel;
	import org.aswing.JSpacer;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class TitleBar extends HorizontalBorderPanel 
	{
		static public const HEIGHT:Number = 26;
		
		private var m_shadow:DirectionalShadowShape;
		private var m_rightWidth:int;
		
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
			var _this:TitleBar = this;
			addEventListener( Event.ADDED_TO_STAGE, function( e:Event ):void
			{
				e.currentTarget.removeEventListener( e.type, arguments.callee );
				new WindowMoveController( _this, Browser.inst.getSkin( StandardSkin.NAME ).windowBounds );
			} );
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
		
		override protected function createRight():Component 
		{
			var panel:JPanel = new JPanel( new FlowLayout( FlowLayout.LEFT, 0, 0, false ) );
			panel.append( new TitleBarButton( TitleBarButton.BUTTON_MINIMIZE ) );
			panel.append( new TitleBarButton( TitleBarButton.BUTTON_CLOSE ) );
			panel.append( new HSpacer( 5 ) );
			
			m_rightWidth = panel.getPreferredWidth();
			
			return panel;
		}
		
		override protected function createLeft():Component 
		{
			var panel:JPanel = new JPanel( new FlowLayout( FlowLayout.LEFT, 0, 0, false ) );
			panel.append( new HSpacer( 8 ) );
			panel.append( new MiniMenuButton() );
			panel.append( new HSpacer( m_rightWidth - panel.getPreferredWidth() ) );
			
			return panel;
		}
		
	}

}