package jp.ractius.ustrplite.services.ustream.channel.loader 
{
	import flash.utils.escapeMultiByte;
	import jp.ractius.ustrplite.services.common.channel.loader.BaseApiUrlProvider;
	
	/**
	 * ...
	 * @author ractis
	 */
	internal class ApiUrlProvider extends BaseApiUrlProvider 
	{
		static private const API_KEY:String = "";
		
		public function ApiUrlProvider() 
		{
			
		}
		
		override protected function get urlHead():String { return "http://api.ustream.tv/xml/"; }
		override protected function get urlFoot():String { return "key=" + API_KEY; }
		
		override public function channelInfoUrl( channelName:String ):String 
		{
			return genUrl( "channel/" + escapeMultiByte( channelName ) + "/getInfo?" );
		}
		
	}

}