package jp.ractius.ustrplite.services.common 
{
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
		
		public function BasePlayerOption( player:Player ) 
		{
			m_player = player;
		}
		
		public function get isRemote():Boolean			{ return false; }
		public function onInitialized():void			{ /* override me */ }
		
		protected function get player():Player			{ return m_player; }
		protected function get channel():ChannelData	{ return m_player.channel; }
		
	}

}