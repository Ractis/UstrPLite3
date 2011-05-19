package jp.ractius.ustrplite.services.livetube 
{
	import jp.ractius.ustrplite.player.Player;
	import jp.ractius.ustrplite.services.common.BaseService;
	import jp.ractius.ustrplite.services.common.channel.BaseChannelQuery;
	import jp.ractius.ustrplite.services.IChannelQuery;
	import jp.ractius.ustrplite.services.IChannelUri;
	import jp.ractius.ustrplite.services.IPlayerOption;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class LtbService extends BaseService 
	{
		static public const NAME:String = UstrpliteConstants.SERVICE_LTB;
		
		public function LtbService() 
		{
			
		}
		
		override protected function createChannelQuery():IChannelQuery	{ return new BaseChannelQuery(); }
		
		override public function createPlayerOption( player:Player ):IPlayerOption	{ return new PlayerOption( player ); }
		
		override public function createChannelUri():IChannelUri			{ return new ChannelUri(); }
		
	}

}