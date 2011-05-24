package jp.ractius.ustrplite.services.common.channel.loader 
{
	import flash.events.Event;
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.data.channel.IChannelInfo;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelInfoLoader extends BaseChannelLoader 
	{
		
		public function BaseChannelInfoLoader( channel:ChannelUpdater, api:IApiUrlProvider ) 
		{
			super( channel, api.channelInfoUrl( channel.channelName ) );
		}
		
		protected function createChannelInfo( data:String ):IChannelInfo
		{
			// override me
			return null;
		}
		
		override protected function onLoad( e:Event ):void 
		{
			channel.updateInfo( createChannelInfo( data ) );
		}
		
	}

}