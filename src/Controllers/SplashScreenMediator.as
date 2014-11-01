package Controllers 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import view.DrawingSpace;
	
	/**
	 * ...
	 * @author Parth
	 */
	public class SplashScreenMediator extends Mediator implements IMediator 
	{
		private var drawingSpace:DrawingSpace;
		public static const NAME:String = "SplashScreenMediator";
		
		public function SplashScreenMediator() 
		{
			super(NAME);
		}
		
		override public function onRegister():void
		{		
			drawingSpace = new DrawingSpace();
			AppConstants.stageRef.addChild(drawingSpace);
		}
		override public function onRemove():void
		{
			
		}
		
		override public function listNotificationInterests():Array
		{
			return[];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}		
		
		
		
		
	}

}