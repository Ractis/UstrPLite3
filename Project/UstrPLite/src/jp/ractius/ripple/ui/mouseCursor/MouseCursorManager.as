package jp.ractius.ripple.ui.mouseCursor 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import jp.ractius.ripple.RMath;
	/**
	 * ...
	 * @author ractis
	 */
	public class MouseCursorManager 
	{
		[Embed(source = 'assets/ResizeCursor.png')]	static private const ResizeCursorImg:Class;
		
		static public const RESIZE_0:String		= "resize0";
		static public const RESIZE_45:String	= "resize45";
		static public const RESIZE_90:String	= "resize90";
		static public const RESIZE_135:String	= "resize135";
		
		public function MouseCursorManager() 
		{
			
		}
		
		static public function initialize():void
		{
			_registerResizeCursor( RESIZE_0,	0 );
			_registerResizeCursor( RESIZE_45,	45 );
			_registerResizeCursor( RESIZE_90,	90 );
			_registerResizeCursor( RESIZE_135,	135 );
		}
		
		static private function _registerResizeCursor( name:String, rotation:Number ):void 
		{
			_registerCursorData( name, ResizeCursorImg, rotation );
		}
		
		static private function _registerCursorData( name:String, cursorImg:Class, rotation:Number = 0 ):void 
		{
			var img:Bitmap = new cursorImg();
			img.smoothing = true;
			
			var bmp:BitmapData = new BitmapData( 32, 32, true, 0x00FFFFFF );
			
			var mtx:Matrix = new Matrix();
			mtx.translate( -16, -16 );
			mtx.rotate( RMath.toRad( rotation ) );
			mtx.translate( 16, 16 );
			
			bmp.draw( img, mtx );
			
			var cursor:MouseCursorData = new MouseCursorData();
			cursor.data = new <BitmapData>[ bmp ];
			cursor.hotSpot = new Point( 16, 16 );
			
			Mouse.registerCursor( name, cursor );
		}
		
	}

}