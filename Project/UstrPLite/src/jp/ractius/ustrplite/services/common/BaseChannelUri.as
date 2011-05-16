package jp.ractius.ustrplite.services.common 
{
	import flash.utils.unescapeMultiByte;
	import jp.ractius.ustrplite.services.IChannelUri;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelUri implements IChannelUri 
	{
		private var m_serviceName:String;
		private var m_channelName:String;
		private var m_prefixes:Array;
		
		public function BaseChannelUri( serviceName:String, prefixes:Array ) 
		{
			m_serviceName = serviceName;
			m_prefixes = prefixes;
		}
		
		protected function get isEraseSlash():Boolean { return true; }
		
		private function setChannelName( value:String ):void
		{
			var erase:Function = function ( char:String ):void
			{
				var idx:int = value.search( char );
				if ( idx > -1 ) value = value.substr( 0, idx );
			};
			
			erase( "?" );
			erase( "#" );
			if ( isEraseSlash ) erase( "/" );
			
			m_channelName = unescapeMultiByte( value );
		}
		
		/* INTERFACE jp.ractius.ustrplite.services.IChannelUri */
		
		public function test( uri:String ):Boolean 
		{
			for each ( var prefix:String in m_prefixes )
			{
				prefix += "/";
				var idx:int = uri.search( prefix );
				
				if ( idx == -1 ) continue;
				
				// 見つかった
				setChannelName( uri.substr( idx + prefix.length ) );
				
				return true;
			}
			
			return false;
		}
		
		public function get serviceName():String 
		{
			return m_serviceName;
		}
		
		public function get channelName():String 
		{
			return m_channelName;
		}
		
	}

}