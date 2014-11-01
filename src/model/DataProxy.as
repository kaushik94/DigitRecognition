package model 
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import view.DrawingSpace;
	/**
	 * ...
	 * @author Parth
	 */
	public class DataProxy extends EventDispatcher
	{
		static public const RECOGNIZED_DIGIT:String = "Recognized_Digit";
		static private var url:String = "http://digit-recog.sidsaquarius.in/"		
		
		
		public function DataProxy() 
		{
			
		}
		
		public static function createXML(array:Array):XML
		{
			var tempXML:XML = <OCR>
								<digit> </digit>
								<points> </points>								
							</OCR>;
							
			
							
			for (var i:uint = 0 ; i < array.length - 1 ; i++)
			{
				var pointXML:XML = <point></point>;
				var obj:Object = new Object();
				//obj.point = array[i].x ;
				pointXML = XML(array[i].x + " " + array[i].y);
				tempXML.points.appendChild(pointXML);
			}			
						
			return tempXML;
			
		}
		
		public function toJson(array:Array):void
		{
			var requestString:String = "";
			var variable:URLVariables = new URLVariables();
			
			for (var i:uint = 0 ; i < array.length ; i++)
			{
				if(i != array.length-1)
					requestString += String(array[i].x) + "," ;
				else
					requestString += String(array[i].x);
			}
			
			variable.x = requestString;
			requestString = "";
			
			for (var j:uint = 0 ; j < array.length ; j++)
			{
				if(j != array.length-1)
					requestString += String(array[j].y) + ",";
				else
					requestString += String(array[j].y);
			}
			variable.y = requestString;			
			
			sendURLRequest(variable);
		}
		
		private function sendURLRequest(variable:URLVariables):void 
		{
			
			var request:URLRequest = new URLRequest(url);				
			request.data = variable;			
			trace("request Data >>",  request.data);
			var loader:URLLoader = new URLLoader(request);			
			loader.addEventListener(Event.COMPLETE, onURLLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			try 
			{ 
				loader.load(request); 
			} 
			catch (error:Error) 
			{ 
				trace("Unable to load URL"); 
			} 
			
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace("Unable to connecct to server"); 
		}
		
		private function onURLLoaded(e:Event):void 
		{
			var data:String = String(e.target.data);			
			var json:Object = JSON.parse(data);
			dispatchEvent(new DataEvent(RECOGNIZED_DIGIT, false, false, String(json.classify)));
			trace("Returned String>>>>>>", Number(json.classify));
		}
		
	}

}