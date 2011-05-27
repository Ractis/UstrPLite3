package jp.ractius.ustrplite.gui.browser.column.content.channel 
{
	import jp.ractius.ustrplite.browser.channel.FavoriteChannelMenu;
	import jp.ractius.ustrplite.data.favorite.FavoriteData;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.events.FavoriteEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class FavoritesPanel extends ChannelsPanel 
	{
		
		public function FavoritesPanel() 
		{
			super();
			setName( "FavoritesPanel" );
			
		//	GuiUtil.drawDebugBorder( this, 0xFF0000 );
			
			FavoriteStore.inst.forEachFav( function( fav:FavoriteData ):void
			{
				_appendFav( fav );
			} );
			
			FavoriteStore.inst.addEventListener( FavoriteEvent.ADD_TO_FAVORITES, _onAddFav );
		}
		
		private function _appendFav( fav:FavoriteData ):void
		{
			var panel:ChannelBlockPanel = appendBlock( fav.channel, new FavoriteChannelMenu( fav ) );
			
			fav.addEventListener( FavoriteEvent.REMOVE_FROM_FAVORITES, panel.removeFromParent );
		}
		
		private function _onAddFav( e:FavoriteEvent ):void 
		{
			_appendFav( e.favorite );
		}
		
	}

}