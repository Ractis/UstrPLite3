package jp.ractius.ustrplite.services.justintv 
{
	import flash.geom.Point;
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
			
			player.updateAspectRatio( videoSize.x, videoSize.y );
		}
		
	}

}