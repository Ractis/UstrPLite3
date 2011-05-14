package jp.ractius.ustrplite.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelEvent extends Event 
	{
		static public const BEGIN_UPDATE:String			= "beginUpdate";
		static public const END_UPDATE:String			= "endUpdate";
		static public const CHANGE_IMAGE_URL:String		= "changeImageUrl";
		static public const CHANGE_HASH_TAG:String		= "changeHashTag";
		static public const CHANGE_DESCRIPTION:String	= "changeDescription";
		static public const CHANGE_TITLE:String			= "changeTitle";
		static public const CHANGE_USER_NAME:String		= "changeUserName";
		static public const CHANGE_CHANNEL_ID:String 	= "changeChannelId";
		static public const CHANGE_STATUS:String		= "changeStatus";
		
		public function ChannelEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}