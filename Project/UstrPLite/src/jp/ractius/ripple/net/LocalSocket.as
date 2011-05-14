package jp.ractius.ripple.net 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 * 双方向通信が出来る LocalConnection ラッパー.
	 * @author ractis
	 */
	public class LocalSocket 
	{
		private var m_recver:LocalConnection;
		private var m_sender:LocalConnection;
		private var m_sendName:String;
		
		public function LocalSocket( client:Object, tgtDomain:String, name:String, isServer:Boolean ) 
		{
			m_recver = new LocalConnection();
			m_recver.allowDomain( tgtDomain );
			m_recver.client = client;
			m_recver.connect( _createConnectionName( name, isServer ) );
			
			m_sender = new LocalConnection();
			m_sendName = _createConnectionName( name, !isServer );
		}
		
		private function _createConnectionName( name:String, isServer:Boolean ):String 
		{
			return "_" + name + "_" + ( isServer ? "S" : "C" );
		}
		
		/**
		 * データを送信.
		 * 複数の引数を載せると正しく動作しないため、一つのみに制限しています。
		 */
		public function send( methodName:String, data:String = null ):void
		{
			m_sender.send( m_sendName, methodName, data );
		}
		
	}

}