package jp.ractius.ustrplite.configs 
{
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseConfig 
	{
		private var m_cfgName:String;
		private var m_xml:XML;
		
		public function BaseConfig( cfgName:String ) 
		{
			m_cfgName	= cfgName;
			m_xml		= new XML( "<" + cfgName + "></" + cfgName + ">" );
			
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
		
		internal function get xml():XML { return m_xml; }
		
		internal function set xml(value:XML):void 
		{
			m_xml = value;
		}
		
	}

}