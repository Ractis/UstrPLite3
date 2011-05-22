package jp.ractius.ustrplite.data.image 
{
	import flash.utils.Dictionary;
	import jp.ractius.ripple.display.RLoader;
	/**
	 * ...
	 * @author ractis
	 */
	public class ThumbnailStore 
	{
		static private var s_inst:ThumbnailStore;
		
		private var m_map:Dictionary;
		
		public function ThumbnailStore() 
		{
			m_map = new Dictionary();
		}
		
		static public function get inst():ThumbnailStore
		{
			if ( !s_inst )
			{
				s_inst = new ThumbnailStore();
			}
			
			return s_inst;
		}
		
		public function getImageLoader( url:String ):RLoader
		{
			var img:RLoader = m_map[ url ];
			
			if ( !img )
			{
				img = new RLoader( url );
				m_map[ url ] = img;
			}
			
			return img;
		}
		
	}

}