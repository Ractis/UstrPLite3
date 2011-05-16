package jp.ractius.ustrplite.services.stickam 
{
	import jp.ractius.ustrplite.services.common.BasePlayerOption;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerOption extends BasePlayerOption 
	{
		
		public function PlayerOption() 
		{
			
		}
		
		override public function get name():String	{ return StcService.NAME; }
		
	}

}