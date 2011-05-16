package jp.ractius.ustrplite
{
	import flash.display.Sprite;
	import jp.ractius.ripple.air.WindowBounds;
	import jp.ractius.ripple.air.WindowMoveController;
	import jp.ractius.ustrplite.data.channel.ChannelData;
	import jp.ractius.ustrplite.data.channel.ChannelStore;
	import jp.ractius.ustrplite.player.PlayerWindow;
	import jp.ractius.ustrplite.services.IChannelUri;
	import jp.ractius.ustrplite.services.IService;
	import jp.ractius.ustrplite.services.Services;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.JTextField;
	
	/**
	 * ...
	 * @author ractis
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			Services.initialize();
			
			var bg:Sprite = new Sprite;
			bg.graphics.beginFill( 0xCCCCCC );
			bg.graphics.drawRect( 0, 0, 200, 50 );
			bg.graphics.endFill();
			addChild( bg );
			
			var ctrl:WindowMoveController = new WindowMoveController( bg, new WindowBounds( stage ) );
			
			var tf:JTextField = new JTextField();
			tf.setSize( new IntDimension( 180, 24 ) );
			tf.x = 10;
			tf.y = 13;
			tf.validate();
			addChild( tf );
			
			tf.addActionListener( _onActTf );
		}
		
		private function _onActTf( e:AWEvent ):void 
		{
			var tf:JTextField = JTextField( e.target );
			
			var url:String = tf.getText();
			tf.setText( "" );
			
			var uri:IChannelUri;
			Services.forEach( function( service:IService ):Boolean
			{
				uri = service.createChannelUri();
				
				if ( uri.test( url ) )	return false;	// サービスが見つかった
				else					return true;	// 見つからないので続行
			} );
			
			if ( !uri.channelName ) return;	// 見つからなかった
			
			var channel:ChannelData = ChannelStore.inst.getChannel( uri.serviceName, uri.channelName );
			
			new PlayerWindow( channel );
		}
		
	}
	
}