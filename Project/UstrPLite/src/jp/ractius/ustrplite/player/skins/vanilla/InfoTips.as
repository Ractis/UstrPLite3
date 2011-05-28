package jp.ractius.ustrplite.player.skins.vanilla 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.ractius.ripple.anim.RAnimator;
	import jp.ractius.ustrplite.events.PlayerEvent;
	import jp.ractius.ustrplite.events.VolumeEvent;
	import jp.ractius.ustrplite.gui.player.vanilla.InfoTip;
	import jp.ractius.ustrplite.player.modules.VolumeModule;
	import jp.ractius.ustrplite.player.Player;
	import sweezy.anim.core.Animator;
	import sweezy.anim.core.IPropertyAnimation;
	import sweezy.anim.easing.Back;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class InfoTips extends Sprite 
	{
		static private const TIP_WIDTH:Number	= 75;
		static private const TIMER_DELAY:uint	= 2000;
		static private const HEIGHT:Number		= 30;
		
		private var m_player:Player;
		private var m_volumeMod:VolumeModule;
		
		private var m_volumeTip:InfoTip;
		private var m_viewersTip:InfoTip;
		
		private var m_tipCount:int = 0;
		
		private var m_showTimer:Timer;
		
		public function InfoTips( player:Player ) 
		{
			m_player	= player;
			m_volumeMod	= m_player.volumeMod;
			
			alpha = 0.8;
			
			_append( m_viewersTip	= new InfoTip( InfoTip.ViewersIconImg ) );
			_append( m_volumeTip	= new InfoTip( InfoTip.VolumeIconImg ) );
			
			// ViewersTip
			m_viewersTip.alpha = 0;
			m_viewersTip.visible = false;
			
			// Timer
			m_showTimer = new Timer( 0, 1 );
			
			// Listeners
			m_volumeMod.addEventListener( VolumeEvent.CHANGE_VOLUME,	_onChangeVolume );
			_onChangeVolume();
			
			m_volumeMod.addEventListener( VolumeEvent.CHANGE_VOLUME,	_show );
			
			m_player.addEventListener( PlayerEvent.CHANGE_VIEWERS,	_onChangeViewers );
			m_player.addEventListener( MouseEvent.MOUSE_MOVE,		_show );
			m_player.addEventListener( MouseEvent.ROLL_OUT,			_hide );
			
			m_showTimer.addEventListener( TimerEvent.TIMER_COMPLETE, _hide );
		}
		
		private function _show( ...e ):void
		{
			var timerIsRunning:Boolean = m_showTimer.running;
			
			// Show Timer
			m_showTimer.reset();
			m_showTimer.delay = TIMER_DELAY;
			m_showTimer.repeatCount = 1;
			m_showTimer.start();
			
			if ( timerIsRunning ) return;
			
			var delay:int = 100;
			
			_fadeIn( m_viewersTip, delay );
			if ( m_viewersTip.visible ) delay += 150;
			
			_fadeIn( m_volumeTip, delay );
		}
		
		private function _hide( ...e ):void 
		{
			m_showTimer.stop();
			
			var delay:int = 100;
			
			_fadeOut( m_viewersTip, delay );
			if ( m_viewersTip.visible ) delay += 150;
			
			_fadeOut( m_volumeTip, delay );
		}
		
		private function _fadeIn( tgt:Object, delay:int ):void
		{
			var anim:IPropertyAnimation = Animator.animate( tgt, 250, Back.easeOut, delay );
			anim.to( "y", 0 );
			anim.start();
		}
		
		private function _fadeOut( tgt:Object, delay:int ):void
		{
			var anim:IPropertyAnimation = Animator.animate( tgt, 250, Back.easeIn, delay );
			anim.to( "y", HEIGHT );
			anim.start();
		}
		
		override public function get width():Number { return m_tipCount * TIP_WIDTH - 15; }
		
		override public function get height():Number { return HEIGHT; }
		
		private function _append( tip:InfoTip ):void
		{
			tip.y = HEIGHT;
			
			addChild( tip );
			tip.x = m_tipCount * TIP_WIDTH;
			
			m_tipCount++;
		}
		
		private function _onChangeViewers( e:PlayerEvent ):void 
		{
			if ( !m_viewersTip.visible )
			{
				m_viewersTip.visible = true;
				RAnimator.startFadeIn( m_viewersTip, 300 );
			}
			
			m_viewersTip.label = m_player.viewers.toString();
		}
		
		private function _onChangeVolume( e:VolumeEvent = null ):void 
		{
			m_volumeTip.label = m_volumeMod.volume.toString();
		}
		
	}

}