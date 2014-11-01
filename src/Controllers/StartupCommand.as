package Controllers 
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author Parth
	 */
	public class StartupCommand extends SimpleCommand implements ICommand 
	{
		
		override public function execute(notification:INotification):void 
		{
			//register all proxies
			//facade.registerProxy(new ScoreProxy());
			
			//register splash mediator
			facade.registerMediator(new SplashScreenMediator());
			
		}
		
	}

}