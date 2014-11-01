package helper 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import view.DrawingSpace;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TouchEventHelper 
	{
		private static var callbackFunc:Function; 
		public function TouchEventHelper() 
		{
			
		}
		
		public static function addTouchEventListener(mc:Object,callback:Function,handlerflag:Boolean=false,clickFlag:Boolean=true):void
		{
			
			(mc as MovieClip).mouseChildren = false;
			if (handlerflag)
			{
				callbackFunc = callback;
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.CLICK, handler);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_END, handler);
				}
			}
			else
			{
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.CLICK, callback);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_END, callback);
				}
				
			}
		}	
		
		public static function addTouchBeginEventListener(mc:Object,callback:Function,handlerflag:Boolean=false,clickFlag:Boolean=true):void
		{
			if (handlerflag)
			{
				callbackFunc = callback;
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.MOUSE_DOWN, handler);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_BEGIN, handler);
				}
			}
			else
			{
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.MOUSE_DOWN, callback);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_BEGIN, callback);
				}
				
			}
		}	
		
		public static function addTouchOutEventListener(mc:Object,callback:Function,handlerflag:Boolean=false,clickFlag:Boolean=true):void
		{
			if (handlerflag)
			{
				callbackFunc = callback;
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.ROLL_OUT, handler);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_ROLL_OUT, handler);
				}
			}
			else
			{
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.ROLL_OUT, callback);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_ROLL_OUT, callback);
				}
				
			}
		}	
		
		public static function addTouchEndEventListener(mc:Object,callback:Function,handlerflag:Boolean=false,clickFlag:Boolean=true):void
		{
			if (handlerflag)
			{
				callbackFunc = callback;
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.MOUSE_UP, handler);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_END, handler);
				}
			}
			else
			{
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.MOUSE_UP, callback);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_END, callback);
				}				
			}
		}	
		
		public static function removeTouchEndEventListener(mc:Object,callback:Function,clickFlag:Boolean=true):void
		{
			
				if (clickFlag)
				{
					mc.removeEventListener(MouseEvent.MOUSE_UP, callback);
					
				}
				else
				{
					mc.removeEventListener(TouchEvent.TOUCH_END, callback);
				}				
			
		}	
		
		public static function removeTouchOutEventListener(mc:Object,callback:Function,clickFlag:Boolean=true):void
		{
			
				if (clickFlag)
				{
					mc.removeEventListener(MouseEvent.ROLL_OUT, callback);
					
				}
				else
				{
					mc.removeEventListener(TouchEvent.TOUCH_ROLL_OUT, callback);
				}
				
		}	
		
		static private function handler(e:Object):void 
		{
			callbackFunc();
		}
		
		public static function removeTouchBeginEventListener(mc:Object,callback:Function,clickFlag:Boolean=true):void
		{
			if (clickFlag)
			{
				mc.removeEventListener(MouseEvent.MOUSE_DOWN,callback);
			}
			else
			{
				mc.removeEventListener(TouchEvent.TOUCH_BEGIN,callback);		
			}
		}
		
		public static function removeEventListener(mc:Object,callback:Function,clickFlag:Boolean=true):void
		{
			if (clickFlag)
			{
				mc.removeEventListener(MouseEvent.CLICK,callback);		
			}
			else
			{
				mc.removeEventListener(TouchEvent.TOUCH_END,callback);		
			}
		}
		
		public static function addEnterFrameListener(mc:Object, callback:Function):void
		{		
			mc.addEventListener(Event.ENTER_FRAME, callback);	
		}
		
		public static function removeEnterFrameListener(mc:Object, callback:Function):void
		{
			mc.removeEventListener(Event.ENTER_FRAME, callback);
		}
		
		public static function addTouchMoveEventListener(mc:Object,callback:Function,handlerflag:Boolean=false,clickFlag:Boolean=true):void
		{
			if (handlerflag)
			{
				callbackFunc = callback;
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.MOUSE_MOVE, handler);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_MOVE, handler);
				}
			}
			else
			{
				if (clickFlag)
				{
					mc.addEventListener(MouseEvent.MOUSE_MOVE, callback);
					
				}
				else
				{
					mc.addEventListener(TouchEvent.TOUCH_MOVE, callback);
				}
				
			}
		}	
		
		public static function removeTouchMoveEventListener(mc:Object,callback:Function,clickFlag:Boolean=true):void
		{
			if (clickFlag)
			{
				mc.removeEventListener(MouseEvent.MOUSE_MOVE,callback);
			}
			else
			{
				mc.removeEventListener(TouchEvent.TOUCH_MOVE,callback);		
			}
		}
		
		
	}

}