package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;

	[SWF(width="400", height="400", frameRate="60", backgroundColor="#ffffff")]
	public class ComponentModeling extends Sprite
	{
		private var starling:Starling;
		
		public function ComponentModeling()
		{
			starling = new Starling(Scene, stage);
			starling.start();
		}
	}
}