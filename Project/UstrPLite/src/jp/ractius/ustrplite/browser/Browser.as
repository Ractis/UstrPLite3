package jp.ractius.ustrplite.browser 
{
	import flash.utils.Dictionary;
	import jp.ractius.ripple.display.NoScaleStageSprite;
	import jp.ractius.ustrplite.browser.skins.BaseSkin;
	import jp.ractius.ustrplite.browser.skins.MiniSkin;
	import jp.ractius.ustrplite.browser.skins.StandardSkin;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.data.playing.PlayingStore;
	import jp.ractius.ustrplite.services.Services;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Browser extends NoScaleStageSprite 
	{
		static private var s_inst:Browser;
		
		private var m_skins:Dictionary;
		private var m_currentSkin:BaseSkin;
		
		public function Browser() 
		{
			super();
		}
		
		override protected function onAddToStage():void 
		{
			super.onAddToStage();
			
			m_skins = new Dictionary();
			m_skins[ StandardSkin.NAME ]	= new StandardSkin( stage );
			m_skins[ MiniSkin.NAME ]		= new MiniSkin( stage );
		}
		
		static public function get inst():Browser
		{
			if ( !s_inst )
			{
				s_inst = new Browser();
			}
			
			return s_inst;
		}
		
		public function getSkin( name:String ):BaseSkin
		{
			return m_skins[ name ];
		}
		
		public function changeSkin( name:String ):void
		{
			if ( m_currentSkin )
			{
				removeChild( m_currentSkin );
			}
			
			m_currentSkin = m_skins[ name ];
			m_currentSkin.windowBounds.commit();
			addChild( m_currentSkin );
		}
		
		public function play( url:String ):void
		{
			if ( url.toLowerCase() == "changeskin" )
			{
				if ( m_currentSkin is StandardSkin )	changeSkin( MiniSkin.NAME );
				else									changeSkin( StandardSkin.NAME );
			}
			
			var ch:ChannelData = Services.parseUri( url );
			
			if ( !ch ) return;
			
			PlayingStore.inst.play( ch );
		}
		
		public function addFav( url:String ):void
		{
			var ch:ChannelData = Services.parseUri( url );
			
			if ( !ch ) return;
			
			//TODO サービス毎の判定
			if ( ch.serviceName == "Ltb" ) return;
			
			FavoriteStore.inst.addFav( ch );
		}
		
	}

}