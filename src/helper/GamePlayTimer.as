package helper 
{
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import jellybean.GameConstants;
	/**
	 * ...
	 * @author ...
	 */
	public class GamePlayTimer 
	{
		public static var time:Number=0;
		public static var gameTimer:Timer;
		
		
		public static function startTimer():void
		{
			time = 0;
			if (!gameTimer)
			{
				gameTimer = new Timer(3000,1);
				gameTimer.addEventListener(TimerEvent.TIMER, onTimerChange);				
			}
			else
			{
				gameTimer.reset();
			}
			
			gameTimer.start();
		
		}
		
		private static function onTimerChange(e:TimerEvent):void 
		{
			time++;
		}
		
		public static function pauseTimer():void
		{
			gameTimer.stop();	
		}
		
		public static function resumeTimer():void
		{
			gameTimer.start();	
		}
		
		public static function resetTimer():void
		{
			startTimer();
		}
	}

}