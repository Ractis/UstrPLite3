package jp.ractius.ripple.utils 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.Capabilities;
	import mx.utils.RPCStringUtil;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Localization 
	{
		static public const DEFAULT_DIRECTORY:String	= "app:/localization";
		static private const EXTENSION:String			= ".xml";
		
		static private var s_data:XML;
		
		public function Localization() 
		{
			
		}
		
		static public function initialize( language:String = null, directory:String = DEFAULT_DIRECTORY ):void
		{
			if ( language == null ) language = _defaultLanguage;
			
			// FileStream を利用しての読み込み
			var fs:FileStream = new FileStream();
			fs.open( new File( directory + "/" + language + EXTENSION ), FileMode.READ );
			
			s_data = new XML( fs.readUTFBytes( fs.bytesAvailable ) );
		}
		
		static public function substitude( name:String, ...args ):String
		{
			return RPCStringUtil.substitute( String( getData( name ) ), args ); 
		}
		
		static public function getData( name:String ):Object
		{
			var data:Object = _getDataImpl( s_data, name.split( "." ) );
			
			var dataString:String = String( data );
			if ( dataString.indexOf( "#" ) == 0 )	return getData( dataString.substr( 1 ) );	// エイリアスを探す
			else									return data;
		}
		
		static private function _getDataImpl( currentNode:Object, path:Array ):Object
		{
			var nextNode:Object = currentNode[ path.shift() ];
			
			if ( path.length == 0 )	return nextNode;
			else					return _getDataImpl( nextNode, path );
		}
		
		static private function get _defaultLanguage():String 
		{
			switch ( Capabilities.language )
			{
			case "ja":	return "japanese";
			default:	return "english";
			}
		}
		
	}

}