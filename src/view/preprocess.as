package view {
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	
	public class preprocess {

		private var CA: Rectangle;
		private var top:Point;
		private var down: Point;
		private var left: Point;
		private var right: Point;
		
		private var bigBMD: BitmapData;
		private var finalBMD : BitmapData;
		
		public function preprocess(points: Array, image: BitmapData){
			
			// constructor code
			bigBMD = image;
		}
		
		public function crop():BitmapData{
			var _CA: Rectangle = bigBMD.getColorBoundsRect(0xFFFFFFFF, 0xFFFFFFFF, false);
			//_CA.inflate((50*_CA.width/ 100), (50*_CA.height/ 100));
			//var CA: Rectangle = new Rectangle(_CA.x-5, _CA.y-5, _CA.width+10, _CA.height+10);
			var test: BitmapData = new BitmapData(_CA.width, _CA.height, true, 0x000000);
			test.copyPixels(bigBMD, /*new Rectangle(500,0,500,500)*/ _CA, new Point(0, 0));
			//trace(test);
			//var drawing: Bitmap = new Bitmap(test, PixelSnapping.NEVER, true);
			var matrix: Matrix = new Matrix();
			
			matrix.scale(30/test.width, 30/test.height);
			var smallBMD: BitmapData = new BitmapData(30, 30, true, 0x000000);
			smallBMD.draw(test, matrix, null, null, null, true);

			finalBMD = smallBMD;
			return finalBMD;
		}
		
		public function getPixelData(): Array{
			var pixels: Array = new Array();
			var total: Number = finalBMD.width*finalBMD.height;
			//trace(total);
			for (var i:Number = 0;i<finalBMD.height;i++){
				for(var j: Number = 0;j<finalBMD.width;j++){
				var rgbVal: Number = finalBMD.getPixel(i, j);

				var redVal: Number = (rgbVal & 0xFF0000) >> 16;
				var greenVal: Number = (rgbVal & 0x00FF00) >> 8;
				var blueVal: Number = rgbVal & 0x0000FF;


				var grayVal: Number = Math.floor(0.3 * redVal + 0.59 * greenVal + 0.11 * blueVal);
				pixels.push(grayVal);
				//trace(grayVal);
				}
			}
			return pixels;
		}
	}
	
}
