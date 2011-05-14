package jp.ractius.ustrplite.services.common.channel.loader 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import jp.ractius.ustrplite.services.common.channel.ChannelUpdater;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelLoader 
	{
		private var m_updater:ChannelUpdater
		private var m_loader:URLLoader;
		
		public function BaseChannelLoader( updater:ChannelUpdater ) 
		{
			m_updater = updater;
		}
		
		protected function get updater():ChannelUpdater	{ return m_updater; }
		protected function get data():String			{ return String( m_loader.data ); }
		
		public function load( url:String, listener:Function ):void
		{
			m_loader = new URLLoader();
			m_loader.addEventListener( Event.COMPLETE, listener );
			m_loader.load( new URLRequest( url ) );
		}
		
	}

}