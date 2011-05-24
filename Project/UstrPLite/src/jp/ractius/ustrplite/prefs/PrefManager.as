package jp.ractius.ustrplite.prefs 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import jp.ractius.ripple.utils.Algorithm;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.events.FavoriteEvent;
	/**
	 * ...
	 * @author ractis
	 */
	public class PrefManager 
	{
		static private const PREF_DIR:String = "app-storage:/prefs/";
		//static private const PREF_DIR:String = "app-storage:/configs/";	// β 版以降
		static private const PREF_EXT:String = ".xml";
		
		static private var m_favs:XML;
		
		public function PrefManager() 
		{
			
		}
		
		static public function initialize():void
		{
			m_favs = new XML( <favorites></favorites> );
			
			// 読み込み
			FavoriteStore.inst.addEventListener( FavoriteEvent.ADD_TO_FAVORITES, _registerRemFavListener );
			_load( "favorites", _onLoadXml );
			
			// Listeners
			FavoriteStore.inst.addEventListener( FavoriteEvent.ADD_TO_FAVORITES, _onAddFav );
		}
		
		static private function _registerRemFavListener( e:FavoriteEvent ):void
		{
			e.favorite.addEventListener( FavoriteEvent.REMOVE_FROM_FAVORITES, _onRemFav );
		}
		
		static private function _onAddFav( e:FavoriteEvent ):void 
		{
			var chData:ChannelData = e.favorite.channel;
			var sv:Object;
			
			Algorithm.forN( m_favs.service.length(), function( i:int ):void
			{
				if ( m_favs.service[i].name == chData.serviceName )
				{
					sv = m_favs.service[i];
				}
			} );
			
			if ( !sv )
			{
				sv = new XMLList( "<service><name>" + chData.serviceName + "</name></service>" );
				m_favs.appendChild( sv );
			}
			
			sv.appendChild( new XML( "<channel><name>" + chData.channelName + "</name></channel>" ) );
			
			_save( "favorites", m_favs );
		}
		
		static private function _onRemFav( e:FavoriteEvent ):void 
		{
			var chData:ChannelData = e.favorite.channel;
			
			var sv:XML = m_favs.service.( name == chData.serviceName )[0];
			
			delete sv.channel.( name == chData.channelName )[0];
			if ( sv.channel.length() == 0 ) delete sv.(true)[0];
			
			_save( "favorites", m_favs );
		}
		
		static private function _onLoadXml( xml:XML ):void 
		{
			m_favs = xml;
			
			Algorithm.forN( m_favs.service.length(), function( i:int ):void
			{
				var sv:Object = m_favs.service[i];
				
				Algorithm.forN( sv.channel.length(), function( i:int ):void
				{
					var ch:Object = sv.channel[i];
					
					FavoriteStore.inst.addFav( ChannelStore.inst.getChannel( sv.name, ch.name ) );
				} );
			} );
		}
		
		static private function _load( name:String, onLoad:Function ):void 
		{
			var file:File = new File( PREF_DIR + name + PREF_EXT );
			if ( !file.exists )
			{
				return;
			}
			
			var fs:FileStream = new FileStream();
			fs.open( file, FileMode.READ );
			var data:String = fs.readUTFBytes( fs.bytesAvailable );
			fs.close();
			
			var xml:XML = new XML( data );
			if ( xml.localName() != name ) return;
			
			onLoad( xml );
		}
		
		static private function _save( name:String, data:XML ):void
		{
			var file:File = new File( PREF_DIR + name + PREF_EXT );
			
			var fs:FileStream = new FileStream();
			fs.open( file, FileMode.WRITE );
			fs.writeUTFBytes( data.toXMLString() );
			fs.close();
		}
		
	}

}