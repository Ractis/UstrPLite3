package jp.ractius.ustrplite.configs 
{
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseConfig 
	{
		private var m_cfgName:String;
		internal var data:Object;
		
		public function BaseConfig( cfgName:String ) 
		{
			m_cfgName	= cfgName;
			data		= new Object();
			
			ConfigManager.load( this );
		}
		
		public function save():void
		{
			ConfigManager.save( this );
		}
		
		internal function onLoad():void
		{
			// override me
		}
		
		public function get cfgName():String { return m_cfgName; }
		
	}

}