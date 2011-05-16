package jp.ractius.ustrplite.services.ustream 
{
	import jp.ractius.ustrplite.services.common.BaseService;
	import jp.ractius.ustrplite.services.IChannelQuery;
	import jp.ractius.ustrplite.services.IChannelUri;
	import jp.ractius.ustrplite.services.IPlayerOption;
	import jp.ractius.ustrplite.services.ustream.channel.ChannelQuery;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class UstService extends BaseService 
	{
		static public const NAME:String = UstrpliteConstants.SERVICE_UST;
		
		public function UstService() 
		{
			
		}
		
		override protected function createChannelQuery():IChannelQuery	{ return new ChannelQuery(); }
		
		override public function createPlayerOption():IPlayerOption		{ return new PlayerOption(); }
		
		override public function createChannelUri():IChannelUri			{ return new ChannelUri(); }
		
		override public function get isChannelIdAsName():Boolean		{ return false; }
		
	}

}