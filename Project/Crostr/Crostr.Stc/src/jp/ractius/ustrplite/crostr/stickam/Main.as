package jp.ractius.ustrplite.crostr.stickam
{
	import flash.events.Event;
	import jp.ractius.ustrplite.crostr.BaseLoadRslCrostr;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends BaseLoadRslCrostr 
	{
		static private const PLAYER_CLASS_NAME:String = "jp.stickam.StickamLivePlayer";
		
		private var m_player:Object;
		
		public function Main():void 
		{
			super( "http://labs.stickam.jp/api/flash/v1/" );
		}
		
		override protected function onLoadRsl( e:Event ):void 
		{
			super.onLoadRsl( e );
			
			sendInit();
		}
		
		override protected function onPlayChannel():void 
		{
			if ( viewer ) return;
			
			var Player:Class = getClassDefinition( PLAYER_CLASS_NAME );
			
			m_player = new Player( _liveUrl );
			viewer = m_player;
			
			m_player.addEventListener( "media.play", _onMediaPlayStc );
			m_player.mediaPlay();
		}
		
		private function _onMediaPlayStc( e:Object ):void 
		{	
			if ( e.status == "fail" )
			{
				//sendPrint( e.error.message );
				return;
			}
			
			sendVideoSize( m_player.videoWidth, m_player.videoHeight );
		}
		
		private function get _liveUrl():String
		{
			return "http://www.stickam.jp/profile/" + channelId;
		}
		
	}
	
}