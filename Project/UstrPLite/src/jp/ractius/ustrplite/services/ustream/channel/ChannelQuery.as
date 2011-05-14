package jp.ractius.ustrplite.services.ustream.channel 
{
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.services.common.channel.BaseChannelQuery;
	import jp.ractius.ustrplite.services.common.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.ustream.channel.loader.ChannelInfoLoader;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelQuery extends BaseChannelQuery 
	{
		
		public function ChannelQuery() 
		{
			
		}
		
		override public function updateInfo( channel:ChannelData ):void 
		{
			new ChannelInfoLoader( new ChannelUpdater( channel ) );
		}
		
	}

}