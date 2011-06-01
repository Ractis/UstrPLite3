package jp.ractius.ustrplite.player.modules 
{
	import flash.display.Stage;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import jp.ractius.ustrplite.player.Player;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class FullScreenMouseModule 
	{
		static private const HIDE_DELAY:uint = 1000;
		
		private var m_stage:Stage;
		private var m_hideTimer:Timer;
		private var m_isRollOver:Boolean = false;
		private var m_isActive:Boolean = false;
		
		public function FullScreenMouseModule( player:Player ) 
		{
			m_stage = player.stage;
			m_hideTimer = new Timer( HIDE_DELAY, 1 );
			
			m_hideTimer.addEventListener( TimerEvent.TIMER_COMPLETE, _onCompleteHideTimer );
			
			player.addEventListener( MouseEvent.ROLL_OVER,	_onRollOver );
			player.addEventListener( MouseEvent.ROLL_OUT,	_onRollOut );
			m_stage.addEventListener( MouseEvent.MOUSE_MOVE, _onMouseMove );
			m_stage.addEventListener( FullScreenEvent.FULL_SCREEN, _onFullScreen );
			
			//FIXME メニューからフルスクリーン選択後、RollOver が false になる問題
		}
		
		private function _onCompleteHideTimer( e:TimerEvent ):void 
		{
			if ( m_isRollOver ) Mouse.hide();
		}
		
		private function _onRollOut( e:MouseEvent ):void 
		{
			m_isRollOver = false;
			
			if ( m_isActive )
			{
				Mouse.show();
			}
		}
		
		private function _onRollOver( e:MouseEvent ):void 
		{
			m_isRollOver = true;
			
			if ( m_isActive )
			{
				_restartTimer();
			}
		}
		
		private function _onMouseMove( e:MouseEvent ):void
		{
			m_isRollOver = true;
			
			if ( !m_isActive )
			{
				return;
			}
			
			if ( !m_hideTimer.running )
			{
				Mouse.show();
			}
			
			_restartTimer();
		}
		
		private function _restartTimer():void 
		{
			m_hideTimer.reset();
			m_hideTimer.delay = HIDE_DELAY;
			m_hideTimer.repeatCount = 1;
			m_hideTimer.start();
		}
		
		private function _onFullScreen( e:FullScreenEvent ):void 
		{
			if ( m_isActive = e.fullScreen )
			{
				_restartTimer();
			}
			else
			{
				m_hideTimer.reset();
			}
		}
		
	}

}