package jp.ractius.ripple.utils 
{
	/**
	 * ...
	 * @author ractis
	 */
	public class Algorithm 
	{
		
		public function Algorithm() 
		{
			
		}
		
		static public function forEachChar( v:String, func:Function ):void
		{
			for ( var i:int = 0; i < v.length; i++ )
			{
				var c:String = v.charAt( i );
				
				switch ( func.length )
				{
				case 1:		func( c );		break;
				case 2:		func( c, i );	break;
				default:	throw new ArgumentError();
				}
			}
		}
		
		static public function forN( n:int, func:Function ):void
		{
			for ( var i:int = 0; i < n; i++ )
			{
				switch ( func.length )
				{
				case 1:		func( i );	break;
				default:	func();		break;
				}
			}
		}
		
	}

}