package jp.ractius.ustrplite.services.common.channel 
{
	import jp.ractius.ustrplite.data.channel.IChannelStatus;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelStatus implements IChannelStatus 
	{
		
		public function BaseChannelStatus() 
		{
			
		}
		
		protected function genStatus( isLive:Boolean ):String
		{
			return isLive ? UstrpliteConstants.STATUS_LIVE : UstrpliteConstants.STATUS_OFFLINE;
		}
		
		/* INTERFACE jp.ractius.ustrplite.data.channel.IChannelStatus */
		
		public function get isAvailable():Boolean	{ return true; }
		public function get status():String 		{ return UstrpliteConstants.STATUS_UNKNOWN; }
		
	}

}