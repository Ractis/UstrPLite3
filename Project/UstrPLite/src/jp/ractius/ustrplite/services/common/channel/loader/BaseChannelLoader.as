package jp.ractius.ustrplite.services.common.channel.loader 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import jp.ractius.ustrplite.data.channel.ChannelUpdater;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelLoader 
	{
		private var m_channel:ChannelUpdater;
		private var m_loader:URLLoader;
		
		public function BaseChannelLoader( channel:ChannelUpdater ) 
		{
			m_channel = channel;
		}
		
		protected function get channel():ChannelUpdater	{ return m_channel; }
		protected function get channelName():String		{ return m_channel.channelName; }
		protected function get data():String			{ return String( m_loader.data ); }
		
		public function load( url:String, listener:Function ):void
		{
			m_loader = new URLLoader();
			m_loader.addEventListener( Event.COMPLETE, listener );
			m_loader.load( new URLRequest( url ) );
		}
		
	}

}