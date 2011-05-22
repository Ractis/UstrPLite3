package jp.ractius.ripple.display 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	/**
	 * ...
	 * @author ractis
	 */
	public class RoundRectShape extends Shape 
	{
		private var m_cornerSize:Number;
		private var m_color:uint;
		
		public function RoundRectShape( cornerRadius:Number, color:uint = 0x000000 ) 
		{
			m_cornerSize	= cornerRadius * 2;
			m_color			= color;
		}
		
		public function setSize( w:Number, h:Number ):void
		{
			var g:Graphics = graphics;
			g.clear();
			g.beginFill( m_color );
			g.drawRoundRect( 0, 0, w, h, m_cornerSize, m_cornerSize );
			g.endFill();
		}
		
		override public function set width( w:Number ):void
		{
			setSize( w, height );
		}
		
		override public function set height( h:Number ):void
		{
			setSize( width, h );
		}
		
	}

}