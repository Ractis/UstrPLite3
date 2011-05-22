package jp.ractius.ripple.display 
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import jp.ractius.ripple.RMath;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class DirectionalShadowShape extends Shape 
	{
		
		public function DirectionalShadowShape( rotation:Number, width:Number, alpha:Number = 0.75 ) 
		{
			var g:Graphics = graphics;
			
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox( 200, width, RMath.toRad( 90 ) );
			
			g.beginGradientFill( GradientType.LINEAR,
								 [ 0,   0,   0,   0,   0 ],
								 [ 0.8,	0.6, 0.4, 0.2, 0 ],
								 [ 0,   32,  64,  128, 255 ],
								 mtx );
			g.drawRect( 0, 0, 200, width );
			g.endFill();
			
			this.rotation = rotation;
			this.alpha = alpha;
		}
		
	}

}