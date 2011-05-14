package jp.ractius.ustrplite.player 
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerWindow extends NativeWindow 
	{
		
		public function PlayerWindow( channel:ChannelData ) 
		{
			var opt:NativeWindowInitOptions = new NativeWindowInitOptions();
			opt.systemChrome	= "none";
			opt.transparent		= true;
			opt.maximizable		= false;
			opt.minimizable		= true;
			opt.resizable		= true;
			
			super( opt );
			
			//TODO
			width = 400;
			height = 300;
			
			stage.addChild( new Player( channel ) );
			
			activate();
		}
		
	}

}