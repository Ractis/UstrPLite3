package jp.ractius.ustrplite.services.common.channel 
{
	
	/**
	 * ...
	 * @author ractis
	 */
	public interface IChannelInfo extends IChannelStatus 
	{
		function get channelId():String;
		function get userName():String;
		function get title():String;
		function get description():String;
		function get hashTag():String;
		function get imageUrl():String;
	}
	
}