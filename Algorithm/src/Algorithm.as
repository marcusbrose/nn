package
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Algorithm extends Sprite
	{
		public static const PADDING:int = 10;
		public static const RADIUS:int = 20;
		public static const COUNT:int = 10;
		
		public var circles:Vector.<Sprite>;
		
		public function Algorithm()
		{
			circles = new Vector.<Sprite>;
			
			var timer:Timer = new Timer( 500, COUNT );
			timer.addEventListener( TimerEvent.TIMER, handleTimer );
			timer.start();
		}
		
		private function handleTimer(event:TimerEvent):void
		{
			var maxWidth:int = stage.stageWidth - 2*RADIUS - 2*PADDING;
			var maxHeight:int = stage.stageHeight - 2*RADIUS - 2*PADDING;
			
			var x:int;
			var y:int;
			var hit:Boolean;
			
			var circle:Sprite = drawCircle();
			do {
				x = Math.round( Math.random() * maxWidth ) + RADIUS + PADDING;
				y = Math.round( Math.random() * maxHeight ) + RADIUS + PADDING;
				hit = checkHit(x,y);
			} while (hit);
			circle.x = x;
			circle.y = y;
			addChild( circle );
			
			circles.push( circle );
		}
		
		private function checkHit(x:int, y:int):Boolean
		{
			if (circles.length < 1)
			{
				return false;
			}
			
			var circle:Sprite;
			var dx:Number;
			var dy:Number;
			var d:Number;
			for (var i:int = 0; i < circles.length; ++i)
			{
				circle = circles[i];
				dx = circle.x - x;
				dy = circle.y - y;
				d = Math.sqrt( Math.pow( dx, 2 ) + Math.pow( dy, 2 ) );
				if (d < 2*RADIUS + 2*PADDING)
				{
					return true;
				}
			}
			return false;
		}
		
		private function drawCircle():Sprite
		{
			var s:Sprite = new Sprite;
			s.graphics.beginFill(0x000000);
			s.graphics.drawCircle( 0, 0, RADIUS );
			return s;
		}
	}
}