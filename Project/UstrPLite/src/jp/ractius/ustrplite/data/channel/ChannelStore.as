package jp.ractius.ustrplite.data.channel 
{
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.services.IChannelQuery;
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
				_channelQuery( serviceName ).updateInfo( channel );
			}
			
			return channel;
		}
		
		private function _channelQuery( serviceName:String ):IChannelQuery
		{
			return Services.getService( serviceName ).channelQuery;
		}
		
	}

}