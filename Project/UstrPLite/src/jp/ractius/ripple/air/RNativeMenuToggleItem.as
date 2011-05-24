package jp.ractius.ripple.air 
{
	import flash.display.NativeMenuItem;
	
	/**
	 * ...
	 * @author ractis
	 */
	internal class RNativeMenuToggleItem extends NativeMenuItem 
	{
		private var m_tgt:Object;
		private var m_name:String;
		
		public function RNativeMenuToggleItem( tgt:Object, name:String ) 
		{
			m_tgt	= tgt;
			m_name	= name;
		}
		
		public function toggle():Boolean
		{
			var toggle:Boolean = m_tgt[ m_name ] = !m_tgt[ m_name ];
			checked = toggle;
			return toggle;
		}
		
	}

}