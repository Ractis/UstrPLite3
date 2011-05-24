package jp.ractius.ustrplite.services.justintv.channel 
{
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.common.channel.BaseChannelQuery;
	import jp.ractius.ustrplite.services.justintv.channel.loader.ChannelInfoLoader;
	import jp.ractius.ustrplite.services.justintv.channel.loader.ChannelStatusLoader;
	
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
			push( new ChannelInfoLoader( channel ) );
			push( new ChannelStatusLoader( channel ) );
		}
		
	}

}