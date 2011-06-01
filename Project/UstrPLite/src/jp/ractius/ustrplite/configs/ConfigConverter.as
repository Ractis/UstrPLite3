package jp.ractius.ustrplite.configs 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	internal class ConfigConverter 
	{
		static private var cfgs:Dictionary;
		
		public function ConfigConverter() 
		{
			
		}
		
		static public function check( cfgVersion:int ):void
		{
			cfgs = new Dictionary();
			
			switch ( cfgVersion )
			{
			case 0:	_convertVer0();	break;
			}
			
			for ( var name:String in cfgs )
			{
				ConfigManager.saveImpl( name, cfgs[ name ] );
			}
			
			cfgs = null;
		}
		
		static private function _convertVer0():void 
		{
			// Favorites
			var file:File = new File( "app-storage:/prefs/favorites.xml" );
			var fs:FileStream = new FileStream();
			var xml:XML;
			
			if ( file.exists )
			{
				fs.open( file, FileMode.READ );
				xml = new XML( fs.readUTFBytes( fs.bytesAvailable ) );
				fs.close();
				
				file.deleteFile();
				
				var favs:Object = new Object;
				var channels:Object = favs.channels = new Object();
			
				for each ( var sv:Object in xml.service )
				{
					for each ( var ch:Object in sv.channel )
					{
						channels[ sv.name + "/" + ch.name ] = new Object();
					}
				}
				
				cfgs[ UstrpliteConstants.CONFIG_FAVORITES ] = favs;
			}
			
			file = new File( "app-storage:/prefs/" );
			file.deleteDirectory( true );
		}
		
	}

}