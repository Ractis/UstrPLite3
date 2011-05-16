package jp.ractius.ustrplite.services.justintv 
{
	import jp.ractius.ustrplite.services.common.BasePlayerOption;
	import jp.ractius.ustrplite.services.justintv.JtvService;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class PlayerOption extends BasePlayerOption 
	{
		
		public function PlayerOption() 
		{
			
		}
		
		override public function get name():String		{ return JtvService.NAME; }
		override public function get isRemote():Boolean	{ return true; }
		
	}

}