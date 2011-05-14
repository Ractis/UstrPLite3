package jp.ractius.ustrplite
{
	import flash.display.Sprite;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.events.ChannelEvent;
	import jp.ractius.ustrplite.player.PlayerWindow;
	import jp.ractius.ustrplite.services.Services;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			Services.initialize();
			
			var channel:ChannelData = ChannelStore.inst.getChannel( "Ust", "spacevidcast" );
			new PlayerWindow( channel );
		}
		
	}
	
}