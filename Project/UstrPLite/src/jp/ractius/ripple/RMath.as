package jp.ractius.ripple 
{
	/**
	 * ...
	 * @author ractis
	 */
	public class RMath 
	{
		
		public function RMath() 
		{
			
		}
		
		static public function clamp( val:Number, min:Number, max:Number ):Number
		{
			if		( val < min )	return min;
			else if	( val > max )	return max;
			else 					return val;
		}
		
		static public function saturate( val:Number ):Number
		{
			return clamp( val, 0, 1 );
		}		
	}

}