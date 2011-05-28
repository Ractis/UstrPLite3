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
		
		override protected function onPlay():void 
		{
			if ( m_channel )
			{
				m_channel.destroy();
				m_channel = null;
				
				m_logic.destroy();
			}
			
			m_channel = m_logic.createChannel( channelId, /*autoPlay ="*/true, password );
			
			m_channel.addEventListener( "getStreamSize", _onGetStreamSize );
			
			if ( _modules )	_onCreateModules();
			else			m_channel.addEventListener( "createModules", _onCreateModules );
		}
		
		override protected function onRefresh():void 
		{
			onPlay();
		}
		
		private function _onCreateModules( e:Event = null ):void 
		{
			if ( e ) e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			_modules.addEventListener( "createViewers", _onCreateViewersModule );
		}
		
		private function _onCreateViewersModule( e:Event ):void 
		{
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			_modules.viewers.addEventListener( "update", function( e:Event ):void
			{
				sendViewers( uint( e.target.toString() ) );
			} );
		}
		
		private function _onGetStreamSize( e:Event ):void 
		{
			var bounds:Rectangle = m_channel.streamRect;
			sendVideoSize( bounds.width, bounds.height );
		}
		
		private function get _modules():Object { return m_channel.modules; }
		
	}
	
}