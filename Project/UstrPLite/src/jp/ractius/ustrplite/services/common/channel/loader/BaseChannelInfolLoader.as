package jp.ractius.ustrplite.services.common.channel.loader 
{
	import jp.ractius.ustrplite.services.common.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.common.channel.IChannelInfo;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelInfolLoader extends BaseChannelLoader 
	{
		
		public function BaseChannelInfolLoader( updater:ChannelUpdater, url:String ) 
		{
			super( updater );
			
			load( url, _onLoad )
		}
		
		protected function createChannelInfo( data:String ):IChannelInfo
		{
			// override me
			return null;
		}
		
		private function _onLoad( ...e ):void 
		{
			updater.updateInfo( createChannelInfo( data ) );
		}
		
	}

}