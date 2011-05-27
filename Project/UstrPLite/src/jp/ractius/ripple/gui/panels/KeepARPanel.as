package jp.ractius.ripple.gui.panels 
{
	import org.aswing.geom.IntDimension;
	import org.aswing.JPanel;
	import org.aswing.LayoutManager;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class KeepARPanel extends JPanel 
	{
		private var m_aspectRatio:Number;
		private var m_offsetW:Number;
		private var m_offsetH:Number;
		
		public function KeepARPanel( layout:LayoutManager = null, aspectRatio:Number = 4 / 3, offsetW:Number = 0, offsetH:Number = 0 ) 
		{
			super( layout );
			
			m_aspectRatio	= aspectRatio;
			m_offsetW		= offsetW;
			m_offsetH		= offsetH;
		}
		
		override public function setPreferredWidth( preferredWidth:int ):void 
		{
			setPreferredSize( new IntDimension( preferredWidth,
												Math.round( ( preferredWidth - m_offsetW ) / m_aspectRatio + m_offsetH ) ) );
		}
		
		override public function setPreferredHeight( preferredHeight:int ):void 
		{
			setPreferredSize( new IntDimension( Math.round( ( preferredHeight - m_offsetH ) * m_aspectRatio + m_offsetW ),
												preferredHeight ) );
		}
		
		public function get aspectRatio():Number { return m_aspectRatio; }
		
		public function set aspectRatio(value:Number):void 
		{
			m_aspectRatio = value;
		}
		
		public function get offsetW():Number { return m_offsetW; }
		
		public function set offsetW(value:Number):void 
		{
			m_offsetW = value;
		}
		
		public function get offsetH():Number { return m_offsetH; }
		
		public function set offsetH(value:Number):void 
		{
			m_offsetH = value;
		}
		
	}

}