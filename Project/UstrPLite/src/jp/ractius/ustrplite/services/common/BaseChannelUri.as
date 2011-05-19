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
		private var m_patterns:Array;
		
		public function BaseChannelUri( serviceName:String, prefixes:Array, patterns:Array ) 
		{
			m_serviceName = serviceName;
			m_prefixes = prefixes;
			m_patterns = patterns;
		}
		
		protected function get isEraseSlash():Boolean { return true; }
		
		private function setChannelName( value:String ):void
		{
			var erase:Function = function ( char:String ):void
			{
				var idx:int = value.indexOf( char );
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
			m_channelName = null;
			
			var testImpl:Function = function( isPrefix:Boolean ):Boolean
			{
				for each ( var val:String in isPrefix ? m_prefixes : m_patterns )
				{
					val += "/";
					var idx:int = uri.indexOf( val );
					
					if ( isPrefix )
					{
						if ( idx != 0 ) continue;
					}
					else
					{
						if ( idx == -1 ) continue;
					}
					
					// 見つかった
					setChannelName( uri.substr( idx + val.length ) );
					
					return true;
				}
				
				return false;
			}
			
			if ( testImpl( true  ) ) return true;	// PREFIX をチェック
			if ( testImpl( false ) ) return true;	// PATTERN をチェック
			
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