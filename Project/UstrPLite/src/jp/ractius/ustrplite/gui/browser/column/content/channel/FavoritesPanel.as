package jp.ractius.ustrplite.gui.browser.column.content.channel 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jp.ractius.ustrplite.data.favorite.FavoriteData;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.events.FavoriteEvent;
	import jp.ractius.ustrplite.gui.browser.column.content.channel.thumbnail.ThumbnailPanel;
	import jp.ractius.ustrplite.player.PlayerWindow;
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
			
			FavoriteStore.inst.forEachFav( function( fav:FavoriteData ):void
			{
				_appendFav( fav );
			} );
			doLayout();
			
			FavoriteStore.inst.addEventListener( FavoriteEvent.ADD_TO_FAVORITES, _onAddFav );
		}
		
		private function _appendFav( fav:FavoriteData ):void
		{
			var panel:ThumbnailPanel = new ThumbnailPanel( fav.channel );
			panel.setPreferredWidth( blockW );
			
			panel.addEventListener( MouseEvent.CLICK, function( e:Event ):void
			{
				new PlayerWindow( e.target.channel );
			} );
			
			gridPanel.append( panel );
		}
		
		private function _onAddFav( e:FavoriteEvent ):void 
		{
			_appendFav( e.favorite );
		}
		
	}

}