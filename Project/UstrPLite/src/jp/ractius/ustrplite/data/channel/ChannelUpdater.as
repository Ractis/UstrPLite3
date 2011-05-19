package jp.ractius.ustrplite.data.channel 
{	
	/**
	 * ...
	 * updateInfo か updateStatus を一度だけ呼ぶ。
	 * @author ractis
	 */
	public class ChannelUpdater 
	{
		private var m_tgt:ChannelData;
		
		public function ChannelUpdater( tgt:ChannelData ) 
		{
			m_tgt = tgt;
			
			m_tgt.beginUpdate();
		}
		
		public function clone():ChannelUpdater
		{
			return new ChannelUpdater( m_tgt );
		}
		
		public function get channelName():String { return m_tgt.channelName; }
		
		public function get tgt():ChannelData { return m_tgt; }
		
		public function updateInfo( info:IChannelInfo ):void
		{
			if ( info.isAvailable )
			{
				m_tgt.status		= info.status;
				m_tgt.channelId		= info.channelId;
				m_tgt.userName		= info.userName;
				m_tgt.title			= info.title;
				m_tgt.description	= info.description;
				m_tgt.hashTag		= info.hashTag;
				m_tgt.imageUrl		= info.imageUrl;
			}
			
			m_tgt.endUpdate();
		}
		
		public function updateStatus( status:IChannelStatus ):void
		{
			if ( status.isAvailable )
			{
				m_tgt.status	= status.status;
			}
			
			m_tgt.endUpdate();
		}
		
	}

}