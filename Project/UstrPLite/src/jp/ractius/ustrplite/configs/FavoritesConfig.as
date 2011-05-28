package jp.ractius.ustrplite.configs 
{
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
			
			var sv:Object = xml.service.( name == chData.serviceName );
			
			if ( sv.length() == 0 )
			{
				sv = new XMLList( "<service><name>" + chData.serviceName + "</name></service>" );
				xml.appendChild( sv );
			}
			
			sv.appendChild( new XML( "<channel><name>" + chData.channelName + "</name></channel>" ) );
			
			save();
		}
		
		private function _onRemFav( e:FavoriteEvent ):void
		{
			var chData:ChannelData = e.favorite.channel;
			
			var sv:XML = xml.service.( name == chData.serviceName )[0];
			
			delete sv.channel.( name == chData.channelName )[0];
			if ( sv.channel.length() == 0 ) delete sv.(true)[0];
			
			save();
		}
		
		override internal function onLoad():void 
		{
			for each ( var sv:Object in xml.service )
			{
				for each ( var ch:Object in sv.channel )
				{
					FavoriteStore.inst.addFav( ChannelStore.inst.getChannel( sv.name, ch.name ) );
				}
			}
		}
		
		private function _registerRemFavListener( e:FavoriteEvent ):void
		{
			e.favorite.addEventListener( FavoriteEvent.REMOVE_FROM_FAVORITES, _onRemFav );
		}
		
	}

}