package jp.ractius.ustrplite.events 
{
	import flash.events.Event;
	import jp.ractius.ustrplite.data.favorite.FavoriteData;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class FavoriteEvent extends Event 
	{
		static public const ADD_TO_FAVORITES:String			= "addToFavorites";
		static public const REMOVE_FROM_FAVORITES:String	= "removeFromFavorites";
		
		private var m_favorite:FavoriteData;
		
		public function FavoriteEvent( type:String, favorite:FavoriteData ) 
		{
			super( type );
			
			m_favorite = favorite;
		}
		
		public function get favorite():FavoriteData { return m_favorite; }
		
	}

}