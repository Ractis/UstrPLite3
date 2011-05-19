package jp.ractius.ustrplite.services 
{
	
	/**
	 * ...
	 * @author ractis
	 */
	public interface IPlayerOption 
	{
		
		/**
		 * 外部のサーバー上に配置された Crostr を使用するか？
		 */
		function get isRemote():Boolean;
		
		function onInitialized():void;
		
	}
	
}