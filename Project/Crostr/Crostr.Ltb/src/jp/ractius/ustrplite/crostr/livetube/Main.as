package jp.ractius.ustrplite.crostr.livetube
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.utils.escapeMultiByte;
	import flash.utils.unescapeMultiByte;
	import jp.ractius.ustrplite.crostr.BaseCrostr;
	import jp.ractius.ustrplite.crostr.livetube.events.VideoSizeEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends BaseCrostr 
	{
		private var m_loader:URLLoader;
		
		public function Main():void 
		{	
			super();
		}
		
		override protected function onAddToStage():void 
		{
			super.onAddToStage();
			
		//	onPlayChannel();	// for single test of this SWF
			
			sendInit();
		}
		
		override protected function onPlay():void 
		{
			var loader:ChannelPageLoader = new ChannelPageLoader();
			loader.addEventListener( Event.COMPLETE, _onLoadChannelPage );
			loader.load( unescapeMultiByte( channelId ) );
		}
		
		override protected function onRefresh():void 
		{
			var player:LivetubePlayer = viewer as LivetubePlayer;
			if ( !player ) return;
			
			player.refresh();
		}
		
		private function _onLoadChannelPage( e:Event ):void 
		{
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			_playStream( e.target.streamUrl );
		}
		
		private function _playStream( streamUrl:String ):void 
		{
		//	trace( streamUrl );
			sendPrint( streamUrl );
			
			var player:LivetubePlayer = new LivetubePlayer( streamUrl );
			viewer = player;
			
			player.addEventListener( VideoSizeEvent.GET_VIDEO_SIZE, _onGetVideoSize );
		}
		
		private function _onGetVideoSize( e:VideoSizeEvent ):void 
		{
			sendVideoSize( e.w, e.h );
		}
		
	}
	
}