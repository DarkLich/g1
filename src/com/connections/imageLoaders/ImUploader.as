package com.connections.imageLoaders 
{
	import com.connections.jsInterface.JSCall;
	import com.VO.MainVO;
	import com.VO.MotiveVO;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class ImUploader extends EventDispatcher 
	{	
		private var imageSrc:String;
		private var _loadedBitmap:Bitmap;
		private var fileRef:FileReference = new FileReference();
		private var uploadedFileName:String;
		private var fileExtension:String;
		private var jsFunc:String;
		
		public static const IMG_LOADED		:String = 'imageLoaded';
		
		public function ImUploader() 
		{
			
		}
		
		public function newLoad():void {
			fileRef.addEventListener(Event.SELECT, onFileSelected);
			fileRef.addEventListener(Event.COMPLETE, onFileLoaded);
			fileRef.browse([new FileFilter("Images (*.jpg;*.jpeg;*.gif;*.png;*.pdf)", "*.jpg;*.jpeg;*.gif;*.png;*.pdf")]);
		}
		
		private function onFileSelected(ev:Event):void {
			var fRef:FileReference = ev.target as FileReference;
			var fDir:String = MainVO.configXML.saveParameters.imageUploader.fileRelativeDir.toString();
			//var fName:String = fRef.name;
			var fName:String = String(new Date().getTime()) + "_" + fRef.name;
			uploadedFileName = fName;
			imageSrc = MainVO.configXML.rootDir.toString() + "/" + MainVO.configXML.saveParameters.imageUploader.scriptDir.toString() + "/" + fDir + "/" + fName;
			var request:URLRequest = new URLRequest(MainVO.configXML.rootDir.toString()+"/"+MainVO.configXML.saveParameters.imageUploader.scriptDir.toString() + "/" + MainVO.configXML.saveParameters.imageUploader.scriptName.toString() + "?name=" +fName+"&folder=" + fDir);
			request.data = fRef.data;
			request.contentType = 'multipart/form-data';
			fRef.upload(request);
			//MainVO.dispatch(MainVO.SHOW_PRELOADER);
			MainVO.fReference = fRef;
			MainVO.dispatch(MainVO.SHOW_LOAD_LOCAL_PROGRESS);
		}

		private function onFileLoaded(ev:Event):void {
			MainVO.dispatch(MainVO.SHOW_PRELOADER);
			fileExtension = uploadedFileName.slice(uploadedFileName.length - 3);
			var jsCall:JSCall = new JSCall(true, "inFlash");
			if (fileExtension == "pdf") {
				jsFunc = "getItemsLocal";
				jsCall.call(jsFunc, uploadedFileName);
				MainVO.dispatcher.addEventListener(MainVO.JAVA_DATA_OBTAINED, onJavaComplete);
			}else { 
			//	jsFunc = "resizeImgUpload";
				var imLoader:ImLoader = new ImLoader(imageSrc, 400, 400);
				imLoader.addEventListener(ImLoader.IMG_LOADED, onImageLoaded);
			}
			//jsCall.call(jsFunc, uploadedFileName);
			//MainVO.dispatcher.addEventListener(MainVO.JAVA_DATA_OBTAINED, onJavaComplete);
		}
		
		private function onJavaComplete(ev:Event):void {
			MainVO.dispatcher.removeEventListener(MainVO.JAVA_DATA_OBTAINED, onJavaComplete);
			if (MainVO.javaValue == 1) {
				var imLoader:ImLoader;
				if (fileExtension=="pdf"){
					imLoader = new ImLoader(imageSrc+".png", 400, 400);
					imLoader.addEventListener(ImLoader.IMG_LOADED, onImageLoaded);
				}else {
					imLoader = new ImLoader(imageSrc, 400, 400);
					imLoader.addEventListener(ImLoader.IMG_LOADED, onImageLoaded);
				}
			}else {
				//MainVO.popUpMessage = "mamamamamama";
				//MainVO.dispatch(MainVO.SHOW_POP_UP);
			}			
		}
		
		private function onImageLoaded(ev:Event):void {
			MainVO.dispatch(MainVO.HIDE_PRELOADER);
			//ev.target.content.smoothing = true;
			//_loadedBitmap = ev.target.content;
			//dispatchEvent(new Event(IMG_LOADED,true));
			MotiveVO.loadedBitmap = ev.currentTarget.loadedBitmap;
			MotiveVO.originalBitmap = ev.currentTarget.loadedBitmap;
			if (fileExtension == "pdf") {
				MotiveVO.imageSRC = imageSrc+".png";
			}else {
				MotiveVO.imageSRC = imageSrc;
			}
			MotiveVO.motiveSource = "local";
			MotiveVO.dispatch(MotiveVO.IMAGE_LOADED);
		}
		
		public function get loadedBitmap():Bitmap {
			return _loadedBitmap;
		}
		
	}

}