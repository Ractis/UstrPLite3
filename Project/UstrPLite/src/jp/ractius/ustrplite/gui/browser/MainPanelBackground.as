package jp.ractius.ustrplite.gui.browser 
{
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import jp.ractius.ripple.display.BitmapTileSprite;
	import jp.ractius.ripple.RMath;
	import jp.ractius.ripple.utils.SpriteUtil;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class MainPanelBackground extends Sprite 
	{
		[Embed(source = 'assets/TexBg.png')]	static private const TexImg:Class;
		
		public function MainPanelBackground() 
		{
			var grad:Shape = new Shape();
			var g:Graphics = grad.graphics;
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox( 200, 200, RMath.toRad( 90 ) );
			g.beginGradientFill( GradientType.LINEAR,
								 [ 0x333333, 0x111111 ],
								 [ 1, 1 ],
								 [ 0, 255 ],
								 mtx );
			g.drawRect( 0, 0, 200, 200 );
			g.endFill();
			addChild( grad );
			
			var bmp:Bitmap = new TexImg();
			var tile:BitmapTileSprite = new BitmapTileSprite( bmp.bitmapData );
			tile.alpha = 0.2;
			tile.blendMode = BlendMode.SUBTRACT;
			addChild( tile );
		}
		
		override public function set width( w:Number ):void
		{
			SpriteUtil.applyToChildren( this, "width", w );
		}
		
		override public function set height( h:Number ):void
		{
			SpriteUtil.applyToChildren( this, "height", h );
		}
		
	}

}