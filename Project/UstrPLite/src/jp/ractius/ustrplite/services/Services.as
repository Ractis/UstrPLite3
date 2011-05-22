package jp.ractius.ustrplite.services 
{
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
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
		
		static public function parseUri( url:String ):ChannelData
		{
			var uri:IChannelUri;
			forEach( function( service:IService ):Boolean
			{
				uri = service.createChannelUri();
				
				if ( uri.test( url ) )	return false;	// サービスが見つかった
				else					return true;	// 見つからないので続行
			} );
			
			if ( !uri.channelName )
			{
				// 見つからなかった
				return null;
			}
			
			return ChannelStore.inst.getChannel( uri.serviceName, uri.channelName );
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