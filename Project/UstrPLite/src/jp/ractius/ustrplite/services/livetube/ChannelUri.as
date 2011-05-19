package jp.ractius.ustrplite.services.livetube 
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
			super( LtbService.NAME,
				   [ "ltb", "livetube" ],
				   [ "livetube.cc" ] );
		}
		
		override protected function get isEraseSlash():Boolean { return false; }
		
	}

}