package jp.ractius.ustrplite.services.common.channel 
{
	
	/**
	 * ...
	 * @author ractis
	 */
	public interface IChannelStatus 
	{
		function get isAvailable():Boolean;
		function get status():String;
	}
	
}