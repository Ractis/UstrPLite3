package jp.ractius.ustrplite.player 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import jp.ractius.ripple.display.NoScaleStageSprite;
	import jp.ractius.ripple.net.LocalSocket;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.events.ChannelEvent;
	import jp.ractius.ustrplite.events.ResizeEvent;
	import jp.ractius.ustrplite.player.modules.SizeModule;
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
		
		private var m_sizeMod:SizeModule;
		
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
			_initModules();
			
			_initBackground();
			_initCrostr();
			_initOverlay();
			
			m_sizeMod.addEventListener( ResizeEvent.RESIZE, _onResize );
			_onResize();
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
			
			m_sizeMod.applyTo( m_crostrDisp );
		}
		
		private function _initLocalSocket():void 
		{
			var tgtDomain:String = m_option.isRemote ? m_option.remoteDomain : "";
			var connectionName:String = UstrpliteConstants.LOCAL_SOCKET_PREFIX + m_sessionId;
			m_socket = new LocalSocket( this, tgtDomain, connectionName, true );
		}
		
		private function _initModules():void 
		{
			m_sizeMod	= new SizeModule( stage.stageWidth, stage.stageHeight );
		}
		
		private function _playChannel( ...e ):void
		{
			m_channel.removeEventListener( ChannelEvent.CHANGE_CHANNEL_ID, _playChannel );
			
			m_socket.send( "playChannel", m_channel.channelId );
		}
		
		//------------------------------------------------------------------------------
		// From - Crostr
		//------------------------------------------------------------------------------
		public function onPrintCros( data:String ):void
		{
			trace( data );
		}
		
		public function onInitCros( ...e ):void
		{	
			if ( m_channel.channelId )	_playChannel();
			else						m_channel.addEventListener( ChannelEvent.CHANGE_CHANNEL_ID, _playChannel );
		}
		
	}

}