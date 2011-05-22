package jp.ractius.ustrplite.browser 
{
	import flash.display.DisplayObject;
	import jp.ractius.ripple.air.WindowBounds;
	import jp.ractius.ripple.air.WindowMoveController;
	import jp.ractius.ripple.air.WindowResizeController;
	import jp.ractius.ripple.display.NoScaleStageSprite;
	import jp.ractius.ripple.display.resizableFrame.ResizableFrame;
	import jp.ractius.ripple.display.RoundRectShadowSprite;
	import jp.ractius.ripple.display.RoundRectShape;
	import jp.ractius.ripple.events.WindowBoundsEvent;
	import jp.ractius.ripple.gui.GuiUtil;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.gui.browser.MainPanel;
	import jp.ractius.ustrplite.player.PlayerWindow;
	import jp.ractius.ustrplite.services.IChannelUri;
	import jp.ractius.ustrplite.services.IService;
	import jp.ractius.ustrplite.services.Services;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Browser extends NoScaleStageSprite 
	{
		static private const SHADOW_SIZE:Number		= 15;
		static private const SHADOW_SIZE2:Number	= SHADOW_SIZE * 2;
		static private const SHADOW_DIST:Number		= 5;
		static private const CORNER_RADIUS:Number	= 7.5;
		
		static private var s_inst:Browser;
		
		private var m_shadow:RoundRectShadowSprite;
		private var m_panelMask:DisplayObject;
		private var m_panel:MainPanel;
		private var m_resizeFrame:ResizableFrame;
		
		private var m_windowBounds:WindowBounds;
		private var m_windowMoveCtrl:WindowMoveController;
		private var m_windowResizeCtrl:WindowResizeController;
		
		public function Browser() 
		{
			super();
		}
		
		static public function get inst():Browser
		{
			if ( !s_inst )
			{
				s_inst = new Browser();
			}
			
			return s_inst;
		}
		
		public function get windowBounds():WindowBounds { return m_windowBounds; }
		
		public function play( url:String ):void
		{
			var ch:ChannelData = Services.parseUri( url );
			
			if ( !ch ) return;
			
			new PlayerWindow( ch );
		}
		
		public function addFav( url:String ):void
		{
			var ch:ChannelData = Services.parseUri( url );
			
			if ( !ch ) return;
			
			//TODO サービス毎の判定
			if ( ch.serviceName == "Ltb" ) return;
			
			FavoriteStore.inst.addFav( ch );
		}
		
		override protected function onAddToStage():void 
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
			m_panel			= new MainPanel();
			m_panel.mask 	= m_panelMask;
			addChild( m_panel );
			GuiUtil.initLayout( m_panel );
			
			// init ResizeFrame
			m_resizeFrame = new ResizableFrame();
			addChild( m_resizeFrame );
			
			// init WindowControllers
			m_windowResizeCtrl	= new WindowResizeController( m_resizeFrame, m_windowBounds );
			
			m_windowBounds.addEventListener( WindowBoundsEvent.RESIZING, _onResizing );
			_onResizing();
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