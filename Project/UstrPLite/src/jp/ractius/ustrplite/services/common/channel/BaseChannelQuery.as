package jp.ractius.ustrplite.services.common.channel 
{
	import flash.events.Event;
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.common.channel.loader.BaseChannelLoader;
	import jp.ractius.ustrplite.services.IChannelQuery;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelQuery implements IChannelQuery 
	{
		private var m_loaderQue:Vector.<BaseChannelLoader>;
		
		public function BaseChannelQuery() 
		{
			m_loaderQue = new Vector.<BaseChannelLoader>();
		}
		
		private function _beginLoad( loader:BaseChannelLoader ):void
		{
			loader.addEventListener( Event.COMPLETE, _onLoadComplete );
			loader.load();
		}
		
		private function _onLoadComplete( e:Event ):void 
		{
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			if ( m_loaderQue.length > 0 )
			{
				_beginLoad( m_loaderQue.shift() );
			}
		}
		
		protected function push( loader:BaseChannelLoader ):void
		{
			if ( m_loaderQue.length == 0 )	_beginLoad( loader );
			else							m_loaderQue.push( loader );
		}
		
		public function updateInfo( channel:ChannelUpdater ):void
		{
			// override me
		}
		
	}

}