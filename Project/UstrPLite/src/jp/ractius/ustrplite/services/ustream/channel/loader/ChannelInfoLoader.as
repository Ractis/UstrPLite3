package jp.ractius.ustrplite.services.ustream.channel.loader 
{
	import jp.ractius.ustrplite.services.common.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.common.channel.IChannelInfo;
	import jp.ractius.ustrplite.services.common.channel.loader.BaseChannelInfolLoader;
	import jp.ractius.ustrplite.services.ustream.channel.parser.ChannelInfoApiParser;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelInfoLoader extends BaseChannelInfolLoader
	{
		
		public function ChannelInfoLoader( updater:ChannelUpdater ) 
		{
			super( updater, ApiUrlProvider.channelInfoUrl( updater.channelName ) );
		}
		
		override protected function createChannelInfo( data:String ):IChannelInfo 
		{
			return new ChannelInfoApiParser( data );
		}
		
	}

}