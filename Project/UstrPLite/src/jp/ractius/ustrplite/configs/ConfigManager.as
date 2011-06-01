package jp.ractius.ustrplite.configs 
{
	import com.adobe.serialization.json.JSON;
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
		static private const CFG_VERSION:int = 1;
		
		static private const CFG_DIR:String = "app-storage:/configs/";	// β 版以降
		static private const CFG_EXT:String = ".json";
		
		static private var m_cfgs:Dictionary;
		
		public function ConfigManager() 
		{
			
		}
		
		static public function initialize():void
		{
			ConfigConverter.check( _loadCfgVersion() );
			_saveCfgVersion();
			
			m_cfgs = new Dictionary();	
			m_cfgs[ UstrpliteConstants.CONFIG_FAVORITES ]	= new FavoritesConfig();
			m_cfgs[ UstrpliteConstants.CONFIG_BROWSER ]		= new BrowserConfig();
			m_cfgs[ UstrpliteConstants.CONFIG_PLAYER ]		= new PlayerConfig();
		}
		
		static public function getConfig( cfgName:String ):BaseConfig
		{
			return m_cfgs[ cfgName ];
		}
		
		static private function _loadCfgVersion():int 
		{
			var file:File = _versionFile;
			if ( !file.exists )
			{
				return 0;
			}
			
			var fs:FileStream = new FileStream();
			fs.open( file, FileMode.READ );
			var version:int = int( fs.readUTFBytes( fs.bytesAvailable ) );
			fs.close();
			
			return version;
		}
		
		static private function _saveCfgVersion():void
		{
			var file:File = _versionFile;
			
			var fs:FileStream = new FileStream();
			fs.open( file, FileMode.WRITE );
			fs.writeUTFBytes( CFG_VERSION.toString() );
			fs.close();
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
			
			cfg.data = JSON.decode( data );
			cfg.onLoad();
		}
		
		static internal function save( cfg:BaseConfig ):void
		{
			saveImpl( cfg.cfgName, cfg.data );
		}
		
		static internal function saveImpl( name:String, data:Object ):void
		{
			var file:File = _createFile( name );
			
			var fs:FileStream = new FileStream();
			fs.open( file, FileMode.WRITE );
			fs.writeUTFBytes( JSON.encode( data ) );
			fs.close();
		}
		
		static private function _createFile( cfgName:String ):File
		{
			return new File( CFG_DIR + cfgName + CFG_EXT );
		}
		
		static private function get _versionFile():File
		{
			return new File( CFG_DIR + "version" );
		}
		
	}

}