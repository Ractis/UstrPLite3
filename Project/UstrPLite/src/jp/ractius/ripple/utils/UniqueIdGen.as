package jp.ractius.ripple.utils 
{
	/**
	 * 1 から開始する UniqueId 生成器.
	 * @author ractis
	 */
	public class UniqueIdGen 
	{
		static private var s_uid:int = 0;
		
		public function UniqueIdGen() 
		{
			
		}
		
		static public function uid():int
		{
			return ++s_uid;
		}
		
	}

}