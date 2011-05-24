package jp.ractius.ustrplite.services.common.channel.loader 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	
	/**
	 * 読み込みが完了した、または再試行回数の上限に達した.
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelLoader extends EventDispatcher 
	{
		private var m_reloadRemain:uint = 5;
		
		private var m_channel:ChannelUpdater;
		private var m_url:String;
		
		private var m_loader:URLLoader;
		
		public function BaseChannelLoader( channel:ChannelUpdater, url:String ) 
		{
			m_channel	= channel;
			m_url		= url;
			
			m_loader = new URLLoader();
			m_loader.addEventListener( Event.COMPLETE, onLoad,			false, 1 );
			m_loader.addEventListener( Event.COMPLETE, _fireComplete,	false, 0 );
			m_loader.addEventListener( IOErrorEvent.IO_ERROR, _onIdError );
		}
		
		private function _fireComplete( ...e ):void 
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private function _onIdError( e:IOErrorEvent ):void 
		{
			if ( m_reloadRemain-- >= 0 )	load();
			else							_fireComplete();
		}
		
		protected function get channel():ChannelUpdater	{ return m_channel; }
		protected function get channelName():String		{ return m_channel.channelName; }
		protected function get data():String			{ return String( m_loader.data ); }
		
		protected function onLoad( e:Event ):void
		{
			// override me
		}
		
		public function load():void
		{
			m_loader.load( new URLRequest( m_url ) );
		}
		
	}

}