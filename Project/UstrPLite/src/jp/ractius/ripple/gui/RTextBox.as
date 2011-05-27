package jp.ractius.ripple.gui 
{
	import flash.events.FocusEvent;
	import flash.filters.BlurFilter;
	import jp.ractius.ripple.anim.RAnimator;
	import org.aswing.ASColor;
	import org.aswing.EmptyLayout;
	import org.aswing.geom.IntDimension;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class RTextBox extends JPanel 
	{
		private var m_height:int = 22;
		
		private var m_mainTf:JTextField;
		private var m_backTf:JTextField;
		
		private var m_backTfBlurFx:BlurFilter;
		
		public function RTextBox( defaultText:String = "" ) 
		{
			super( new EmptyLayout() );
			
			setName( "RTextBox" );
			setPreferredHeight( m_height );
			
			append( m_mainTf = new JTextField() );
			append( m_backTf = new JTextField( defaultText ) );
			
			m_backTf.setEnabled( false );
			m_backTf.setBackground( new ASColor( 0, 0 ) );
			m_backTf.setForeground( new ASColor( 0, 0.35 ) );
			m_backTf.mouseEnabled = false;
			
			m_backTfBlurFx = new BlurFilter( 0, 0, 1 );
			m_backTf.filters = [ m_backTfBlurFx ];
			
			m_mainTf.addEventListener( FocusEvent.FOCUS_IN, _onFocusIn );
			m_mainTf.addEventListener( FocusEvent.FOCUS_OUT, _onFocusOut );
		}
		
		public function get backTfBlur():Number { return m_backTfBlurFx.blurX; }
		
		public function set backTfBlur( blur:Number ):void
		{
			m_backTfBlurFx.blurX = blur;
			m_backTfBlurFx.blurY = blur;
		}
		
		private function _onFocusOut( e:FocusEvent ):void 
		{
			if ( m_mainTf.getText().length == 0 )
			{
				RAnimator.startFadeIn( m_backTf, 200 );
				backTfBlur = 0;
			}
		}
		
		private function _onFocusIn( e:FocusEvent ):void 
		{
			RAnimator.startFadeOut( m_backTf, 150 );
			RAnimator.startFadeOut( this, 150, 10, "backTfBlur" );
		}
		
		public function getTextAndClear():String
		{
			return GuiUtil.getTextAndClear( m_mainTf );
		}
		
		override public function setSize( newSize:IntDimension ):void 
		{
			super.setSize( newSize );
			
			GuiUtil.applyIntDim( newSize, m_mainTf );
			GuiUtil.applyIntDim( newSize, m_backTf );
		}
		
		public function get mainTf():JTextField { return m_mainTf; }
		
	}

}