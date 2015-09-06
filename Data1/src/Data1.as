package
{
	import flash.display.Sprite;
	
	public class Data1 extends Sprite
	{
		public function Data1()
		{
			// overall vector sorting is faster then array sorting because of typeing
			var v:Vector.<int> = new <int>[1,2,3,4,5];
			v.sort( randomSort );
			trace(v);
			
			v = new <int>[1,2,3,4,5];
			while (v.length > 0) {
				var r:int = Math.round( Math.random() * (v.length - 1) );
				v.push( v.splice( r, 1 )[0] );
				if (r == 0)
				{
					break;
				}
			}
			trace(v);
			
			// sorry I never heard about bigO Notation
		}
		
		private function randomSort(a:int, b:int):Number
		{
			if (Math.random() < 0.5) return -1;
			else return 1;
		}
	}
}