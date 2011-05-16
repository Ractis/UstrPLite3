package jp.ractius.ustrplite.player.modules 
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import jp.ractius.ustrplite.player.Player;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class InputModule 
	{
		private var m_player:Player;
		private var m_volume:VolumeModule;
		
		private var m_isCtrlKey:Boolean = false;
		
		public function InputModule( player:Player ) 
		{
			m_player = player;
			m_volume = m_player.volumeMod;
			
			m_player.addEventListener( KeyboardEvent.KEY_DOWN,	_onKeyDown );
			m_player.addEventListener( KeyboardEvent.KEY_UP,	_updateModKey );
			m_player.addEventListener( MouseEvent.MOUSE_WHEEL,	_onMouseWheel );
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
		}
		
	}

}