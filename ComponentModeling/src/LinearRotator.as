package
{
	import flash.utils.Dictionary;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LinearRotator extends Sprite
	{
		public static const DIRECTION_VERTICAL:String = 'vertical';
		public static const DIRECTION_HORIZONTAL:String = 'horizontal';
		
		private var numberOfElements:int;
		private var highlightPosition:int;
		private var direction:String;
		
		protected var items:Vector.<Quad>;
		private var offset:int = 10;
		
		public function LinearRotator(numberOfElements:int = 3, highlightPosition:int = 1, direction:String = 'vertical')
		{
			this.numberOfElements = numberOfElements;
			this.highlightPosition = highlightPosition;
			this.direction = direction;
			
			items = new Vector.<Quad>;
			
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
		}
		
		private function handleAddedToStage(event:Event):void
		{
			var item:Quad;
			for (var i:int = 0; i < numberOfElements; ++i)
			{
				item = drawItem(i, i == highlightPosition);
				addChild( item );
				
				items.push( item );
				
				offset = (direction == DIRECTION_VERTICAL) ? offset + 50 : offset + 210;
			}
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private var tweens:Dictionary = new Dictionary;
		
		public function next():void
		{
			trace("next");
			var item:Quad = items.splice(0, 1)[0];
			var tween:Tween = new Tween( item, .5, Transitions.EASE_IN_OUT );
			tween.onComplete = removeItem;
			tween.onCompleteArgs = [item];
			tween.moveTo( getNewX(0), getNewY(0) );
			tween.scaleTo( 1 );
			tween.fadeTo( 0 );
			Starling.juggler.add( tween );
			tweens[item] = tween;
			
			
			item = drawItem(items.length+1, numberOfElements == highlightPosition);
			item.alpha = 0;
			addChild( item );
			items.push( item );
			
			for (var i:int = 0; i < items.length; ++i)
			{
				trace(i, getNewY(i+1));
				item = items[i];
				tween = new Tween( item, .5, Transitions.EASE_IN_OUT);
				tween.onComplete = moveComplete;
				tween.onCompleteArgs = [item];
				tween.moveTo( getNewX(i+1), getNewY(i+1) );
				tween.fadeTo( 1 );
				if (i == highlightPosition-1)
				{
					tween.scaleTo( 1 );
				}
				if (i == highlightPosition)
				{
					tween.scaleTo( 1.2 );
				}
				Starling.juggler.add(tween);
				tweens[item] = tween;
			}
		}
		
		private function moveComplete(item:Quad):void
		{
			tweens[item] = null;
		}
		
		private function removeItem(item:Quad):void
		{
			trace("remove");
			removeChild( item );
			tweens[item] = null;
		}
		
		private function getNewX(index:int):int
		{
			return 200;
		}
		
		
		private function getNewY(index:int):int
		{
			return (direction == DIRECTION_VERTICAL) ? (index-1) * 50 + 50 : index*50 + 50;
			// return (direction == DIRECTION_VERTICAL) ? item.y - item.height - 10 : item.y;
		}
		
		private function drawItem(position:int = 0, scale:Boolean = false):Quad
		{
			var item:Quad = new Quad( 200, 40, 0x000000 );
			item.pivotX = 100;
			item.pivotY = 20;
			if (scale)
			{
				item.scaleX = 1.2;
				item.scaleY = 1.2;
			}
			if (direction == DIRECTION_VERTICAL)
			{
				item.x = 200;
				item.y = position * 50 + 50;
			}
			else
			{
				item.x = position * 210 + 50;
				item.y = 200;
			}
			return item;
		}
	}
}