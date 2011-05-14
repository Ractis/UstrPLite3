package jp.ractius.ripple.display 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class NoScaleStageSprite extends Sprite 
	{
		
		public function NoScaleStageSprite() 
		{
			if ( stage )	_onAddToStage();
			else 			addEventListener( Event.ADDED_TO_STAGE, _onAddToStage );
		}
		
		private function _onAddToStage( e:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _onAddToStage );
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align		= StageAlign.TOP_LEFT;
			
			onAddToStage();
		}
		
		protected function onAddToStage():void
		{
			// override me
		}
		
	}

}