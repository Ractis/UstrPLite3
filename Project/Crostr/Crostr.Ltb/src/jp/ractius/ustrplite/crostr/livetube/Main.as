package jp.ractius.ustrplite.crostr.livetube
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.utils.escapeMultiByte;
	import flash.utils.unescapeMultiByte;
	import jp.ractius.ustrplite.crostr.BaseCrostr;
	
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
		
		override protected function onPlayChannel():void 
		{
			super.onPlayChannel();
			
			var loader:ChannelPageLoader = new ChannelPageLoader();
			loader.addEventListener( Event.COMPLETE, _onLoadChannelPage );
			loader.load( unescapeMultiByte( channelId ) );
		}
		
		private function _onLoadChannelPage( e:Event ):void 
		{
			e.target.removeEventListener( e.type, arguments.callee );
			
			_playStream( e.target.streamUrl );
		}
		
		private function _playStream( streamUrl:String ):void 
		{
		//	trace( streamUrl );
			sendPrint( streamUrl );
			viewer = new LivetubePlayer( streamUrl );
		}
		
	}
	
}