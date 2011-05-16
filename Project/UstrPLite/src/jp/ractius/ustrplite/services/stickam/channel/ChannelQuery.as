package jp.ractius.ustrplite.services.stickam.channel 
{
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.common.channel.BaseChannelQuery;
	import jp.ractius.ustrplite.services.stickam.channel.loader.ChannelInfoLoader;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelQuery extends BaseChannelQuery 
	{
		
		public function ChannelQuery() 
		{
			
		}
		
		override public function updateInfo( channel:ChannelUpdater ):void 
		{
			new ChannelInfoLoader( channel );
		}
		
	}

}