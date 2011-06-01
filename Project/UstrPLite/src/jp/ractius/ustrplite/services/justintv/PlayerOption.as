package jp.ractius.ustrplite.services.justintv 
{
	import flash.geom.Point;
	import flash.html.HTMLLoader;
	import jp.ractius.ripple.utils.Localization;
	import jp.ractius.ustrplite.events.ChannelExDataEvent;
	import jp.ractius.ustrplite.player.Player;
	import jp.ractius.ustrplite.services.common.BasePlayerOption;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerOption extends BasePlayerOption 
	{
		
		public function PlayerOption( player:Player ) 
		{
			super( player );
		}
		
		override public function get isRemote():Boolean	{ return true; }
		
		override public function get popupPlayerUrl():String
		{
			return _topUrl + channel.channelName + "/popout";
		}
		
		override public function onBeginLoadPopupPlayer( loader:HTMLLoader ):void 
		{
			loader.window.shouldRedirect = false;
		}
		
		override public function onInitialized():void 
		{
			channel.addEventListener( ChannelExDataEvent.CHANGE_EX_DATA, _onChangeExData );
			
			if ( channel.exDataHasProp( ChannelExDataName.VIDEO_SIZE ) ) _applyVideoSize();
		}
		
		private function _onChangeExData( e:ChannelExDataEvent ):void 
		{
			switch( e.key )
			{
			case ChannelExDataName.VIDEO_SIZE:	_applyVideoSize();	break;
			}
		}
		
		private function _applyVideoSize():void
		{
			var videoSize:Point = channel.getExData( ChannelExDataName.VIDEO_SIZE ) as Point;
			if ( !videoSize ) return;
			
			player.setVideoSize( videoSize.x, videoSize.y );
		}
		
		private function get _topUrl():String
		{
			var url:String = "justin.tv/";
			
			var lang:String = Localization.substitude( "services.justintv.lang" );
			if ( lang ) url = lang + "." + url;
			
			return "http://" + url;
		}
		
	}

}