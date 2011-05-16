package jp.ractius.ustrplite.crostr.justintv
{
	import flash.events.Event;
	import jp.ractius.ustrplite.crostr.BaseLoadRslCrostr;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends BaseLoadRslCrostr 
	{
		static private const API_KEY:String = "";
		
		private var m_api:Object;	// skins.ApiSkin
		
		public function Main():void 
		{
			var width:uint	= 480;
			var height:uint	= 360;
			
			super( "http://www.justin.tv/widgets/live_api_player.swf" +
				   "?video_height=" + height +
				   "&video_width=" + width +
				   "&consumer_key=" + API_KEY );
		}
		
		override protected function onLoadRsl( e:Event ):void 
		{
			super.onLoadRsl( e );
			
			viewer = rslLoader.content;
			
			m_api = viewer.api;
			
			sendInit();
		}
		
		override protected function onPlayChannel():void 
		{
			m_api.play_live( channelId );
		}
		
	}
	
}