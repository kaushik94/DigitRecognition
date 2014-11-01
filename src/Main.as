package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Security;
	
	
	/**
	 * ...
	 * @author Parth
	 */
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends MovieClip 
	{
		private var allowDomainURL:String = " http://digit-recog.sidsaquarius.in/" ;
		private var policyFileURL:String = " http://digit-recog.sidsaquarius.in/crossdomain.xml";
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			setSecurityConfig(allowDomainURL, policyFileURL);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;;
			AppConstants.stageRef = this;
			AppConstants.stage = this.stage;
			// entry point		
			startGame();
		}
		
		private function startGame():void 
		{
			ApplicationFacade.getInstance().startup(AppConstants.stageRef);
		}
		
		public function setSecurityConfig(_allowDomainURL:String,_policyFileUrl:String):void {
			allowDomainURL = _allowDomainURL;
			policyFileURL = _policyFileUrl;
			try {
				Security.allowDomain("*");
				Security.allowInsecureDomain("*");
				Security.allowDomain(allowDomainURL);
				Security.loadPolicyFile(policyFileURL);
				trace("SandBoxType >>",Security.sandboxType);
			}catch(e:Error){}
			
		}
		
		
		
	}
	
}