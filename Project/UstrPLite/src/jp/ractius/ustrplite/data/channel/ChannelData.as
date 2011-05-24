package jp.ractius.ustrplite.data.channel 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import jp.ractius.ustrplite.events.ChannelEvent;
	import jp.ractius.ustrplite.events.ChannelExDataEvent;
	import jp.ractius.ustrplite.services.Services;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelData extends EventDispatcher 
	{
		private var m_currentUpdates:uint = 0;
		
		private var m_serviceName:String;
		private var m_channelName:String;
		
		private var m_isExists:Boolean;
		private var m_channelId:String;
		private var m_userName:String;
		private var m_title:String;
		private var m_description:String;
		private var m_hashTag:String;
		private var m_imageUrl:String;
		
		private var m_status:String			= UstrpliteConstants.STATUS_UNKNOWN;
		private var m_isFavorite:Boolean	= false;
		
		private var m_exData:Dictionary = new Dictionary();
		
		public function ChannelData( serviceName:String, channelName:String ) 
		{
			m_serviceName	= serviceName;
			m_channelName	= channelName;
			
			if ( Services.getService( serviceName ).isChannelIdAsName )
			{
				m_channelId = channelName;
			}
		}
		
		private function _fireEvent( eventType:String ):void
		{
			dispatchEvent( new ChannelEvent( eventType ) );
		}
		
		public function get uri():String { return m_serviceName.toLowerCase() + "/" + m_channelName; }
		
		public function get isUpdating():Boolean { return m_currentUpdates > 0; }
		
		public function beginUpdate():void
		{
			if ( m_currentUpdates == 0 )
			{
				_fireEvent( ChannelEvent.BEGIN_UPDATE );
			}
			
			m_currentUpdates++;
		}
		
		public function endUpdate():void
		{
			m_currentUpdates--;
			
			if ( m_currentUpdates == 0 )
			{
				_fireEvent( ChannelEvent.END_UPDATE );
			}
		}
		
		public function get serviceName():String { return m_serviceName; }
		
		public function get channelName():String { return m_channelName; }
		
		public function get channelId():String { return m_channelId; }
		
		public function set channelId( value:String ):void 
		{
			if ( m_channelId == value ) return;
			
			m_channelId = value;
			_fireEvent( ChannelEvent.CHANGE_CHANNEL_ID );
		}
		
		public function get status():String { return m_status; }
		
		public function set status( value:String ):void 
		{
			if ( value == UstrpliteConstants.STATUS_UNKNOWN ) return;
			if ( m_status == value ) return;
			
			m_status = value;
			_fireEvent( ChannelEvent.CHANGE_STATUS );
		}
		
		public function get userName():String { return m_userName; }
		
		public function set userName(value:String):void 
		{
			if ( m_userName == value ) return;
			
			m_userName = value;
			_fireEvent( ChannelEvent.CHANGE_USER_NAME );
		}
		
		public function get title():String { return m_title; }
		
		public function set title(value:String):void 
		{
			if ( m_title == value ) return;
			
			m_title = value;
			_fireEvent( ChannelEvent.CHANGE_TITLE );
		}
		
		public function get description():String { return m_description; }
		
		public function set description( value:String ):void 
		{
			value = _formatDescription( value );
			
			if ( m_description == value ) return;
			
			m_description = value;
			_fireEvent( ChannelEvent.CHANGE_DESCRIPTION );
		}
		
		private function _formatDescription( value:String ):String 
		{
			value = value.replace( /<("[^"]*"|'[^']*'|[^'">])*>/g, "" );	// HTML タグを削除
			value = value.replace( /\t/g, "" );								// タブを削除
			value = value.replace( /\n/g, " " );							// 改行をスペースに変換
			return value;
		}
		
		public function get hashTag():String { return m_hashTag; }
		
		public function set hashTag(value:String):void 
		{
			if ( m_hashTag == value ) return;
			
			m_hashTag = value;
			_fireEvent( ChannelEvent.CHANGE_HASH_TAG );
		}
		
		public function get imageUrl():String { return m_imageUrl; }
		
		public function set imageUrl( value:String ):void 
		{
			if ( m_imageUrl == value ) return;
			
			m_imageUrl = value;
			_fireEvent( ChannelEvent.CHANGE_IMAGE_URL );
		}
		
		public function get isFavorite():Boolean { return m_isFavorite; }
		
		public function set isFavorite( value:Boolean ):void 
		{
			if ( m_isFavorite == value ) return;
			
			m_isFavorite = value;
			_fireEvent( ChannelEvent.CHANGE_FAVORITE );
		}
		
		public function get isExists():Boolean { return m_isExists; }
		
		public function set isExists( value:Boolean ):void 
		{
			m_isExists = value;
		}
		
		public function getExData( key:String ):Object
		{
			return m_exData[ key ];
		}
		
		public function setExData( key:String, data:Object ):void
		{
			m_exData[ key ] = data;
			dispatchEvent( new ChannelExDataEvent( ChannelExDataEvent.CHANGE_EX_DATA, key ) );
		}
		
		public function exDataHasProp( key:String ):Boolean
		{
			return m_exData.hasOwnProperty( key );
		}
		
	}

}