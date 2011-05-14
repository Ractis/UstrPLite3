package jp.ractius.ustrplite.services.ustream.channel.loader 
{
	import flash.utils.escapeMultiByte;
	
	/**
	 * ...
	 * @author ractis
	 */
	internal class ApiUrlProvider
	{
		static private const API_KEY:String = "";
		
		static private const URL_PREFIX:String = "http://api.ustream.tv/xml/";
		static private const URL_SUFFIX:String = "key=" + API_KEY;
		
		public function ApiUrlProvider() 
		{
			
		}
		
		static private function _genUrl( val:String ):String
		{
			return URL_PREFIX + val + URL_SUFFIX;
		}
		
		static public function channelInfoUrl( channelName:String ):String
		{
			return _genUrl( "channel/" + escapeMultiByte( channelName ) + "/getInfo?" );
		}
		
	}

}