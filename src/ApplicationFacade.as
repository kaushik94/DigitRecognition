package  
{
	import Controllers.StartupCommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * ...
	 * @author Parth
	 */
	public class ApplicationFacade extends Facade implements IFacade 
	{
		
		public function ApplicationFacade() 
		{
			super();			
		}
		
		public static function getInstance():ApplicationFacade 
		{
			if (instance == null ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;			
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(AppConstants.STARTUP , StartupCommand);
		}
		
		public function startup(stage:Object):void 
		{			
			sendNotification(AppConstants.STARTUP, stage);			
		}
		
	}

}