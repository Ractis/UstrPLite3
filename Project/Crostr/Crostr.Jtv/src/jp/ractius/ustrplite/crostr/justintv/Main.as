package jp.ractius.ustrplite.crostr.justintv
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import jp.ractius.ustrplite.crostr.BaseLoadRslCrostr;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends BaseLoadRslCrostr 
	{
		static private const API_KEY:String = "";	// for Release
	//	static private const API_KEY:String = "";	// for Develop
		
		static private const DEFAULT_WIDTH:Number	= 480;
		static private const DEFAULT_HEIGHT:Number	= 360;
		static private const DEFAULT_AR:Number		= DEFAULT_WIDTH / DEFAULT_HEIGHT;
		
		private var m_content:DisplayObject;
		private var m_api:Object;	// skins.ApiSkin
		
		public function Main():void 
		{
			super( "http://www.justin.tv/widgets/live_api_player.swf" +
				   "?video_height="	+ DEFAULT_HEIGHT +
				   "&video_width="	+ DEFAULT_WIDTH +
				   "&consumer_key="	+ API_KEY );
		}
		
		override protected function onLoadRsl( e:Event ):void 
		{
			super.onLoadRsl( e );
			
			m_content = rslLoader.content;
			addChild( m_content );
			
			m_api = Object( m_content ).api;
			
			stage.addEventListener( Event.RESIZE, _onResize );
			_onResize();
			
		//	m_api.addEventListener( "started", _onJtvEvent );
		//	m_api.addEventListener( "buffer_full", _onJtvEvent );
			m_api.addEventListener( "stream_viewer_count", _onStreamViewerCountJtv );
			m_api.addEventListener( "connected", _onConnectedJtv );
			
		//	m_api.addEventListener( "video", _onJtvEvent );
			
			sendInit();
		}
		
		private function _onStreamViewerCountJtv( e:Object ):void 
		{
			sendViewers( e.info.stream );
		}
		
		private function _onConnectedJtv( e:Event ):void 
		{
			m_api.jtv_video_player.ns.client.onMetaData = _onMetaDataNS;
		}
		
		private function _onJtvEvent( e:Object ):void
		{
			sendPrint( e.type, e.event, e.info );
			for each ( var val:Object in e.info ) sendPrint( " - " + val );
		}
		
		private function _onMetaDataNS( data:Object ):void
		{
			sendVideoSize( data.width, data.height );
			
			m_api.jtv_video.player.metadata_handler( data );
		}
		
		private function _onResize( ...e ):void 
		{
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			var ar:Number = w / h;
			
			if ( ar > DEFAULT_AR )		// 横長
			{
				h = w / DEFAULT_AR;
				
				m_content.x = 0;
				m_content.y = ( w / ar - h ) / 2;
			}
			else if ( ar < DEFAULT_AR )	// 縦長
			{
				w = h * DEFAULT_AR;
				
				m_content.x = ( h * ar - w ) / 2;
				m_content.y = 0;
			}
			else						// 4:3
			{
				m_content.x = 0;
				m_content.y = 0;
			}
			
			_setSize( w, h );
			_setSize( w, h );	// 一定以上のデルタサイズだと、正しくリサイズ出来ない問題の対策
		}
		
		private function _setSize( w:Number, h:Number ):void
		{
			m_content.width  = w;
			m_content.height = h;
		}
		
		override protected function onPlay():void 
		{
			m_api.play_live( channelId );
		}
		
		override protected function onRefresh():void 
		{
			m_api.pause_video();
			m_api.resume_video();
		}
		
	}
	
}