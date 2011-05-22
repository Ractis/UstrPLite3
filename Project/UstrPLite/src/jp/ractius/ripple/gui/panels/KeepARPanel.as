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
		
		public function KeepARPanel( layout:LayoutManager = null, aspectRatio:Number = 4 / 3 ) 
		{
			super( layout );
			
			m_aspectRatio = aspectRatio;
		}
		
		override public function setPreferredWidth( preferredWidth:int ):void 
		{
			setPreferredSize( new IntDimension( preferredWidth, preferredWidth / m_aspectRatio ) );
		}
		
		override public function setPreferredHeight( preferredHeight:int ):void 
		{
			setPreferredSize( new IntDimension( preferredHeight * m_aspectRatio, preferredHeight ) );
		}
		
		public function get aspectRatio():Number { return m_aspectRatio; }
		
		public function set aspectRatio(value:Number):void 
		{
			m_aspectRatio = value;
		}
		
	}

}