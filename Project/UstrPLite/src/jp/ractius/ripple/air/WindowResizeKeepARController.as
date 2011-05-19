package jp.ractius.ripple.air 
{
	import flash.geom.Point;
	import jp.ractius.ripple.display.resizableFrame.ResizableFrame;
	
	/**
	 * Keep aspect ratio.
	 * @author ractis
	 */
	public class WindowResizeKeepARController extends WindowResizeController 
	{
		private var m_aspectRatio:Number	= 4 / 3;
	//	private var m_offsetW:int 			= 0;
	//	private var m_offsetH:int			= 0;
		
		public function WindowResizeKeepARController( frame:ResizableFrame, bounds:WindowBounds ) 
		{
			super( frame, bounds );
			
		}
		
		override protected function onAction( deltaPos:Point ):void 
		{
			super.onAction( deltaPos );
			
			//TODO offset
			
			var prefferedW:int = Math.round( bounds.h * m_aspectRatio );
			var prefferedH:int = Math.round( bounds.w / m_aspectRatio );
			
			var gapW:int = prefferedW - bounds.w;
			var gapH:int = prefferedH - bounds.h;
			
			if ( !activeV )
			{
				moveEdgeB( gapH );
			}
			else if ( !activeH )
			{
				moveEdgeR( gapW );
			}
			else if ( gapW > 0 )
			{
				switch ( activeH )
				{
				case "L":	moveEdgeL( -gapW );	break;
				case "R":	moveEdgeR( gapW );	break;
				}
			}
			else if ( gapH > 0 )
			{
				switch ( activeV )
				{
				case "T":	moveEdgeT( -gapH );	break;
				case "B":	moveEdgeB( gapH );	break;
				}
			}
		}
		
		public function get aspectRatio():Number { return m_aspectRatio; }
		
		public function set aspectRatio(value:Number):void 
		{
			var edgeMoving:int;
			
			if ( value > m_aspectRatio )	// 横長に
			{
				edgeMoving = Math.round( ( bounds.h - bounds.w / value ) / 2 );
				moveEdgeT(  edgeMoving );
				moveEdgeB( -edgeMoving );
			}
			else							// 縦長に
			{
				edgeMoving = Math.round( ( bounds.w - bounds.h * value ) / 2 );
				moveEdgeL(  edgeMoving );
				moveEdgeR( -edgeMoving );
			}
			
			bounds.commit();
			
			m_aspectRatio = value;
		}
		
	}

}