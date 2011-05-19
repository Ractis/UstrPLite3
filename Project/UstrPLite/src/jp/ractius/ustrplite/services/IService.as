package jp.ractius.ustrplite.services 
{
	import jp.ractius.ustrplite.player.Player;
	
	/**
	 * サービス特有の機能を提供するインターフェイス.
	 * @author ractis
	 */
	public interface IService 
	{
		function createPlayerOption( player:Player ):IPlayerOption;
		function createChannelUri():IChannelUri;
		
		function get channelQuery():IChannelQuery;
		
		/**
		 * チャンネル ID と Name が同じ？.
		 */
		function get isChannelIdAsName():Boolean;
	}
	
}