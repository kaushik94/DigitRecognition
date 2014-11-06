package  view {
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.net.*;
	import flash.events.*;
	import flash.filesystem.File;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;

	public class KNN extends MovieClip{

		private var K: Number;
		private var numPixels: Number;
		private var training_data: Array;
		private var test: Array;
		
		var myRequest:URLRequest;
		var loadedData:Array;
		var myLoader:URLLoader;
		

		public function KNN(_k:Number, _num: Number) {
			
			K = _k;
			numPixels = _num;
			//train("t.csv");
			// constructor code
		}
		
		public function train_data(array : Array){
			this.training_data = array;
			trace(training_data);
			write_csv();
			trace("trained");
		}

		public function test_data(array: Array){
			this.test = array;
			normalise_test();
			read_csv();
			//normalise_test();
			//trace(array);
			//find_knn();
		}
		
		private function find_knn(){
			var min: Number = int.MAX_VALUE;
			var best: Array = new Array();
			//trace(loadedData[loadedData.length-2]);
			//trace(loadedData[1]);
			for(var i: Number = 0;i< loadedData.length-1; i++){
				//trace(loadedData[i]);
				var distance: Number = distance(loadedData[i], test);
				if(distance <= min){
					min = distance;
					best.push(loadedData[i][0]);
				}
			}
			//trace("Actual");
			//for each(var data:int in loadedData[loadedData.length-1])
			//trace(test);
			//trace(test.length);
			//trace(loadedData[loadedData.length-1]);
			trace("predicted");
			trace(best[best.length - 1]);
		}
		
		public function train(string: String): void{
			read_csv();
			//normalise();
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
		
		private function normalise_test(){
				var maximum: Number = Math.max.apply(null, test);
				for(var j: Number=0;j< test.length;j++){
					var foo: Number = Math.abs(test[j])/ maximum;
					test[j] = foo;
				}
		}
		
		private function normalise_train(){
				var maximum: Number = Math.max.apply(null, training_data);
				for(var j: Number=0;j< training_data.length;j++){
					var foo: Number = Math.abs(training_data[j])/ maximum;
					training_data[j] = foo;
				}
		}

		public function normalise(): void{
			for(var i: Number = 0;i< loadedData.length; i++){
				var median: Number = getMedian(loadedData[i]);
				//trace(median);
				var asd: Number = getAbsoluteStandardDeviation(loadedData[i], median);
				//trace(data[i]);
				//trace(median);
				//trace(asd);
				var maximum: Number = Math.max.apply(null, loadedData[i]);
				for(var j: Number=1;j< loadedData[i].length;j++){
					var foo: Number = Math.abs(loadedData[i][j]/*-median*/)/maximum;
					//trace(foo);
					loadedData[i][j] = foo;
				}
			}
			//trace(loadedData.length);
			//find_knn();
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
			var csvFile:File=new File(File.applicationDirectory.nativePath).resolvePath("myTraining.csv");
			myRequest = new URLRequest(csvFile.url);
			myLoader = new URLLoader();
			myLoader.dataFormat = URLLoaderDataFormat.TEXT;
			myLoader.addEventListener(Event.COMPLETE, onloadRead);
			myLoader.load(myRequest);
			//onload(e);
		}
		
		public function write_csv(): void{
			var file:File = new File(File.applicationDirectory.nativePath).resolvePath( "myTraining.csv" );
			var stream:FileStream = new FileStream();
			stream.open( file, FileMode.APPEND );
			stream.writeUTFBytes( "\n" + training_data );
			stream.close();
			file = null;
			stream = null;			
		}
		
		function onloadRead(e:Event):void{
			//trace(myLoader.data);
			loadedData = new Array();
			loadedData = String(e.currentTarget.data).split(/\r\n|\n|\r/);
			//trace(loadedData);
			for (var i:int=0; i<loadedData.length; i++){
				loadedData[i] = loadedData[i].split(",");
				//trace(int(loadedData[i][0]));
				for(var j: int = 0; j<loadedData[i].length; j++){
					loadedData[i][j] = int(loadedData[i][j]);
					//trace(loadedData[i]);
				}
			}
			//trace(loadedData[loadedData.length-2][0]);
			normalise();
			find_knn();
			dispatchEvent(new Event("ON_NORMALISE_COMP"));
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
