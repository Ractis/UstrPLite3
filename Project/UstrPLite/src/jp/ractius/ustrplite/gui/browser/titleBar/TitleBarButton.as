package jp.ractius.ustrplite.gui.browser.titleBar 
{
	import flash.display.DisplayObject;
	import jp.ractius.ripple.anim.RAnimator;
	import jp.ractius.ripple.gui.buttons.RBitmapButton;
	import jp.ractius.ripple.gui.buttons.RButtonModel;
	import org.aswing.geom.IntDimension;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class TitleBarButton extends RBitmapButton 
	{
		[Embed(source = 'assets/Button_Base.png')]				static private const BtnBaseImg:Class;
		[Embed(source = 'assets/Button_Overlay.png')]			static private const BtnOverlayImg:Class;
		[Embed(source = 'assets/Button_Min_Base.png')]			static private const BtnMinBaseImg:Class;
		[Embed(source = 'assets/Button_Min_RollOver.png')]		static private const BtnMinOverImg:Class;
		[Embed(source = 'assets/Button_Close_Base.png')]		static private const BtnCloseBaseImg:Class;
		[Embed(source = 'assets/Button_Close_RollOver.png')]	static private const BtnCloseOverImg:Class;
		
		static public const BUTTON_MINIMIZE:String	= "btnMinimize";
		static public const BUTTON_CLOSE:String		= "btnClose";
		
		private var m_rollOver:DisplayObject;
		
		public function TitleBarButton( btnType:String ) 
		{
			var toolTip:String;
			var base:DisplayObject;
			var rollOver:DisplayObject;
			
			switch ( btnType )
			{
			case BUTTON_MINIMIZE:
				toolTip		= "general.minimize";
				base		= new BtnMinBaseImg();
				rollOver	= new BtnMinOverImg();
				addActionListener( _onMinimize );
				break;
				
			case BUTTON_CLOSE:
				toolTip		= "general.exit";
				base		= new BtnCloseBaseImg();
				rollOver	= new BtnCloseOverImg();
				addActionListener( _onClose );
				break;
			}
			
			super( toolTip );
			setPreferredSize( new IntDimension( 23, 26 ) );
			setClipMasked( false );
			
			addChild( new BtnBaseImg() );
			addChild( base );
			addChild( rollOver );
			addChild( new BtnOverlayImg() );
			
			rollOver.alpha = 0;
			m_rollOver = rollOver;
		}
		
		private function _onMinimize( ...e ):void 
		{
			stage.nativeWindow.minimize();
		}
		
		private function _onClose( ...e ):void
		{
			stage.nativeWindow.close();
		}
		
		override protected function onState( type:String, isActive:Boolean ):void 
		{
			switch ( type )
			{
			case RButtonModel.STATE_ROLL_OVER:
				RAnimator.startFade( m_rollOver, isActive );
				break;
			}
		}
		
	}

}