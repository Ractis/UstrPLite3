package jp.ractius.ustrplite.gui.browser.column.content.channel 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import jp.ractius.ripple.anim.RAnimator;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.events.ChannelEvent;
	import jp.ractius.ustrplite.gui.browser.column.content.channel.thumbnail.ThumbnailPanel;
	import jp.ractius.ustrplite.UstrpliteConstants;
	import org.aswing.AssetPane;
	import org.aswing.Container;
	import org.aswing.event.ResizedEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.JPanel;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ChannelBlockPanel extends JPanel 
	{
		[Embed(source = 'assets/live.png')]	static private const LiveImg:Class;
		
		private var m_channel:ChannelData;
		private var m_thumbnail:JPanel;
		
		private var m_live:Bitmap;
		
		public function ChannelBlockPanel( channel:ChannelData ) 
		{
			m_channel = channel;
			
			append( m_thumbnail = new ThumbnailPanel( channel ) );
			
			m_live = new LiveImg();
			m_live.alpha = 0;
			m_thumbnail.addChild( m_live );
			
			m_thumbnail.addEventListener( ResizedEvent.RESIZED, _onResizedThumbnail );
			
			m_channel.addEventListener( ChannelEvent.CHANGE_STATUS, _onChangeStatus );
			_onChangeStatus();
		}
		
		private function _onResizedThumbnail( e:ResizedEvent ):void 
		{
			var size:IntDimension = e.getNewSize();
			m_live.x = size.width - m_live.width;
		}
		
		private function _onChangeStatus( e:ChannelEvent = null ):void 
		{
			RAnimator.startFade( m_live, m_channel.status == UstrpliteConstants.STATUS_LIVE, 250 );
		}
		
		public function removeFromParent( e:Event = null ):void
		{
			if ( e ) e.currentTarget.removeEventListener( e.type, arguments.callee );
			
			removeFromContainer();
		}
		
		override public function setPreferredWidth( preferredWidth:int ):void 
		{
			m_thumbnail.setPreferredWidth( preferredWidth );
			
			//super.setPreferredWidth( preferredWidth );
		}
		
	}

}