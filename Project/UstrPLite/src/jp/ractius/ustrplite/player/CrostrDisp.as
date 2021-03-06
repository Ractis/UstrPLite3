package jp.ractius.ustrplite.player 
{
	import flash.display.Sprite;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class CrostrDisp extends Sprite 
	{
		static private const CROSTR_DIR_LOCAL:String	= "app:/bin/crostr/";
		static private const CROSTR_DIR_REMOTE:String	= "http://" + CROSTR_REMOTE_DOMAIN + "/ustp/crostr/";
		
		static public const CROSTR_REMOTE_DOMAIN:String	= "ractis.rdy.jp";
		
		private var m_loader:HTMLLoader;
		
		public function CrostrDisp( name:String, sessionId:String, isRemote:Boolean ) 
		{
			m_loader = new HTMLLoader();
			m_loader.paintsDefaultBackground = false;
			m_loader.load( new URLRequest( _genCrostrUrl( name, sessionId, isRemote ) ) );
			
			addChild( m_loader );
		}
		
		private function _genCrostrUrl( name:String, sessionId:String, isRemote:Boolean ):String 
		{
			return ( isRemote ? CROSTR_DIR_REMOTE : CROSTR_DIR_LOCAL ) + "crostr.html?" + name + "&" + sessionId;
		}
		
		override public function set width( w:Number ):void
		{
			m_loader.width = w;
		}
		
		override public function set height( h:Number ):void
		{
			m_loader.height = h;
		}
		
	}

}