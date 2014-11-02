package view {
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	import helper.BPHelper;
	import helper.GamePlayTimer;
	import helper.TouchEventHelper;
	import model.DataProxy;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	
	import view.KNN;
	import flash.geom.Rectangle;


	/**
	 * ...
	 * @author Parth
	 */
	public class DrawingSpace extends Sprite {

		private var lineArray: Array;
		private var previousPoint: Point;
		private var currentPoint: Point;
		private var pointArray: Array;
		private var intervalTimer: Timer;
		private var dataProxy: DataProxy;
		private var writing: Boolean = false;

		private var desiredWidth: Number = 28;
		private var desiredHeight: Number = 28;

		//private var scale:Number = stage.width/desiredWidth;


		public function DrawingSpace() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.x = 0;
			this.y = 0;
		}

		private function onAddedToStage(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.endFill();

			previousPoint = new Point();
			currentPoint = new Point();
			lineArray = new Array();
			pointArray = new Array();

			setProxy();
			addListeners();
			setTimer();

		}

		private function setProxy(): void {
			dataProxy = new DataProxy();
			dataProxy.addEventListener(DataProxy.RECOGNIZED_DIGIT, showDigit);
		}


		private function addListeners(): void {
			TouchEventHelper.addTouchBeginEventListener(this, touchBeginHandler);
		}

		private function touchEndHandler(e: Event): void {
			TouchEventHelper.removeTouchMoveEventListener(this, touchMoveHandler);
			TouchEventHelper.removeTouchEndEventListener(this, touchEndHandler);
			intervalTimer.start();
		}

		private function touchMoveHandler(e: Object): void {
			var point: Point = new Point(this.mouseX, this.mouseY);
			trace(point);
			pointArray.push(point);
			var line: Sprite = BPHelper.getLine(previousPoint, point, 3, 0x000000);
			lineArray.push(line);
			this.addChild(line);

			previousPoint.setTo(this.mouseX, this.mouseY);

		}

		private function touchBeginHandler(e: Object): void {
			if (!writing) {
				writing = true;
				this.removeChildren();
			}
			if (writing) {
				intervalTimer.stop();
				TouchEventHelper.addTouchMoveEventListener(this, touchMoveHandler);
				TouchEventHelper.addTouchEndEventListener(this, touchEndHandler);
				previousPoint.setTo(this.mouseX, this.mouseY);
			}

		}

		private function setTimer(): void {
			intervalTimer = new Timer(2000, 1);
			intervalTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}

		private function onTimerComplete(e: TimerEvent): void {
			writing = false;
			TouchEventHelper.removeTouchBeginEventListener(this, touchBeginHandler);
			var bigBMD: BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
			bigBMD.draw(stage);

			var scaleW: Number = desiredWidth / stage.stageWidth;
			var scaleH: Number = desiredHeight / stage.stageHeight;
			var matrix: Matrix = new Matrix();
			matrix.scale(scaleW, scaleH);

			var smallBMD: BitmapData = new BitmapData(bigBMD.width * scaleW, bigBMD.height * scaleH, true, 0x000000);
			smallBMD.draw(bigBMD, matrix, null, null, null, true);

			var bitmap: Bitmap = new Bitmap(smallBMD, PixelSnapping.NEVER, true);
			
			addChild(bitmap);
			
			var knn:KNN = new KNN(3, 29);
			knn.train("t.csv");
			//dataProxy.toJson(pointArray);
			pointArray = null;
			pointArray = new Array();

		}

		private function removeLines(): void {
			for (var i: uint = 0; i < lineArray.length; i++) {
				this.removeChild(lineArray[i]);
				lineArray[i] = null;
			}
			lineArray = null;
			lineArray = new Array();
			this.alpha = 1;
		}

		private function showDigit(e: DataEvent): void {
			TweenMax.killAll();
			trace("Data >>>", String(e.data));
			var digit: TextField = BPHelper.getTextField(200, 200, String(e.data), 200);
			digit.x = this.width / 2 - digit.width / 2;
			digit.y = this.height / 2 - digit.height / 2;
			digit.alpha = 0;
			this.addChild(digit);
			var timeLine: TimelineLite = new TimelineLite();
			timeLine.append(TweenLite.to(this, 0.3, {
				alpha: 0,
				onComplete: removeLines
			}));
			timeLine.append(TweenLite.to(digit, 0.5, {
				alpha: 1,
				onComplete: addListeners
			}));

			/*TweenLite.to(this, 0.3, { alpha:0 ,onComplete: removeLines} );
			TweenLite.to(digit, 0.5, { alpha:1, onComplete:addListeners } );*/
		}

	}

}