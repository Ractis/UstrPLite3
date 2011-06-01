package jp.ractius.ripple.air 
{
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RNativeMenuToggleItem extends NativeMenuItem 
	{
		private var m_tgt:Object;
		private var m_name:String;
		
		public function RNativeMenuToggleItem( tgt:Object, name:String ) 
		{
			m_tgt	= tgt;
			m_name	= name;
			
			addEventListener( Event.PREPARING, _update );
		}
		
		internal function toggle( ...e ):void
		{
			var toggle:Boolean = m_tgt[ m_name ] = !m_tgt[ m_name ];
			checked = toggle;
		}
		
		private function _update( ...e ):void
		{
			checked = m_tgt[ m_name ];
		}
		
	}

}