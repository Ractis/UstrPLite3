package jp.ractius.ustrplite.browser 
{
	import flash.desktop.Icon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeWindow;
	import flash.events.ScreenMouseEvent;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ractis
	 */
	public class BrowserNativeAppIcon 
	{
		[Embed(source = 'assets/iconNormal.png')]	static private const IconNormalImg:Class;
		[Embed(source = 'assets/iconActive.png')]	static private const IconActiveImg:Class;
		
		static public const STATUS_NORMAL:String	= "statusNormal";
		static public const STATUS_ACTIVE:String	= "statusActive";
		
		private var m_bmpsMap:Dictionary;
		
		public function BrowserNativeAppIcon() 
		{
			// init Bitmaps
			m_bmpsMap = new Dictionary();
			_appendBitmapAry( STATUS_NORMAL,	new IconNormalImg() );
			_appendBitmapAry( STATUS_ACTIVE,	new IconActiveImg() );
			
			// init Status
			status = STATUS_NORMAL;
			
			// init Menu
			
			// Windows - TrayIcon
			if ( NativeApplication.supportsSystemTrayIcon )
			{
				var icon:SystemTrayIcon = _icon as SystemTrayIcon;
				
				icon.tooltip = _nativeWindow.title;
				
				icon.addEventListener( ScreenMouseEvent.CLICK, _onClick );
			}
		}
		
		private function _appendBitmapAry( name:String, orig:Bitmap ):void
		{
			orig.smoothing = true;
			
			var bmpAry:Array = [ orig.bitmapData,
								 _renderBmp( orig, 48 ),
								 _renderBmp( orig, 32 ),
								 _renderBmp( orig, 16 ) ];
			
			m_bmpsMap[ name ] = bmpAry;
		}
		
		private function _renderBmp( src:Bitmap, size:int ):BitmapData
		{
			var tgt:BitmapData = new BitmapData( size, size, true, 0 );
			
			var scale:Number = Number( size ) / src.width;
			
			var mtx:Matrix = new Matrix();
			mtx.scale( scale, scale );
			
			tgt.draw( src, mtx, null, null, null, true );
			
			return tgt;
		}
		
		private function get _nativeWindow():NativeWindow
		{
			return Browser.inst.stage.nativeWindow;
		}
		
		private function _onClick( e:ScreenMouseEvent ):void 
		{
			_nativeWindow.activate();
		//	_nativeWindow.orderToFront();
		}
		
		public function set status( value:String ):void
		{
			_icon.bitmaps = m_bmpsMap[ value ];
		}
		
		private function get _nativeApp():NativeApplication
		{
			return NativeApplication.nativeApplication;
		}
		
		private function get _icon():Icon
		{
			return _nativeApp.icon;
		}
		
	}

}