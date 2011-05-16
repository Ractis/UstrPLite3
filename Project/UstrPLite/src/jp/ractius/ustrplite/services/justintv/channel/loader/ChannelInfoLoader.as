package jp.ractius.ustrplite.services.justintv.channel.loader 
{
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.data.channel.IChannelInfo;
	import jp.ractius.ustrplite.services.common.channel.loader.BaseChannelInfoLoader;
	import jp.ractius.ustrplite.services.justintv.channel.parser.ChannelInfoApiParser;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelInfoLoader extends BaseChannelInfoLoader 
	{
		
		public function ChannelInfoLoader( channel:ChannelUpdater ) 
		{
			super( channel, new ApiUrlProvider() );
			
			// チャンネルステータスは別に取得
			new ChannelStatusLoader( channel.clone() );
		}
		
		override protected function createChannelInfo( data:String ):IChannelInfo 
		{
			return new ChannelInfoApiParser( data );
		}
		
	}

}