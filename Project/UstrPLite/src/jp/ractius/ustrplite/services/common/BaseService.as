package jp.ractius.ustrplite.services.common 
{
	import jp.ractius.ustrplite.services.common.channel.BaseChannelQuery;
	import jp.ractius.ustrplite.services.IChannelQuery;
	import jp.ractius.ustrplite.services.IChannelUri;
	import jp.ractius.ustrplite.services.IPlayerOption;
	import jp.ractius.ustrplite.services.IService;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BaseService implements IService 
	{
		private var m_channelQuery:IChannelQuery;
		
		public function BaseService() 
		{
			m_channelQuery = createChannelQuery();
		}
		
		protected function createChannelQuery():IChannelQuery
		{
			// override me
			return new BaseChannelQuery();
		}
		
		//------------------------------------------------------------------------------
		// implments IService
		//------------------------------------------------------------------------------
		public function createPlayerOption():IPlayerOption		{ return new BasePlayerOption(); }
		
		public function createChannelUri():IChannelUri			{ return new BaseChannelUri( null, null ); }
		
		public final function get channelQuery():IChannelQuery	{ return m_channelQuery; }
		
		public function get isChannelIdAsName():Boolean			{ return true; }
		
	}

}