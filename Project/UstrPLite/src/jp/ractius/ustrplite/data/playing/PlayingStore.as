package jp.ractius.ustrplite.data.playing 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.player.PlayerWindow;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayingStore extends EventDispatcher 
	{
		static private var s_inst:PlayingStore;
		
		private var m_players:Dictionary;
		
		public function PlayingStore() 
		{
			m_players = new Dictionary();
		}
		
		static public function get inst():PlayingStore
		{
			if ( !s_inst )
			{
				s_inst = new PlayingStore();
			}
			
			return s_inst;
		}
		
		/**
		 * 
		 * @param	channel
		 * @return	新規にプレイヤーを作成したか？
		 */
		public function play( channel:ChannelData ):Boolean
		{
			if ( !channel ) return false;
			
			var uri:String = channel.uri;
			
			var playerWin:PlayerWindow = m_players[ uri ];
			if ( playerWin )
			{
				playerWin.activate();
				return false;
			}
			
			playerWin = new PlayerWindow( channel );
			m_players[ uri ] = playerWin;
			
			playerWin.addEventListener( Event.CLOSE, _onClosePlayer );
			
			return true;
		}
		
		private function _onClosePlayer( e:Event ):void 
		{
			m_players[ PlayerWindow( e.target ).uri ] = null;
		}
		
	}

}