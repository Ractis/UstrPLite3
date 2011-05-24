package jp.ractius.ripple.gui.buttons 
{
	import flash.events.EventDispatcher;
	import org.aswing.ButtonModel;
	import org.aswing.event.AWEvent;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RButtonModel extends EventDispatcher 
	{
		static public const	STATE_ROLL_OVER:String	= "stateRollOver";
		static public const STATE_PRESS:String		= "statePress";
		
		private var m_model:ButtonModel;
		private var m_listener:Function;
		
		private var m_isRollOver:Boolean	= false;
		private var m_isPress:Boolean		= false;
		
		/**
		 * 
		 * @param	model
		 * @param	listener	function( type:String, isActive:Boolean ):void
		 */
		public function RButtonModel( model:ButtonModel, listener:Function ) 
		{
			m_model		= model;
			m_listener	= listener;
			
			m_model.addStateListener( _onState );
		}
		
		private function _onState( e:AWEvent ):void 
		{
			if ( m_isRollOver != m_model.isRollOver() )
			{
				m_isRollOver = m_model.isRollOver();
				m_listener( STATE_ROLL_OVER, m_isRollOver );
				return;
			}
			
			if ( m_isPress != m_model.isPressed() )
			{
				m_isPress = m_model.isPressed();
				m_listener( STATE_PRESS, m_isPress );
				return;
			}
		}
		
		public function get isRollOver():Boolean { return m_isRollOver; }
		
		public function get isPress():Boolean { return m_isPress; }
		
	}

}