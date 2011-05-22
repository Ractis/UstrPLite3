package jp.ractius.ustrplite.data.favorite 
{
	import flash.events.EventDispatcher;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	
	/**
	 * お気に入りから削除時に送出.
	 * @eventType jp.ractius.ustrplite.events.FavoriteEvent.REMOVE_FROM_FAVORITES
	 */
	[Event(name="removeFromFavorites", type="jp.ractius.ustrplite.events.FavoriteEvent")]
	
	/**
	 * ...
	 * @author ractis
	 */
	public class FavoriteData extends EventDispatcher 
	{
		private var m_uid:int;
		private var m_channel:ChannelData;
		
		public function FavoriteData( uid:int, channel:ChannelData ) 
		{
			m_uid		= uid;
			m_channel	= channel;
		}
		
		public function get channel():ChannelData { return m_channel; }
		
		public function get uid():int { return m_uid; }
		
	}

}