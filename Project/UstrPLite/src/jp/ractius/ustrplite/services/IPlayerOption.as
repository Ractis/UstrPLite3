package jp.ractius.ustrplite.services 
{
	
	/**
	 * ...
	 * @author ractis
	 */
	public interface IPlayerOption 
	{
		function get name():String;
		
		/**
		 * 外部のサーバー上に配置された Crostr を使用するか？
		 */
		function get isRemote():Boolean;
		
	}
	
}