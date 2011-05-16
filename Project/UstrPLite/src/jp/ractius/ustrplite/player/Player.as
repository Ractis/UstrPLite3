package jp.ractius.ustrplite.player 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import jp.ractius.ripple.air.WindowBounds;
	import jp.ractius.ripple.air.WindowMoveController;
	import jp.ractius.ripple.air.WindowResizeController;
	import jp.ractius.ripple.air.WindowResizeKeepARController;
	import jp.ractius.ripple.display.NoScaleStageSprite;
	import jp.ractius.ripple.display.resizableFrame.ResizableFrame;
	import jp.ractius.ripple.net.LocalSocket;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.events.ChannelEvent;
	import jp.ractius.ustrplite.events.ResizeEvent;
	import jp.ractius.ustrplite.events.VolumeEvent;
	import jp.ractius.ustrplite.player.modules.InputModule;
	import jp.ractius.ustrplite.player.modules.SizeModule;
	import jp.ractius.ustrplite.player.modules.VolumeModule;
	import jp.ractius.ustrplite.services.IPlayerOption;
	import jp.ractius.ustrplite.services.Services;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Player extends NoScaleStageSprite 
	{
		private var m_channel:ChannelData;
		private var m_option:IPlayerOption;
		private var m_sessionId:String;
		
		private var m_socket:LocalSocket;
		private var m_isInitCrostr:Boolean;
		
		private var m_resizableFrame:ResizableFrame;
		private var m_windowBounds:WindowBounds;
		private var m_windowMoveCtrl:WindowMoveController;
		private var m_windowResizeCtrl:WindowResizeController;
		
		private var m_sizeMod:SizeModule;
		private var m_volumeMod:VolumeModule;
		private var m_inputMod:InputModule;
		
		private var m_background:Shape;
		private var m_crostrDisp:CrostrDisp;
		private var m_overlay:Sprite;
		
		public function Player( channel:ChannelData ) 
		{
			m_channel	= channel;
			m_option	= Services.getService( channel.serviceName ).createPlayerOption();
			m_sessionId	= escape( String( new Date().time ) );
			
			super();
		}
		
		override protected function onAddToStage():void 
		{	
			_initLocalSocket();
			_initWindowControllers();
			_initModules();
			
			_initBackground();
			_initCrostr();
			_initOverlay();
			
			m_windowMoveCtrl	= new WindowMoveController( m_overlay, m_windowBounds );
			
			addChild( m_resizableFrame );
			
			m_sizeMod.addEventListener( ResizeEvent.RESIZE, _onResize );
			m_volumeMod.addEventListener( VolumeEvent.CHANGE_VOLUME, _setVolume );
			
			_onResize();
		}
		
		private function _initWindowControllers():void 
		{
			m_resizableFrame	= new ResizableFrame();
			m_windowBounds		= new WindowBounds( stage );
			// windowMoveCtrl は Overlay の後で
			m_windowResizeCtrl	= new WindowResizeKeepARController( m_resizableFrame, m_windowBounds );
		}
		
		private function _initCrostr():void 
		{
			addChild( m_crostrDisp = new CrostrDisp( m_option.name, m_sessionId, m_option.isRemote ) );
		}
		
		private function _initBackground():void 
		{
			addChild( m_background = new Shape() );
			_drawRect( m_background.graphics );
		}
		
		private function _initOverlay():void 
		{
			addChild( m_overlay = new Sprite() );
			_drawRect( m_overlay.graphics );
			m_overlay.alpha = 0.01;
		}
		
		private function _drawRect( g:Graphics ):void
		{
			g.beginFill( 0x000000 );
			g.drawRect( 0, 0, 200, 200 );
			g.endFill();
		}
		
		private function _onResize( ...e ):void 
		{	
			m_sizeMod.applyTo( m_background );
			m_sizeMod.applyTo( m_overlay );
			m_sizeMod.applyTo( m_resizableFrame );
			
			m_sizeMod.applyTo( m_crostrDisp );
		}
		
		private function _initLocalSocket():void 
		{
			var tgtDomain:String = m_option.isRemote ? CrostrDisp.CROSTR_REMOTE_DOMAIN : "";
			var connectionName:String = UstrpliteConstants.LOCAL_SOCKET_PREFIX + m_sessionId;
			m_socket = new LocalSocket( this, tgtDomain, connectionName, true );
		}
		
		private function _initModules():void 
		{
			m_sizeMod	= new SizeModule( m_windowBounds );
			m_volumeMod	= new VolumeModule();
			m_inputMod	= new InputModule( this );
		}
		
		private function _playChannel( ...e ):void
		{
			m_channel.removeEventListener( ChannelEvent.CHANGE_CHANNEL_ID, _playChannel );
			
			m_socket.send( "playChannel", m_channel.channelId );
		}
		
		private function _setVolume( ...e ):void
		{
			if ( !m_isInitCrostr ) return;
			m_socket.send( "setVolume", String( Number( m_volumeMod.volume ) / 100 ) );
		}
		
		public function get sizeMod():SizeModule { return m_sizeMod; }
		public function get volumeMod():VolumeModule { return m_volumeMod; }
		
		//------------------------------------------------------------------------------
		// From - Crostr
		//------------------------------------------------------------------------------
		public function onPrintCros( data:String ):void
		{
			// デバッグ用
			trace( data );
		}
		
		public function onInitCros( ...e ):void
		{
			m_isInitCrostr = true;
			_setVolume();
			
			if ( m_channel.channelId )	_playChannel();
			else						m_channel.addEventListener( ChannelEvent.CHANGE_CHANNEL_ID, _playChannel );
		}
		
	}

}