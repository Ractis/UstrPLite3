package jp.ractius.ustrplite.services 
{
	
	/**
	 * サービス特有の機能を提供するインターフェイス.
	 * @author ractis
	 */
	public interface IService 
	{
		function createPlayerOption():IPlayerOption;
		
		function get channelQuery():IChannelQuery;
		
		/**
		 * チャンネル ID と Name が同じ？.
		 */
		function get isChannelIdAsName():Boolean;
	}
	
}