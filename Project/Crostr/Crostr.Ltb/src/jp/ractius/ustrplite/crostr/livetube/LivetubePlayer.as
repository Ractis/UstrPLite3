package jp.ractius.ustrplite.crostr.livetube 
{
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class LivetubePlayer extends Video 
	{
		static private const PROTOCOL_HTTP:String = "http";
		static private const PROTOCOL_RTMP:String = "rtmp";
		
		private var m_protocol:String;
		private var m_connectionName:String;
		private var m_streamName:String;
		
		private var m_netConnection:NetConnection;
		private var m_netStream:NetStream;
		
		public function LivetubePlayer( streamUrl:String ) 
		{
			super( 480, 360 );
			smoothing = true;
			
			if ( streamUrl.search( "rtmp://" ) >= 0 )
			{
				m_protocol = PROTOCOL_RTMP;
				
				var ary:Array = streamUrl.split( "/" );	// [0]rtmp: / [1] / [2]address:port / [3]stream / [4]XXXXX
				
				m_connectionName	= ary[0] + "//" + ary[2] + "/" + ary[3];
				m_streamName		= ary[4];
			}
			else
			{
				m_protocol = PROTOCOL_HTTP;
				
				// 末尾の .f4m を消す
				if ( /.f4m/.test( streamUrl ) )
				{
					streamUrl = streamUrl.substr( 0, streamUrl.length - 4 );
				}
				
				m_connectionName	= null;
				m_streamName		= streamUrl + ".flv";
			}
			
			m_netConnection = new NetConnection();
			m_netConnection.objectEncoding = 0;
			m_netConnection.addEventListener( NetStatusEvent.NET_STATUS, _onStatus );
			
			var client:Object = new Object();
			client.onBWDone = function():void { }
			m_netConnection.client = client;
			
			m_netConnection.connect( m_connectionName );
		}
		
		private function _onStatus( e:NetStatusEvent ):void 
		{
			switch ( e.info.code )
			{
			case "NetConnection.Connect.Success":
				m_netStream = new NetStream( m_netConnection );
				m_netStream.client = new Object();
				
				attachNetStream( m_netStream );
				
				m_netStream.play( m_streamName );
				break;
			}
		}
		
	}

}