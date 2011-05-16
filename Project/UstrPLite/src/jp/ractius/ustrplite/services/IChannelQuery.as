package jp.ractius.ustrplite.services 
{
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	
	/**
	 * ...
	 * @author ractis
	 */
	public interface IChannelQuery 
	{
		function updateInfo( channel:ChannelUpdater ):void;
	}
	
}