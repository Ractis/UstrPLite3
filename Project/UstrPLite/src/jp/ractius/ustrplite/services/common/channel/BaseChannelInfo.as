package jp.ractius.ustrplite.services.common.channel 
{
	import jp.ractius.ustrplite.UstrpliteConstants;
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelInfo implements IChannelInfo 
	{
		
		public function BaseChannelInfo() 
		{
			
		}
		
		/* INTERFACE jp.ractius.ustrplite.services.common.channel.IChannelInfo */
		
		public function get isAvailable():Boolean	{ return true; }
		public function get status():String 		{ return UstrpliteConstants.STATUS_UNKNOWN; }
		public function get channelId():String		{ return null; }
		public function get userName():String		{ return null; }
		public function get title():String			{ return null; }
		public function get description():String	{ return null; }
		public function get hashTag():String		{ return null; }
		public function get imageUrl():String		{ return null; }
		
	}

}