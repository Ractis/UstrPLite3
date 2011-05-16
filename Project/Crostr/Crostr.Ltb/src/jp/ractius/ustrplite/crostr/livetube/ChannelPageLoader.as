package jp.ractius.ustrplite.crostr.livetube 
{
	import com.adobe.net.URI;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.escapeMultiByte;
	import org.httpclient.events.HttpDataEvent;
	import org.httpclient.HttpClient;
	import org.httpclient.HttpRequest;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelPageLoader extends EventDispatcher 
	{	
		private var m_httpClient:HttpClient;
		private var m_prevData:String;
		
		private var m_streamUrl:String;
		
		public function ChannelPageLoader() 
		{
			m_httpClient = new HttpClient();
			
			m_httpClient.listener.onData = _onData;
		}
		
		private function _onData( e:HttpDataEvent ):void 
		{
			var currentData:String = e.readUTFBytes();
			
			var data:String = m_prevData + currentData;
		//	trace( data.search( "current_route" ) );
			var regex:RegExp = /current_route = '(.+)';/m;
			var result:Array = regex.exec( data );
			
			if ( !result )
			{
				// 見つからなかった
				m_prevData = currentData;
				return;
			}
			
			m_httpClient.close();
			m_streamUrl = result[1];
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function load( channelId:String ):void
		{
			m_prevData = "";
			
		//	trace( channelId );
			
		//	Log.level = Log.DEBUG;
			
			// uri.path から HTTP リクエスト生成中、'%' がエスケープされないようにする
			var escapeBitmap:ByteArray = HttpRequest.kUriPathEscapeBitmap;
			escapeBitmap.clear();
			for ( var i:int = 0; i < 16; i++ ) escapeBitmap.writeByte( 0 );
			
			// URI 生成
			var uri:URI = new URI( "http://livetube.cc/" );
			
			// URL エンコード
			var path:String = escapeMultiByte( channelId );
			
			// エンコードされたくない文字を復元
			var restore:Function = function( char:String ):void
			{
				var charEncoded:String = escapeMultiByte( char );
				path = path.split( charEncoded ).join( char );
			}
			restore( "/" );
			restore( "+" );
			
			uri.path = "/" + path;
			
		//	trace( uri, uri.path );
		//	trace( uri, URI.fastEscapeChars( uri.path, HttpRequest.kUriPathEscapeBitmap ) );
			
			m_httpClient.get( uri );
		}
		
		public function get streamUrl():String { return m_streamUrl; }
		
	}

}