package jp.ractius.ustrplite.services 
{
	import flash.html.HTMLLoader;
	
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
		
		/**
		 * ポップアウトプレイヤーのアドレスを取得
		 */
		function get popupPlayerUrl():String;
		
		function onInitialized():void;
		function onBeginLoadPopupPlayer( loader:HTMLLoader ):void;
		
	}
	
}