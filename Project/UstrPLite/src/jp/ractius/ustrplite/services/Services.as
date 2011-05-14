package jp.ractius.ustrplite.services 
{
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.services.ustream.UstService;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Services 
	{
		static private var m_services:Dictionary;
		
		public function Services() 
		{
			
		}
		
		static public function initialize():void
		{
			m_services = new Dictionary();
			
			m_services[ UstService.NAME ]	= new UstService();
		}
		
		static public function getService( serviceName:String ):IService 
		{
			return m_services[ serviceName ];
		}
		
	}

}