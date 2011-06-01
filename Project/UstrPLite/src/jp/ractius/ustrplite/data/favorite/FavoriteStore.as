package jp.ractius.ustrplite.data.favorite 
{
	import com.adobe.serialization.json.JSON;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import jp.ractius.ripple.utils.UniqueIdGen;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.events.FavoriteEvent;
	
	/**
	 * お気に入りへ追加に送出.
	 * @eventType jp.ractius.ustrplite.events.FavoriteEvent.ADD_TO_FAVORITES
	 */
	[Event(name="addToFavorites", type="jp.ractius.ustrplite.events.FavoriteEvent")]
	
	/**
	 * ...
	 * @author ractis
	 */
	public class FavoriteStore extends EventDispatcher 
	{
		static private var s_inst:FavoriteStore;
		
		private var m_favs:Dictionary;
		
		public function FavoriteStore() 
		{
			m_favs = new Dictionary();
		}
		
		static public function get inst():FavoriteStore
		{
			if ( !s_inst )
			{
				s_inst = new FavoriteStore();
			}
			
			return s_inst;
		}
		
		public function serialize():String
		{
			var data:Object = new Object;
			data.channels = new Object();
			
			forEachFav( function( fav:FavoriteData ):void
			{
				data.channels[ fav.channel.uri ] = new Object();
			} );
			
			return JSON.encode( data );
		}
		
		public function deserialize( value:String ):void
		{
			var data:Object = JSON.decode( value );
			
			for ( var uri:String in data.channels )
			{
				addFav( ChannelStore.inst.getChannelByUri( uri ) );
			}
		}
		
		public function forEachFav( func:Function ):void
		{
			for each ( var fav:FavoriteData in m_favs )
			{
				func( fav );
			}
		}
		
		public function addFav( channel:ChannelData ):void
		{
			if ( !channel ) return;
			
			if ( channel.isFavorite ) return;	// お気に入り済み
			
			var uid:int = UniqueIdGen.uid();
			var fav:FavoriteData = new FavoriteData( uid, channel );
			
			channel.isFavorite = true;
			
			m_favs[ uid ] = fav;
			
			dispatchEvent( new FavoriteEvent( FavoriteEvent.ADD_TO_FAVORITES, fav ) );
		}
		
		public function removeFav( favorite:FavoriteData ):void
		{
			favorite.dispatchEvent( new FavoriteEvent( FavoriteEvent.REMOVE_FROM_FAVORITES, favorite ) );
			
			m_favs[ favorite.uid ] = null;
			
			favorite.channel.isFavorite = false;
		}
		
	}

}