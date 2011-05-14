package jp.ractius.ustrplite.crostr
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.system.Security;
	import jp.ractius.ripple.display.NoScaleStageSprite;
	import jp.ractius.ripple.net.LocalSocket;
	import jp.ractius.ripple.utils.CsvUtil;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseCrostr extends NoScaleStageSprite 
	{
		private var m_soundTransform:SoundTransform;
		private var m_socket:LocalSocket;
		private var m_viewer:Object;
		private var m_channelId:String;
		private var m_password:String;
		
		public function BaseCrostr():void 
		{
			super();
		}
		
		override protected function onAddToStage():void 
		{
			Security.allowDomain( "*" );
			
			m_soundTransform = SoundMixer.soundTransform;
			
			var sessionId:String = loaderInfo.parameters[ "sessionId" ];
			m_socket = new LocalSocket( this,
										"app#" + UstrpliteConstants.APPLICATION_ID,
										UstrpliteConstants.LOCAL_SOCKET_PREFIX + sessionId,
										false );
			
			stage.addEventListener( Event.RESIZE, _onResize );
		}
		
		private function _onResize():void 
		{
			_updateViewerSize();
		}
		
		protected final function get viewer():Object { return m_viewer; }
		
		protected final function set viewer( value:Object ):void 
		{
			if ( m_viewer )
			{
				removeChild( Sprite( m_viewer ) );
			}
			addChild( Sprite( m_viewer = value ) );
			
			m_viewer.width = 50;
			m_viewer.height = 50;
			_updateViewerSize();
		}
		
		protected final function get channelId():String { return m_channelId; }
		
		protected final function get password():String { return m_password; }
		
		private function _updateSoundTransform():void
		{
			SoundMixer.soundTransform = m_soundTransform;
		}
		
		private function _updateViewerSize():void
		{
			if ( m_viewer )
			{
				m_viewer.width	= stage.stageWidth;
				m_viewer.height	= stage.stageHeight;
			}
		}
		
		//------------------------------------------------------------------------------
		// OVERRIDE ME
		//------------------------------------------------------------------------------
		protected function onPlayChannel():void
		{
			
		}
		
		protected function onSetPassword():void
		{
			
		}
		
		//------------------------------------------------------------------------------
		// To - UstrPLite.Player
		//------------------------------------------------------------------------------
		protected final function sendPrint( ...rest ):void
		{
			m_socket.send( "onPrintCros", CsvUtil.toCsv( rest ) );
		}
		
		protected final function sendInit():void
		{
			m_socket.send( "onInitCros" );
		}
		
		protected final function sendVideoSize( w:uint, h:uint ):void
		{
			m_socket.send( "onVideoSizeCros", CsvUtil.toCsv( w, h ) );
		}
		
		protected final function sendViewers( viewers:uint ):void
		{
			m_socket.send( "onViewersCros", viewers.toString() );
		}
		
		protected final function sendNoPassword():void
		{
			m_socket.send( "onNoPasswordCros" );
		}
		
		//------------------------------------------------------------------------------
		// From - UstrPLite.Player
		//------------------------------------------------------------------------------
		public final function setVolume( data:String ):void
		{
			m_soundTransform.volume = Number( data );
			_updateSoundTransform();
		}
		
		public final function setPan( data:String ):void
		{
			m_soundTransform.pan = Number( data );
			_updateSoundTransform();
		}
		
		public final function playChannel( data:String ):void
		{
			m_channelId = data;
			onPlayChannel();
		}
		
		public final function setPassword( data:String ):void
		{
			m_password = data;
			onSetPassword();
		}
		
	}
	
}