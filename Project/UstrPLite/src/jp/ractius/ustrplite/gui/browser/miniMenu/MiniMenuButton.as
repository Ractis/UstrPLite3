package jp.ractius.ustrplite.gui.browser.miniMenu 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import jp.ractius.ripple.anim.RAnimator;
	import jp.ractius.ripple.gui.buttons.RButton;
	import jp.ractius.ripple.gui.buttons.RButtonModel;
	import jp.ractius.ustrplite.browser.Browser;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class MiniMenuButton extends RButton 
	{
		[Embed(source = 'assets/MiniMenu.png')]				static private const BaseImg:Class;
		[Embed(source = 'assets/MiniMenu_RollOver.png')]	static private const RollOverImg:Class;
		[Embed(source = 'assets/MiniMenu_Press.png')]		static private const PressImg:Class;
		
		private var m_rollOver:DisplayObject;
		private var m_press:DisplayObject;
		
		public function MiniMenuButton() 
		{
			super( "", "general.showMenu" );
			setPreferredSize( new IntDimension( 28, 16 ) );
			
			addChild( new BaseImg() );
			addChild( m_rollOver = new RollOverImg() );
			addChild( m_press = new PressImg() );
			
			m_rollOver.alpha	= 0;
			m_press.alpha		= 0;
			
			addEventListener( MouseEvent.CLICK, _onClick );
		}
		
		private function _onClick( e:MouseEvent ):void 
		{
			Browser.inst.showMenu( e.stageX, e.stageY );
		}
		
		override protected function paint( b:IntRectangle ):void 
		{
		//	super.paint(b);
		}
		
		override protected function onState( type:String, isActive:Boolean ):void 
		{
			switch ( type )
			{
			case RButtonModel.STATE_ROLL_OVER:
				RAnimator.startFade( m_rollOver, isActive );
			//	if ( model.isPress ) RAnimator.startFade( m_press, isActive );
				break;
				
			case RButtonModel.STATE_PRESS:
				RAnimator.startFade( m_press, isActive );
				break;
			}
		}
		
	}

}