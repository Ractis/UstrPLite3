package jp.ractius.ustrplite.crostr.ustream
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import jp.ractius.ustrplite.crostr.BaseLoadRslCrostr;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends BaseLoadRslCrostr 
	{
		private var m_logic:Object;
		private var m_channel:Object;
		
		public function Main():void 
		{
			super( "http://www.ustream.tv/flash/viewer.rsl.swf" );
		}
		
		override protected function onLoadRsl( e:Event ):void 
		{
			super.onLoadRsl( e );
			
			var Logic:Class = getClassDefinition( "tv.ustream.viewer.logic.Logic" );
			m_logic = new Logic();
			viewer = m_logic.display;
			
			sendInit();
		}
		
		override protected function onPlayChannel():void 
		{
			_play();
		}
		
		override protected function onSetPassword():void 
		{
			_play();
		}
		
		private function _play():void 
		{
			if ( m_channel )
			{
				m_logic.destroy();
				m_channel = null;
			}
			
			m_channel = m_logic.createChannel( channelId, /*autoPlay ="*/true, password );
			m_channel.addEventListener( "getStreamSize", _onGetStreamSize );
		}
		
		private function _onGetStreamSize( e:Event ):void 
		{
			var bounds:Rectangle = m_channel.streamRect;
			sendVideoSize( bounds.width, bounds.height );
		}
		
	}
	
}