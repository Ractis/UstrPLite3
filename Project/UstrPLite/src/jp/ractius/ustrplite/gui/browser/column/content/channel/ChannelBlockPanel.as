package jp.ractius.ustrplite.gui.browser.column.content.channel 
{
	import flash.events.Event;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.gui.browser.column.content.channel.thumbnail.ThumbnailPanel;
	import org.aswing.Container;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelBlockPanel extends JPanel 
	{
		private var m_thumbnail:JPanel;
		
		public function ChannelBlockPanel( channel:ChannelData ) 
		{
			append( m_thumbnail = new ThumbnailPanel( channel ) );
		}
		
		public function removeFromParent( e:Event = null ):void
		{
			if ( e ) e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			Container( parent ).remove( this );
		}
		
		override public function setPreferredWidth( preferredWidth:int ):void 
		{
			m_thumbnail.setPreferredWidth( preferredWidth );
			
			//super.setPreferredWidth( preferredWidth );
		}
		
	}

}