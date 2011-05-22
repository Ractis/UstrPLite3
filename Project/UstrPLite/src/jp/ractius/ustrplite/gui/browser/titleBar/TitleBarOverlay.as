package jp.ractius.ustrplite.gui.browser.titleBar 
{
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import jp.ractius.ripple.RMath;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class TitleBarOverlay extends Shape 
	{
		
		public function TitleBarOverlay() 
		{
			var g:Graphics = graphics;
			
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox( 200, TitleBar.HEIGHT, RMath.toRad( 90 ) );
			
			g.beginGradientFill( GradientType.LINEAR,
								 [ 0x444444, 0x000000 ],
								 [ 1, 1 ],
								 [ 0, 255 ],
								 mtx );
			g.drawRect( 0, 0, 200, TitleBar.HEIGHT );
			g.endFill();
			
			alpha = 0.6;
		//	blendMode = BlendMode.OVERLAY;
		}
		
	}

}