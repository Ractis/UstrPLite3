package jp.ractius.ustrplite.services 
{
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.services.justintv.JtvService;
	import jp.ractius.ustrplite.services.livetube.LtbService;
	import jp.ractius.ustrplite.services.stickam.StcService;
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
			m_services[ JtvService.NAME ]	= new JtvService();
			m_services[ StcService.NAME ]	= new StcService();
			m_services[ LtbService.NAME ]	= new LtbService();
		}
		
		static public function getService( serviceName:String ):IService 
		{
			return m_services[ serviceName ];
		}
		
		static public function forEach( func:Function ):void
		{
			for each ( var service:IService in m_services )
			{
				if ( !func( service ) ) break;
			}
		}
		
	}

}