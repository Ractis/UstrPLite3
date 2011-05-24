package jp.ractius.ustrplite.browser.channel 
{
	import jp.ractius.ripple.air.RNativeMenu;
	import jp.ractius.ustrplite.data.favorite.FavoriteData;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.data.playing.PlayingStore;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class FavoriteChannelMenu extends RNativeMenu 
	{
		private var m_fav:FavoriteData;
		
		public function FavoriteChannelMenu( fav:FavoriteData ) 
		{
			super();
			
			m_fav = fav;
			
			appendItem( "general.play",				onPlay );
			appendSeparator();
			appendItem( "browser.channel.remFav",	onRemove );
		}
		
		public function onPlay( ...e ):void 
		{
			PlayingStore.inst.play( m_fav.channel );
		}
		
		public function onRemove( ...e ):void
		{
			FavoriteStore.inst.removeFav( m_fav );
		}
		
	}

}