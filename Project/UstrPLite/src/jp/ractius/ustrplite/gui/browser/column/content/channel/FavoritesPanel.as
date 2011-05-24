package jp.ractius.ustrplite.gui.browser.column.content.channel 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jp.ractius.ustrplite.browser.channel.FavoriteChannelMenu;
	import jp.ractius.ustrplite.data.favorite.FavoriteData;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.data.playing.PlayingStore;
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
			
			FavoriteStore.inst.forEachFav( function( fav:FavoriteData ):void
			{
				_appendFav( fav );
			} );
			doLayout();
			
			FavoriteStore.inst.addEventListener( FavoriteEvent.ADD_TO_FAVORITES, _onAddFav );
		}
		
		private function _appendFav( fav:FavoriteData ):void
		{
			var panel:ChannelBlockPanel = new ChannelBlockPanel( fav.channel );
			panel.setPreferredWidth( blockW );
			
			panel.addEventListener( MouseEvent.CLICK, function( e:Event ):void
			{
				PlayingStore.inst.play( e.target.channel );
			} );
			
			panel.contextMenu = new FavoriteChannelMenu( fav );
			
			gridPanel.append( panel );
			
			fav.addEventListener( FavoriteEvent.REMOVE_FROM_FAVORITES, panel.removeFromParent );
		}
		
		private function _onAddFav( e:FavoriteEvent ):void 
		{
			_appendFav( e.favorite );
		}
		
	}

}