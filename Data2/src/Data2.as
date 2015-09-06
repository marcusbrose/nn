package
{
	import flash.display.Sprite;
	
	public class Data2 extends Sprite
	{
		public function Data2()
		{
			var d:Date = new Date;
			// the dates timestamp - 1 day is set to an int variable, but int.MAX_VALUE is 2147483647
			var ts:int = d.time - 24*60*60*1000;
			// datatype Number should be used for a correct calculation
			d.time = ts;
			trace(d);
			// output is a date before 1st Jan 1970
		}
	}
}