package jp.ractius.ustrplite.services.common.channel.loader 
{
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseApiUrlProvider implements IApiUrlProvider 
	{
		
		public function BaseApiUrlProvider() 
		{
			
		}
		
		protected function get urlHead():String	{ return ""; }
		protected function get urlFoot():String	{ return ""; }
		
		protected function genUrl( urlBody:String ):String
		{
			return urlHead + urlBody + urlFoot;
		}
		
		/* INTERFACE jp.ractius.ustrplite.services.common.channel.loader.IApiUrlProvider */
		
		public function channelInfoUrl( channelName:String ):String { return genUrl( channelName ); }
		
	}

}