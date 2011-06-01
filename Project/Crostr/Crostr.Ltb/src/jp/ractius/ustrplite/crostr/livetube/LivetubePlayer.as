package jp.ractius.ustrplite.crostr.livetube 
{
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import jp.ractius.ustrplite.crostr.livetube.events.VideoSizeEvent;
	
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
		
		private var m_aspectRatio:Number = 4 / 3;
		private var m_screenW:Number = 480;
		private var m_screenH:Number = 360;
		
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
		
		public function refresh():void
		{
			if ( !m_netStream ) return;
			
			m_netStream.close();
			m_netStream.play( m_streamName );
		}
		
		private function _onStatus( e:NetStatusEvent ):void 
		{
			switch ( e.info.code )
			{
			case "NetConnection.Connect.Success":
				m_netStream = new NetStream( m_netConnection );
				
				var client:Object = new Object();
				client.onMetaData = _onMetaDataNS;
				m_netStream.client = client;
				
				attachNetStream( m_netStream );
				
				m_netStream.play( m_streamName );
				break;
			}
		}
		
		private function _onMetaDataNS( data:Object ):void 
		{
			var w:Number = data.width;
			var h:Number = data.height;
			
			m_aspectRatio = w / h;
			_centering();
			
			dispatchEvent( new VideoSizeEvent( w, h ) );
		}
		
		override public function set width( w:Number ):void
		{
			m_screenW = w;
			
			_centering();
		}
		
		override public function set height( h:Number ):void
		{
			m_screenH = h;
			
			_centering();
		}
		
		private function _centering():void
		{
			var currentAR:Number = m_screenW / m_screenH;
			
			if		( currentAR < m_aspectRatio )	// 上下に黒枠
			{
				super.width		= m_screenW;
				super.height	= width / m_aspectRatio;
			}
			else if	( currentAR > m_aspectRatio )	// 左右に黒枠
			{
				super.height	= m_screenH;
				super.width		= height * m_aspectRatio;
			}
			else
			{
				super.width		= m_screenW;
				super.height	= m_screenH;
			}
			
			x = ( m_screenW - width  ) / 2;
			y = ( m_screenH - height ) / 2;
		}
		
	}

}