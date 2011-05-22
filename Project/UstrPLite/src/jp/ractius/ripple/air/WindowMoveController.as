package jp.ractius.ripple.air 
{
	import flash.display.InteractiveObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class WindowMoveController extends BaseWindowController 
	{
		
		public function WindowMoveController( tgt:InteractiveObject, bounds:WindowBounds ) 
		{
			super( tgt, bounds );
		}
		
		override protected function onAction( deltaPos:Point ):void 
		{
			bounds.move( deltaPos.x, deltaPos.y );
			bounds.commit();
		}
		
	}

}