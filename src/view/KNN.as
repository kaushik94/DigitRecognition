package  view {
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.net.*;
	import flash.events.*;
	import flash.filesystem.File;

	public class KNN {

		private var K: Number;
		private var numPixels: Number;
		private var training_data: Array;
		
		var myRequest:URLRequest;
		var loadedData:Array;
		var myLoader:URLLoader;
		

		public function KNN(_k:Number, _num: Number) {
			
			K = _k;
			numPixels = _num;
			//train("t.csv");
			// constructor code
		}
		
		private function find_knn(){
			var min: Number = int.MAX_VALUE;
			var best: Number = 0;
			//trace(loadedData[loadedData.length-2]);
			for(var i: Number = 1;i< loadedData.length-1; i++){
				var distance: Number = distance(loadedData[i], loadedData[loadedData.length-1]);
				if(distance < min){
					min = distance;
					best = loadedData[i][0];
				}
			}
			trace("Actual");
			trace(loadedData[loadedData.length-1]);
			trace("predicted");
			trace(best);
		}
		
		public function train(string: String): void{
			read_csv();
			//normalise(loadedData);
		}
		
		private function getMedian(temp: Array): Number{
			var data: Array = new Array();
			data = temp.concat();
			data.sort(Array.NUMERIC);
			if (data.length%2 == 1){
				return data[int(((data.length + 1) / 2.0) -  1)];
			}
			else{
				return (data[int((data.length/2))]+data[int((data.length/2)-1)])/2.0;
			}
		}
		
		private function getAbsoluteStandardDeviation(data: Array, median: Number): Number{
			var sum:Number = 0;
			for(var i: Number = 1; i< data.length; i++){
				sum += Math.abs(data[i] - median);
				//trace(sum);
			}
			//trace(sum/data.length);
			return sum/data.length;
		}
		
		public function normalise(): void{
			for(var i: Number = 1;i< loadedData.length; i++){
				var median: Number = getMedian(loadedData[i]);
				//trace(median);
				var asd: Number = getAbsoluteStandardDeviation(loadedData[i], median);
				//trace(data[i]);
				//trace(median);
				//trace(asd);
				for(var j: Number=1;j< loadedData[i].length;j++){
					var foo: Number = Math.abs(loadedData[i][j]-median)/ asd;
					//trace(foo);
					if(foo >= 0.5)
						loadedData[i][j] = 1;
					else
						loadedData[i][j] = 0;
				}
			}
			//trace(loadedData.length);
			find_knn();
			//trace(loadedData[1].sort(Array.NUMERIC));
			//trace(loadedData[1][0] is int);
		}

		private function distance(PixelDataA: Array, PixelDataB: Array): Number{
			
			var distance:Number = 0;
			for(var i: Number = 1; i< PixelDataA.length-1; i++){
				distance += Math.pow((PixelDataA[i] - PixelDataB[i]), 2);
			}
			return distance;
		}
		
		public function read_csv(): void{
			var csvFile:File=new File(File.applicationDirectory.nativePath).resolvePath("t.csv");
			myRequest = new URLRequest(csvFile.url);
			myLoader = new URLLoader();
			myLoader.dataFormat = URLLoaderDataFormat.TEXT;
			myLoader.addEventListener(IOErrorEvent.IO_ERROR, onSoundIOError, false, 0, true);
			myLoader.addEventListener(Event.COMPLETE, onload);
			myLoader.load(myRequest);
		}
		
		function onload(e:Event):void{
			//trace(myLoader.data);
			loadedData = new Array();
			loadedData = String(e.currentTarget.data).split(/\r\n|\n|\r/);
			//trace(loadedData);
			for (var i:int=1; i<loadedData.length; i++){
				loadedData[i] = loadedData[i].split(",");
				//trace(int(loadedData[i][0]));
				for(var j: int = 0; j<loadedData[i].length; j++){
					loadedData[i][j] = int(loadedData[i][j]);
					//trace(loadedData[i]);
				}
			}
			//trace(loadedData[loadedData.length-2][0]);
			normalise();
			//trace(distance(loadedData[1], loadedData[2]));
		}

function onSoundIOError (e:IOErrorEvent)
{
trace("An Error Occured and it looked like this.", e.text);
}
		
		private function convert_bitmap_array(): Array{

			var array: Array;
			return array;
		}
		
	}
	
}
