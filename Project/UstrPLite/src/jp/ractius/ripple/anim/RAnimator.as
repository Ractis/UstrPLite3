package jp.ractius.ripple.anim 
{
	import sweezy.anim.core.Animator;
	import sweezy.anim.core.IPropertyAnimation;
	import sweezy.anim.easing.Cubic;
	/**
	 * ...
	 * @author ractis
	 */
	public class RAnimator 
	{
		
		public function RAnimator() 
		{
			
		}
		
		static public function startFade( tgt:Object, isFadeIn:Boolean, duration:uint = 100, fadeInTo:Number = 1, fadeOutTo:Number = 0, property:String = "alpha" ):void
		{
			if ( isFadeIn )	startFadeIn(  tgt, duration, fadeInTo,  property );
			else			startFadeOut( tgt, duration, fadeOutTo, property );
		}
		
		static public function startFadeIn( tgt:Object, duration:uint = 100, to:Number = 1, property:String = "alpha" ):void
		{
			var anim:IPropertyAnimation = Animator.animate( tgt, duration, Cubic.easeOut );
			anim.to( property, to );
			anim.start();
		}
		
		static public function startFadeOut( tgt:Object, duration:uint = 100, to:Number = 0, property:String = "alpha" ):void
		{
			var anim:IPropertyAnimation = Animator.animate( tgt, duration, Cubic.easeIn );
			anim.to( property, to );
			anim.start();
		}
		
	}

}