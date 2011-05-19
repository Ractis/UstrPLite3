package jp.ractius.ustrplite.services.justintv.channel.loader 
{
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	import jp.ractius.ustrplite.services.common.channel.loader.BaseChannelLoader;
	import jp.ractius.ustrplite.services.justintv.channel.parser.ChannelStatusParser;
	import jp.ractius.ustrplite.services.justintv.ChannelExDataName;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelStatusLoader extends BaseChannelLoader
	{
		
		public function ChannelStatusLoader( channel:ChannelUpdater ) 
		{
			super( channel );
			
			load( new ApiUrlProvider().channelStatusUrl( channelName ), _onLoad );
		}
		
		private function _onLoad( ...e ):void 
		{
			var parser:ChannelStatusParser = new ChannelStatusParser( channelName, data );
			channel.updateStatus( parser );
			channel.tgt.setExData( ChannelExDataName.VIDEO_SIZE, parser.videoSize );
		}
		
	}

}