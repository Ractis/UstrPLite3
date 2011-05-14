package jp.ractius.ripple.utils 
{
	/**
	 * ...
	 * @author ractis
	 */
	public class CsvUtil 
	{
		
		public function CsvUtil() 
		{
			
		}
		
		static public function toCsv( ...rest ):String
		{
			return rest.join( "," );
		}
		
		static public function parseCsv( csv:String ):Array
		{
			return csv.split( "," );
		}
		
	}

}