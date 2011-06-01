package jp.ractius.ustrplite.data.channel 
{
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.services.IChannelQuery;
	import jp.ractius.ustrplite.services.IChannelUri;
	import jp.ractius.ustrplite.services.IService;
	import jp.ractius.ustrplite.services.Services;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelStore 
	{
		static private var s_inst:ChannelStore;
		
		private var m_services:Dictionary;
		
		public function ChannelStore() 
		{
			m_services = new Dictionary();
		}
		
		static public function get inst():ChannelStore
		{
			if ( !s_inst )
			{
				s_inst = new ChannelStore();
			}
			
			return  s_inst;
		}
		
		public function getChannelByUri( url:String ):ChannelData
		{
			var uri:IChannelUri;
			Services.forEach( function( service:IService ):Boolean
			{
				uri = service.createChannelUri();
				
				if ( uri.test( url ) )	return false;	// サービスが見つかった
				else					return true;	// 見つからないので続行
			} );
			
			if ( !uri.channelName )
			{
				// 見つからなかった
				return null;
			}
			
			return getChannel( uri.serviceName, uri.channelName );
		}
		
		public function getChannel( serviceName:String, channelName:String ):ChannelData
		{
			var service:Dictionary = m_services[ serviceName ];
			
			if ( !service )
			{
				service = m_services[ serviceName ] = new Dictionary();
			}
			
			var channel:ChannelData = service[ channelName ];
			
			if ( !channel )
			{
				channel = service[ channelName ] = new ChannelData( serviceName, channelName );
				
				// 情報の更新
				_channelQuery( serviceName ).updateInfo( new ChannelUpdater( channel ) );
			}
			
			return channel;
		}
		
		public function updateInfoAll():void
		{
			for ( var svName:String in m_services )
			{
				for each ( var ch:ChannelData in m_services[ svName ] )
				{
					_channelQuery( svName ).updateInfo( new ChannelUpdater( ch ) );
				}
			}
		}
		
		private function _channelQuery( serviceName:String ):IChannelQuery
		{
			return Services.getService( serviceName ).channelQuery;
		}
		
	}

}