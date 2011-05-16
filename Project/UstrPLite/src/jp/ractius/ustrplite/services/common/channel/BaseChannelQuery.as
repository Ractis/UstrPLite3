package jp.ractius.ustrplite.services.common.channel 
{
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.IChannelQuery;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelQuery implements IChannelQuery 
	{
		
		public function BaseChannelQuery() 
		{
			
		}
		
		public function updateInfo( channel:ChannelUpdater ):void
		{
			// override me
		}
		
	}

}