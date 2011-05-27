package jp.ractius.ustrplite.services.common 
{
	import flash.html.HTMLLoader;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.player.Player;
	import jp.ractius.ustrplite.services.IPlayerOption;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BasePlayerOption implements IPlayerOption 
	{
		private var m_player:Player;
		private var m_channel:ChannelData;
		
		public function BasePlayerOption( player:Player ) 
		{
			m_player	= player;
			m_channel	= m_player.channel;
		}
		
		public function get isRemote():Boolean			{ return false; }
		public function get popupPlayerUrl():String		{ return null; }
		public function onInitialized():void			{ /* override me */ }
		public function onBeginLoadPopupPlayer( loader:HTMLLoader ):void	{ /* override me */ }
		
		protected function get player():Player			{ return m_player; }
		protected function get channel():ChannelData	{ return m_channel; }
		
	}

}