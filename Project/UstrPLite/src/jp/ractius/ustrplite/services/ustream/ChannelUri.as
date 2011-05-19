package jp.ractius.ustrplite.services.ustream 
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
			super( UstService.NAME,
				   [ "ust", "ustream" ],
				   [ "ustream.tv/channel", "ustream.tv" ] );
		}
		
	}

}