package jp.ractius.ustrplite.player 
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.events.ChannelEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerWindow extends NativeWindow 
	{
		private var m_channel:ChannelData;
		
		public function PlayerWindow( channel:ChannelData ) 
		{
			m_channel = channel;
			
			var opt:NativeWindowInitOptions = new NativeWindowInitOptions();
			opt.systemChrome	= "none";
			opt.transparent		= true;
			opt.maximizable		= false;
			opt.minimizable		= true;
			opt.resizable		= true;
			
			super( opt );
			
			alwaysInFront = true;
			
			//TODO
			width = 400;
			height = 300;
			
			stage.addChild( new Player( channel ) );
			
			m_channel.addEventListener( ChannelEvent.CHANGE_TITLE, _updateTitle );
			_updateTitle();
			
			activate();
		}
		
		private function _updateTitle( ...e ):void
		{
			if ( m_channel.title )	_setTitle( m_channel.title );
			else					_setTitle( uri );
		}
		
		private function _setTitle( channelTitle:String ):void
		{
			title = channelTitle + " - UstrPLite";
		}
		
		public function get uri():String { return m_channel.uri; }
		
	}

}