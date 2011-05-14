package jp.ractius.ustrplite.services.common 
{
	import jp.ractius.ustrplite.services.IPlayerOption;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BasePlayerOption implements IPlayerOption 
	{
		
		public function BasePlayerOption() 
		{
			
		}
		
		public function get name():String			{ return null; }
		public function get isRemote():Boolean		{ return false; }
		public function get remoteDomain():String	{ return null; }
		
	}

}