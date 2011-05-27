package jp.ractius.ustrplite.crostr.justintv
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import jp.ractius.ustrplite.crostr.BaseLoadRslCrostr;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends BaseLoadRslCrostr 
	{
		static private const API_KEY:String = "";
		
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
			m_api.hide_ads();
			m_api.full_remove_and_prevent_ads();
			
			stage.addEventListener( Event.RESIZE, _onResize );
			_onResize();
			
			sendInit();
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
			
			m_content.width  = w;
			m_content.height = h;
			m_api.resize_player( w, h );
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