package jp.ractius.ripple.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RLoader extends Loader 
	{
		private var m_isLoaded:Boolean;
		
		public function RLoader( url:String, onComplete:Function = null ) 
		{
			if ( onComplete != null )
			{
				addCompleteListener( onComplete );
			}
			
			addCompleteListener( _onComplete );
			
			load( new URLRequest( url ) );
		}
		
		public function cloneBitmap():Bitmap
		{
			var bmpData:BitmapData = Bitmap( content ).bitmapData;
			return new Bitmap( bmpData );
		}
		
		private function _onComplete( e:Event ):void 
		{
			m_isLoaded = true;
		}
		
		public function addCompleteListener( listener:Function ):void
		{
			contentLoaderInfo.addEventListener( Event.COMPLETE, listener );
		}
		
		public function get isLoaded():Boolean { return m_isLoaded; }
		
	}

}