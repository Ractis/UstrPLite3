package jp.ractius.ustrplite.browser 
{
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import jp.ractius.ripple.air.RNativeMenu;
	import jp.ractius.ripple.utils.Localization;
	import jp.ractius.ustrplite.data.favorite.FavoriteStore;
	import jp.ractius.ustrplite.events.BrowserEvent;
	import jp.ractius.ustrplite.UstrpliteConstants;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class BrowserMenu extends RNativeMenu 
	{
		static private const NAME_PREFIX:String				= "browser.menu."
		static private const CHANGE_SKIN_NAME_PREFIX:String	= NAME_PREFIX + "switchTo";
		
		private var m_changeSkinItem:NativeMenuItem;
		
		public function BrowserMenu() 
		{
			var browser:Browser = Browser.inst;
			
			m_changeSkinItem = appendItem( "",			_onSwitchSkin );
			appendSeparator();
			appendToggleItem( "general.alwaysInFront",	browser.stage.nativeWindow, "alwaysInFront" );
			appendSeparator();
			pushSubmenu( "general.fav" );
				appendItem( NAME_PREFIX + "fav.import",	_onFavImport );
				appendItem( NAME_PREFIX + "fav.export",	_onFavExport );
			popSubmenu();
			appendSeparator();
			appendItem( "general.minimize",				browser.minimize );
			appendItem( "general.exit",					browser.exit );
			
			// Listeners
			browser.addEventListener( BrowserEvent.SWITCH_SKIN, _onSwitchSkinBrowser );
			_onSwitchSkinBrowser();
		}
		
		private function _onFavExport( ...e ):void 
		{
			var file:File = new File( File.desktopDirectory.nativePath + "/favorites.json" );
			
			file.addEventListener( Event.SELECT, function( ...e ):void
			{
				var fs:FileStream = new FileStream();
				fs.open( file, FileMode.WRITE );
				fs.writeUTFBytes( FavoriteStore.inst.serialize() );
				fs.close();
			} );
			
			file.browseForSave( Localization.substitude( "browser.dialog.fav.export" ) );
		}
		
		private function _onFavImport( ...e ):void 
		{
			var file:File = new File();
			
			file.addEventListener( Event.SELECT, function( ...e ):void
			{
				var fs:FileStream = new FileStream();
				fs.open( file, FileMode.READ );
				FavoriteStore.inst.deserialize( fs.readUTFBytes( fs.bytesAvailable ) );
				fs.close();
			} );
			
			file.browseForOpen( Localization.substitude( "browser.dialog.fav.import" ),
								[ new FileFilter( Localization.substitude( "fileType.fav" ) + " (*.json)", "*.json" ) ] );
		}
		
		private function _onSwitchSkin( ...e ):void 
		{
			Browser.inst.play( "switchskin" );
		}
		
		private function _onSwitchSkinBrowser( e:BrowserEvent = null ):void 
		{
			var name:String;
			
			if ( Browser.inst.currentSkinName == UstrpliteConstants.BROWSER_SKIN_STD )	name = "Mini";
			else																		name = "Browser";
			
			m_changeSkinItem.label = Localization.substitude( CHANGE_SKIN_NAME_PREFIX + name );
		}
		
	}

}