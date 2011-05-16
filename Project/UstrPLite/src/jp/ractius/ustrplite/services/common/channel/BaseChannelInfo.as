package jp.ractius.ustrplite.services.common.channel 
{
	import jp.ractius.ustrplite.data.channel.IChannelInfo;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseChannelInfo extends BaseChannelStatus implements IChannelInfo 
	{
		
		public function BaseChannelInfo() 
		{
			
		}
		
		/* INTERFACE jp.ractius.ustrplite.data.channel.IChannelInfo */
		
		public function get channelId():String		{ return null; }
		public function get userName():String		{ return null; }
		public function get title():String			{ return null; }
		public function get description():String	{ return null; }
		public function get hashTag():String		{ return null; }
		public function get imageUrl():String		{ return null; }
		
	}

}