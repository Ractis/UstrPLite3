package jp.ractius.ustrplite.services 
{
	
	/**
	 * ...
	 * @author ractis
	 */
	public interface IChannelUri 
	{
		function test( uri:String ):Boolean;
		function get serviceName():String;
		function get channelName():String;
	}
	
}