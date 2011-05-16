package jp.ractius.ustrplite.services.justintv 
{
	import jp.ractius.ustrplite.services.common.BaseChannelUri;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelUri extends BaseChannelUri 
	{
		
		public function ChannelUri() 
		{
			super( JtvService.NAME,
				   [ "jtv", "justintv", "justin.tv" ] );
		}
		
	}

}