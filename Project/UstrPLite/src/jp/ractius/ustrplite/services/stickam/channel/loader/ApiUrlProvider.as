package jp.ractius.ustrplite.services.stickam.channel.loader 
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
		
		override protected function get urlHead():String { return "http://api.stickam.jp/api/user/"; }
		override protected function get urlFoot():String { return "/profile"; }
		
	}

}