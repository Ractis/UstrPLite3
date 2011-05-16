package jp.ractius.ustrplite.services.common.channel.loader 
{
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
			super( channel );
			
			load( api.channelInfoUrl( channelName ), _onLoad )
		}
		
		protected function createChannelInfo( data:String ):IChannelInfo
		{
			// override me
			return null;
		}
		
		private function _onLoad( ...e ):void 
		{
			channel.updateInfo( createChannelInfo( data ) );
		}
		
	}

}