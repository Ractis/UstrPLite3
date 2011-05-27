package jp.ractius.ustrplite.browser.skins 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import jp.ractius.ripple.air.WindowBounds;
	import jp.ractius.ripple.air.WindowResizeController;
	import jp.ractius.ripple.display.resizableFrame.ResizableFrame;
	import jp.ractius.ripple.display.RoundRectShadowSprite;
	import jp.ractius.ripple.display.RoundRectShape;
	import jp.ractius.ripple.events.WindowBoundsEvent;
	import jp.ractius.ripple.gui.GuiUtil;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseSkin extends Sprite 
	{
		static private const SHADOW_SIZE:Number		= 15;
		static private const SHADOW_SIZE2:Number	= SHADOW_SIZE * 2;
		static private const SHADOW_DIST:Number		= 5;
		static private const CORNER_RADIUS:Number	= 7.5;
		
		private var m_shadow:RoundRectShadowSprite;
		private var m_panelMask:DisplayObject;
		private var m_panel:JPanel;
		private var m_resizeFrame:ResizableFrame;
		
		private var m_windowBounds:WindowBounds;
		private var m_windowResizeCtrl:WindowResizeController;
		
		public function BaseSkin( stage:Stage ) 
		{
			x = SHADOW_SIZE;
			y = SHADOW_SIZE - SHADOW_DIST;
			
			// init WindowBounds
			m_windowBounds = new WindowBounds( stage );
			
			// init Shadow
			m_shadow = new RoundRectShadowSprite( CORNER_RADIUS, SHADOW_SIZE, SHADOW_DIST );
			addChild( m_shadow );
			
			// init Mask
			m_panelMask		= new RoundRectShape( CORNER_RADIUS );
			addChild( m_panelMask );
			
			// init Panel
			m_panel			= createPanel();
			m_panel.mask 	= m_panelMask;
			addChild( m_panel );
			
			// init ResizeFrame
			m_resizeFrame = new ResizableFrame();
			addChild( m_resizeFrame );
			
			// init WindowControllers
			m_windowResizeCtrl	= new WindowResizeController( m_resizeFrame, m_windowBounds );
			
			m_windowBounds.addEventListener( WindowBoundsEvent.RESIZING, _onResizing );
			_onResizing();
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddToStage );
		}
		
		private function _onAddToStage( e:Event ):void 
		{
			GuiUtil.initLayout( m_panel );
			_onResizing();
		//	m_panel.revalidateIfNecessary();
		}
		
		public function get windowBounds():WindowBounds { return m_windowBounds; }
		
		public function get resizeFrame():ResizableFrame { return m_resizeFrame; }
		
		protected function createPanel():JPanel
		{
			// override me
			return new JPanel();
		}
		
		protected function onMinimize( ...e ):void
		{
			stage.nativeWindow.minimize();
		}
		
		protected function onExit( ...e ):void
		{
			stage.nativeWindow.close();
		}
		
		private function _onResizing( e:WindowBoundsEvent = null ):void 
		{
			var panelW:Number = m_windowBounds.w - SHADOW_SIZE2;
			var panelH:Number = m_windowBounds.h - SHADOW_SIZE2;
			
			var setSize:Function = function( tgt:DisplayObject ):void
			{
				tgt.width	= panelW;
				tgt.height	= panelH;
			};
			
			setSize( m_shadow );
			setSize( m_panelMask );
			setSize( m_resizeFrame );
			
			m_panel.setSizeWH( panelW, panelH );
			m_panel.revalidate();
		}
		
	}

}