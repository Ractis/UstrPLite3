package jp.ractius.ustrplite.services.ustream 
{
	import jp.ractius.ustrplite.player.Player;
	import jp.ractius.ustrplite.services.common.BasePlayerOption;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerOption extends BasePlayerOption 
	{
		
		public function PlayerOption( player:Player ) 
		{
			super( player );
		}
		
		override public function get popupPlayerUrl():String
		{
			return "http://ustream.tv/channel-popup/" + channel.channelName;
		}
		
	}

}