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
	public class ConfigManager 
	{
		static private const CFG_DIR:String = "app-storage:/prefs/";
		//static private const CFG_DIR:String = "app-storage:/configs/";	// β 版以降
		static private const CFG_EXT:String = ".xml";
		
		static private var m_cfgs:Dictionary;
		
		public function ConfigManager() 
		{
			
		}
		
		static public function initialize():void
		{
			m_cfgs = new Dictionary();
			
			m_cfgs[ UstrpliteConstants.CONFIG_FAVORITES ]	= new FavoritesConfig();
		}
		
		static internal function load( cfg:BaseConfig ):void 
		{
			var file:File = _createFile( cfg.cfgName );
			if ( !file.exists )
			{
				return;
			}
			
			var fs:FileStream = new FileStream();
			fs.open( file, FileMode.READ );
			var data:String = fs.readUTFBytes( fs.bytesAvailable );
			fs.close();
			
			var xml:XML = new XML( data );
			if ( xml.localName() != cfg.cfgName )
			{
				return;
			}
			
			// valid
			cfg.xml = xml;
			cfg.onLoad();
		}
		
		static internal function save( cfg:BaseConfig ):void
		{
			var file:File = _createFile( cfg.cfgName );
			
			var fs:FileStream = new FileStream();
			fs.open( file, FileMode.WRITE );
			fs.writeUTFBytes( cfg.xml.toXMLString() );
			fs.close();
		}
		
		static private function _createFile( cfgName:String ):File
		{
			return new File( CFG_DIR + cfgName + CFG_EXT );
		}
		
	}

}