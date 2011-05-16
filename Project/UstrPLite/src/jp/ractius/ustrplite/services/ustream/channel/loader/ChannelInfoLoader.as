package jp.ractius.ustrplite.services.ustream.channel.loader 
{
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.data.channel.IChannelInfo;
	import jp.ractius.ustrplite.services.common.channel.loader.BaseChannelInfoLoader;
	import jp.ractius.ustrplite.services.ustream.channel.parser.ChannelInfoApiParser;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelInfoLoader extends BaseChannelInfoLoader
	{
		
		public function ChannelInfoLoader( channel:ChannelUpdater ) 
		{
			super( channel, new ApiUrlProvider() );
		}
		
		override protected function createChannelInfo( data:String ):IChannelInfo 
		{
			return new ChannelInfoApiParser( data );
		}
		
	}

}