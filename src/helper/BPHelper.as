package helper 
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Circ;
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.engine.BreakOpportunity;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;	
	import flash.text.TextField;	
	import flash.utils.describeType;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BPHelper 
	{
		static private var timeline1:TimelineLite;
		static private var callBackFunc:Function;		
		static private var tintMC:MovieClip;
		static private var objectiveTxt1:TextField;
		static private var callBackFunction:Function;
		static private var popCallBack:Function;		
		
		public function BPHelper() 
		{
			
		}
		
		public static function remove(mc:MovieClip,parent:Object=null):void
		{
			if (!parent)
			{
				parent = AppConstants.stageRef;	
			}
			if (mc && parent.contains(mc))
			{
				parent.removeChild(mc);
				mc = null;
			}
			
			
			
		}
		
		public static  function removeAll():void 
		{			
			while (AppConstants.stageRef.numChildren)
				{
					AppConstants.stageRef.removeChildAt(0);	
				}
		}		
		
		public static function removeElementByName(arr:Array,obj:Object):Array
		{
			var newArr:Array = new Array();
			var j:Number = 0;
			for ( var i:Number = 0; i < arr.length; i++ )
			{
				if (arr[i] != obj)
				{
					newArr[j] = arr[i];
					j++;
				}
			}
			
			return newArr;
		}
		
		public static function scaleUp(mc:Object,toscaleX:Number=1.1,toscaleY:Number=1.1,time:Number=0.3,fromscaleX:Number=1,fromscaleY:Number=1,callBack:Function=null, _alpha:Number = 1):void
		{
			timeline1= new TimelineLite({onComplete:callBack});
			timeline1.append( TweenMax.fromTo(mc, time, { scaleX:fromscaleX,scaleY:fromscaleY,alpha: 0 }, {scaleX:toscaleX,scaleY:toscaleY,alpha:_alpha,ease:Back.easeOut } ));
		}
		
		public static function scaleDwn(mc:Object,toscaleX:Number=0.9,toscaleY:Number=0.9,time:Number=0.3,fromscaleX:Number=1,fromscaleY:Number=1,callBack:Function=null, _alpha:Number = 1):void
		{
			timeline1= new TimelineLite({onComplete:callBack});
			timeline1.append( TweenMax.fromTo(mc, time, { scaleX:fromscaleX,scaleY:fromscaleY,alpha: 0 }, { scaleX:toscaleX,scaleY:toscaleY,alpha:_alpha,ease:Back.easeOut } ));			
		}
		
		public static function scaleUpDwn(mc:Object,toscaleX:Number=1.2,toscaleY:Number=1.2,uptime:Number=0.3,dwntime:Number=0.3,stabletime:Number=0,fromscaleX:Number=1,fromscaleY:Number=1,callBack:Function=null):void
		{
			timeline1= new TimelineLite({onComplete:callBack});
			timeline1.append( TweenMax.fromTo(mc, uptime, { scaleX:fromscaleX,scaleY:fromscaleY }, {scaleX:toscaleX,scaleY:toscaleY,ease:Back.easeOut } ));
			timeline1.append( TweenMax.fromTo(mc, stabletime, { scaleX:toscaleX,scaleY:toscaleY }, {scaleX:toscaleX,scaleY:toscaleY,ease:Back.easeOut } ));
			timeline1.append( TweenMax.fromTo(mc, dwntime, { scaleX:toscaleX,scaleY:toscaleY }, {scaleX:fromscaleX,scaleY:fromscaleY,ease:Back.easeOut } ));
			
		}
		
		
		public static function changeColor(mc:Object,color:String="0x33cc33"):void
		{
			var timeline1:TimelineLite= new TimelineLite();
			timeline1.append(TweenMax.to(mc,0.1, {colorTransform:{tint:color, tintAmount:1},scaleX:1.15,scaleY:1.15}));		
			timeline1.append(TweenMax.to(mc, 0.4, {colorTransform:{tint:color, tintAmount:1},scaleX:1,scaleY:1}));		
			timeline1.append(TweenMax.to(mc, 0.1, {colorTransform:{tint:color, tintAmount:0},scaleX:1,scaleY:1}));		
			
		}
		
		
		
		public static function insertElement(arr:Array,index:Number,value:Object):Array
		{
			var original:Array = arr.slice(); // a, c, d
			var temp:Array = original.splice(index); // c, d
			original[index] = value; // b
			original = original.concat(temp); // a, b, c, d
			return original;
		}
		
		public static function removeElement(arr:Array,index:Number):Array
		{
			var original:Array = arr.slice(); // a, b, c, d
			var temp:Array = original.splice(index); // b, c, d
			temp.shift(); // c, d
			original = original.concat(temp); // a, c, d
			return original;
		}
		
		public static function flashTxtReScale(textField:TextField,parentMC:MovieClip):void
		{
			while(textField.textWidth > (parentMC.width - 10))
			{
				textField.scaleX = textField.scaleX - 0.01;
				textField.scaleY = textField.scaleY - 0.01;
				
			}
		}
		
		public static function addFlashEentListener(mc:MovieClip,event:String,callBack:Function):void
		{
			mc.addEventListener(event, callBack);
		}
		
		public static function getTextField(width:Number,height:Number,text:String,size:Number=50,_font:String=""):TextField
		{
			var txtField:TextField = new TextField();
			txtField.width = width;
			txtField.height = height;
			txtField.text = text;
			
			
			var format:TextFormat = new TextFormat();
			format.align = "center";
			format.size = size;
			//format.font = _font;
			format.bold = false;
			format.color = "0x000000";
			//txtField.embedFonts = true;
			txtField.setTextFormat(format);
			txtField.selectable = false;
			return txtField;
		}
		
		public static function getLine(fromPoint:Point, toPoint:Point,lineWeight:Number=1,lineColor:uint=0xffffff):Sprite
		{
				var lineCanvas:Sprite = new Sprite();
				var lineColor:uint = lineColor;
				var lineWeight:Number = lineWeight;
				lineCanvas.graphics.lineStyle(lineWeight,lineColor);
				lineCanvas.graphics.moveTo(fromPoint.x,fromPoint.y);
				lineCanvas.graphics.lineTo(toPoint.x,toPoint.y);
				
				
				return lineCanvas;
		}
		
		public static function getRect(point:Point,width:Number,height:Number,color:uint=0xffffff):Sprite
		{
			var circleSp:Sprite = new Sprite();
			circleSp.graphics.beginFill(color);
			//circleSp.graphics.drawRect(point.x, point.y, 7, 7);
			circleSp.graphics.drawRoundRect(point.x,point.y,width,height,15,15);
			circleSp.graphics.endFill();	
			return circleSp;
		}
		
		public static function methodExists(obj:Object,name:String):Boolean
		{
				var desc:XML=flash.utils.describeType(obj);
				return (desc.method.(@name==name).length()>0);
		}
		
		public static function isInteger(str:String):Boolean
		{
			var ret:Boolean = true;
			if (str.indexOf(".") != -1 || str.indexOf("/") != -1)
			{
				ret = false;	
			}
			
			return ret;
		}
		
		public static function getCurDate():String
		{
			var date:Date = new Date();		
			var st:String = date.date + "-" + Number(date.month +1) + "-" + date.fullYear;
			return st;
		}
		
		/*public static function ExitGame(e:Object=null):void 
		{
			AppConstants.menuSoundFlag = true;
			BPHelper.removeAll();
			MenuSound.clear();
			BGSound.clear();
			Assets.disposeAllTextures();
			starHelper.removeAll();
			StarHandler.mStarling.removeEventListeners();
			StarHandler.mStarling.dispose();
			
			ApplicationFacade.getInstance().removeProxy(ProgressProxy.NAME);
			ApplicationFacade.getInstance().removeProxy(LevelProxy.NAME);
			ApplicationFacade.getInstance().removeMediator(SplashScreenMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(GameScreenMediator.NAME);
			ApplicationFacade.getInstance().removeMediator(ScoreScreenMediator.NAME);
			
			AppConstants.stage.dispatchEvent(new Event("onComplete"));
		}*/
	}

}