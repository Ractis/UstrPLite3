package jp.ractius.ustrplite.configs 
{
	import jp.ractius.ustrplite.browser.Browser;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.events.FavoriteEvent;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class FavoritesConfig extends BaseConfig 
	{
		
		public function FavoritesConfig() 
		{
			FavoriteStore.inst.addEventListener( FavoriteEvent.ADD_TO_FAVORITES, _registerRemFavListener );
			
			super( UstrpliteConstants.CONFIG_FAVORITES );
			
			FavoriteStore.inst.addEventListener( FavoriteEvent.ADD_TO_FAVORITES, _onAddFav );
		}
		
		private function _onAddFav( e:FavoriteEvent ):void 
		{
			var chData:ChannelData = e.favorite.channel;
			
			_channels[ chData.uri ] = new Object();
			
			save();
		}
		
		private function _onRemFav( e:FavoriteEvent ):void
		{
			var chData:ChannelData = e.favorite.channel;
			
			_channels[ chData.uri ] = null;
			
			save();
		}
		
		override internal function onLoad():void 
		{
			for ( var chUri:String in _channels )
			{
				FavoriteStore.inst.addFav( ChannelStore.inst.getChannelByUri( chUri ) );
			}
		}
		
		private function get _channels():Object
		{
			if ( !data.channels )
			{
				data.channels = new Object();
			}
			
			return data.channels;
		}
		
		private function _registerRemFavListener( e:FavoriteEvent ):void
		{
			e.favorite.addEventListener( FavoriteEvent.REMOVE_FROM_FAVORITES, _onRemFav );
		}
		
	}

}