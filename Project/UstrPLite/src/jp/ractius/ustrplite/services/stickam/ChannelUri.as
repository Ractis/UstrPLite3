package jp.ractius.ustrplite.services.stickam 
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
			super( StcService.NAME,
				   [ "stc", "stickam" ],
				   [ "stickam.jp/profile" ] );
		}
		
	}

}