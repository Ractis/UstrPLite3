package jp.ractius.ustrplite.player.modules 
{
	import flash.events.EventDispatcher;
	import jp.ractius.ripple.RMath;
	import jp.ractius.ustrplite.events.VolumeEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class VolumeModule extends EventDispatcher 
	{
		private var m_volume:int		= 75;
		private var m_boostMax:int		= 1000;
		private var m_isBoost:Boolean	= true;//false;
		private var m_isMute:Boolean	= false;
		
		public function VolumeModule() 
		{
			
		}
		
		public function add5( n:int ):void
		{
			// volume を 5 の倍数に
			if ( n >= 0 )	m_volume = Math.floor( m_volume / 5 ) * 5;
			else			m_volume = Math.ceil(  m_volume / 5 ) * 5;
			
			m_volume += n * 5;
			
			volume = m_volume;	// clamp
		}
		
		private function _fireEvent( type:String ):void { dispatchEvent( new VolumeEvent( type ) ); }
		
		private function _fireChangeVolume():void	{ _fireEvent( VolumeEvent.CHANGE_VOLUME ); }
		
		public function get volume():int
		{
			return isMute ? 0 : m_volume;
		}
		
		public function set volume( value:int ):void 
		{
			m_volume = RMath.clamp( value, 0, m_isBoost ? m_boostMax : 100 );
			_fireChangeVolume();
		}
		
		public function get boostMax():int { return m_boostMax; }
		
		public function get isBoost():Boolean { return m_isBoost; }
		
		public function get isMute():Boolean { return m_isMute; }
		
		public function set isMute( value:Boolean ):void
		{
			m_isMute = value;
			_fireChangeVolume();
		}
		
	}

}