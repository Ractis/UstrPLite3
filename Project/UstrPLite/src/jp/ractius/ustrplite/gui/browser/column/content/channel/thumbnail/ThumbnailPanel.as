package jp.ractius.ustrplite.gui.browser.column.content.channel.thumbnail 
{
	import flash.display.Bitmap;
	import jp.ractius.ripple.display.RLoader;
	import jp.ractius.ripple.gui.panels.KeepARPanel;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.image.ThumbnailStore;
	import jp.ractius.ustrplite.events.ChannelEvent;
	import org.aswing.geom.IntDimension;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class ThumbnailPanel extends KeepARPanel 
	{
		static private const ASPECT_RATIO:Number = 4 / 3;
		
		private var m_channel:ChannelData;
		private var m_image:Bitmap;
		private var m_imageLoader:RLoader;
		
		public function ThumbnailPanel( channel:ChannelData ) 
		{
			super();
			setName( "ThumbnailPanel" );
			
			m_channel = channel;
			
			m_channel.addEventListener( ChannelEvent.CHANGE_IMAGE_URL, _updateImage );
			if ( m_channel.imageUrl ) _updateImage();
		}
		
		private function _updateImage( e:ChannelEvent = null ):void 
		{
			if ( m_image )
			{
				removeChild( m_image );
				m_image = null;
			}
			
			m_imageLoader = ThumbnailStore.inst.getImageLoader( m_channel.imageUrl );
			
			if ( m_imageLoader.isLoaded )	_showImage();
			else							m_imageLoader.addCompleteListener( _showImage );
		}
		
		private function _showImage( ...e ):void 
		{
			addChild( m_image = m_imageLoader.cloneBitmap() );
			m_image.smoothing = true;
			
			setSize( getSize() );
		}
		
		override public function setSize( newSize:IntDimension ):void 
		{
			super.setSize( newSize );
			
			if ( m_image )
			{
				m_image.height	= newSize.height;
				m_image.scaleX	= m_image.scaleY;	// アスペクト比維持
				
				m_image.x = - ( m_image.width - m_image.height * ASPECT_RATIO ) / 2
			}
		}
		
		public function get channel():ChannelData { return m_channel; }
		
	}

}