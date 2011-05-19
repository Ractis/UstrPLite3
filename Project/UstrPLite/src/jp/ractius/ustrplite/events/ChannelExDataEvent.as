package jp.ractius.ustrplite.events 
{
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelExDataEvent extends ChannelEvent 
	{
		static public const CHANGE_EX_DATA:String = "changeExData";
		
		private var m_key:String;
		
		public function ChannelExDataEvent( type:String, key:String ) 
		{
			super( type );
			
			m_key = key;
		}
		
		public function get key():String { return m_key; }
		
	}

}