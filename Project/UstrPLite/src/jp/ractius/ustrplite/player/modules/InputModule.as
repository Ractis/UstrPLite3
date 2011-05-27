package jp.ractius.ustrplite.player.modules 
{
	import flash.display.NativeWindow;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import jp.ractius.ustrplite.player.Player;
	import jp.ractius.ustrplite.player.PlayerWindow;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class InputModule 
	{
		private var m_player:Player;
		private var m_volume:VolumeModule;
		private var m_window:NativeWindow;
		
		private var m_isCtrlKey:Boolean = false;
		
		private var m_vicViper:uint = 0;
		
		public function InputModule( player:Player ) 
		{
			m_player	= player;
			m_volume	= m_player.volumeMod;
			m_window	= m_player.stage.nativeWindow;
			
			m_player.stage.addEventListener( KeyboardEvent.KEY_DOWN,	_onKeyDown );
			m_player.stage.addEventListener( KeyboardEvent.KEY_UP,	_updateModKey );
			m_player.addEventListener( MouseEvent.MOUSE_WHEEL,	_onMouseWheel );
			m_player.addEventListener( MouseEvent.MIDDLE_CLICK,	_onMiddleClick );
			m_player.addEventListener( MouseEvent.DOUBLE_CLICK, _onDoubleClick );
		}
		
		private function _onDoubleClick( e:MouseEvent ):void 
		{
		//	m_player.toggleFullscreen();
		}
		
		private function _onMiddleClick( e:MouseEvent ):void 
		{
			m_player.minimizeMute();
		}
		
		private function _onMouseWheel( e:MouseEvent ):void 
		{
			var n:int = int( e.delta / 3 );
			if ( n == 0 )
			{
				n = e.delta > 0 ? 1 : -1;
			}
			
			m_volume.add5( n );
		}
		
		private function _updateModKey( e:KeyboardEvent ):void 
		{
			m_isCtrlKey	= e.ctrlKey;
		}
		
		private function _onKeyDown( e:KeyboardEvent ):void 
		{
			_updateModKey( e );
			
			switch ( e.keyCode )
			{
			}
			
			//TODO ﾐｿ-
			const command:Array = [Keyboard.UP, Keyboard.UP, Keyboard.DOWN, Keyboard.DOWN, Keyboard.LEFT, Keyboard.RIGHT, Keyboard.LEFT, Keyboard.RIGHT, Keyboard.B, Keyboard.A];
			if ( command[m_vicViper] == e.keyCode )
			{
				m_vicViper++;
				if ( m_vicViper == 10 )
				{
					// 多重表示
					new PlayerWindow( m_player.channel );
					
					m_vicViper = 0;
				}
			}
			else
			{
				m_vicViper = 0;
			}
		}
		
	}

}