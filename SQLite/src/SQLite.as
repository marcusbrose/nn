package
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.display.Sprite;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	public class SQLite extends Sprite
	{
		protected var connection:SQLConnection;
		
		public function SQLite()
		{
			var file:File = File.applicationDirectory.resolvePath('NeuroNationDB.db');
			
			connection = new SQLConnection;
			connection.addEventListener( SQLErrorEvent.ERROR, handleSqlError );
			connection.addEventListener( SQLEvent.OPEN, handleSqlOpen );
			connection.openAsync( file );
		}
		
		protected function handleSqlOpen(event:SQLEvent):void
		{
			exerciseNames();
			scores();
			highscore();
		}
		
		private function exerciseNames():void
		{
			var stmt:SQLStatement = new SQLStatement;
			stmt.sqlConnection = connection;
			stmt.text = "SELECT settings.exercise_name " +
				"FROM progress " +
				"LEFT JOIN settings ON progress.exercise_id = settings.exercise_id " +
				"WHERE progress.user_id = 842074 " +
				"GROUP BY settings.exercise_name";
			stmt.addEventListener( SQLErrorEvent.ERROR, handleSqlError );
			stmt.addEventListener( SQLEvent.RESULT, handleExerciseNamesResult );
			stmt.execute();
		}
		
		private function handleExerciseNamesResult(event:SQLEvent):void
		{
			var stmt:SQLStatement = SQLStatement( event.currentTarget );
			var results:SQLResult = stmt.getResult();
			trace();
			for each (var result:Object in results.data)
			{
				trace(result.exercise_name);
			}
		}
		
		private function scores():void
		{
			var stmt:SQLStatement = new SQLStatement;
			stmt.sqlConnection = connection;
			stmt.text = "SELECT settings.exercise_name, settings.exercise_id, progress.score " +
				"FROM progress " +
				"LEFT JOIN settings ON progress.exercise_id = settings.exercise_id " +
				"WHERE progress.user_id = 842074";
			stmt.addEventListener( SQLErrorEvent.ERROR, handleSqlError );
			stmt.addEventListener( SQLEvent.RESULT, handleScoresResult );
			stmt.execute();
		}
		
		private function handleScoresResult(event:SQLEvent):void
		{
			var stmt:SQLStatement = SQLStatement( event.currentTarget );
			var results:SQLResult = stmt.getResult();
			trace();
			for each (var result:Object in results.data)
			{
				trace(result.exercise_name,'\t',result.exercise_id,'\t',result.score);
			}
		}
		
		private function highscore():void
		{
			var stmt:SQLStatement = new SQLStatement;
			stmt.sqlConnection = connection;
			stmt.text = "SELECT settings.exercise_name, " +
				"(SELECT MAX(score) FROM progress WHERE progress.exercise_id = settings.exercise_id) AS highscore " +
				"FROM progress " +
				"LEFT JOIN settings ON progress.exercise_id = settings.exercise_id " +
				"WHERE progress.user_id = 842074 " +
				"GROUP BY settings.exercise_name ";
			trace(stmt.text);
			stmt.addEventListener( SQLErrorEvent.ERROR, handleSqlError );
			stmt.addEventListener( SQLEvent.RESULT, handleHighscoreResult );
			stmt.execute();
		}
		
		private function handleHighscoreResult(event:SQLEvent):void
		{
			var stmt:SQLStatement = SQLStatement( event.currentTarget );
			var results:SQLResult = stmt.getResult();
			trace();
			for each (var result:Object in results.data)
			{
				trace(result.exercise_name,'\t',result.highscore);
			}
		}
		
		private function handleSqlError(event:SQLErrorEvent):void
		{
			trace(event);
		}
	}
}