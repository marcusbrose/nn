package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Scene extends Sprite
	{
		private var linearRotator:LinearRotator;
		
		public function Scene()
		{
			linearRotator = new LinearRotator(4, 2);
			linearRotator.addEventListener( Event.COMPLETE, handleComplete );
			addChild( linearRotator );
		}
		
		private function handleComplete(event:Event):void
		{
			var timer:Timer = new Timer( 800, 10 );
			timer.addEventListener( TimerEvent.TIMER, handleTimer );
			timer.start();
		}
		
		private function handleTimer(event:TimerEvent):void
		{
			linearRotator.next();
		}
	}
}