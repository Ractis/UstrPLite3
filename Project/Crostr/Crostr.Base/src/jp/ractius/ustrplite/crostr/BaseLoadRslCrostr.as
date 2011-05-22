package jp.ractius.ustrplite.crostr 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseLoadRslCrostr extends BaseCrostr 
	{
		private var m_rslUrl:String;
		private var m_rslLoader:Loader;
		
		public function BaseLoadRslCrostr( rslUrl:String ) 
		{
			m_rslUrl = rslUrl;
			
			super();
		}
		
		override protected function onAddToStage():void 
		{
			super.onAddToStage();
			
			m_rslLoader = new Loader();
			m_rslLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadRsl );
			m_rslLoader.load( new URLRequest( m_rslUrl ) );
		}
		
		protected function onLoadRsl( e:Event ):void 
		{
			e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			// override me
		}
		
		protected final function get rslLoader():Loader { return m_rslLoader; }
		
		private function _getDefinition( name:String ):Object
		{
			return m_rslLoader.contentLoaderInfo.applicationDomain.getDefinition( name );
		}
		
		protected final function getClassDefinition( name:String ):Class
		{
			return Class( _getDefinition( name ) );
		}
		
	}

}