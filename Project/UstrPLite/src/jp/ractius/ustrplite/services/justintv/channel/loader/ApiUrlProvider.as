package jp.ractius.ustrplite.services.justintv.channel.loader 
{
	import jp.ractius.ustrplite.services.common.channel.loader.BaseApiUrlProvider;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ApiUrlProvider extends BaseApiUrlProvider 
	{
		
		public function ApiUrlProvider() 
		{
			
		}
		
		override protected function get urlHead():String { return "http://api.justin.tv/api/"; }
		override protected function get urlFoot():String { return ".xml"; }
		
		override public function channelInfoUrl( channelName:String ):String
		{
			return genUrl( "channel/show/" + channelName );
		}
		
		public function channelStatusUrl( channelName:String ):String
		{
			return genUrl( "stream/search/" + channelName );
		}
		
	}

}