package com.connections 
{
	import com.connections.imageLoaders.ImLoader;
	import com.connections.imageLoaders.SvgLoader;
	import com.connections.imageLoaders.SwfLoader;
	import com.connections.xmlLoaders.SimpleXMLLoader;
	import com.VO.MainVO;
	import com.VO.MotiveVO;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class ProductLoader extends EventDispatcher 
	{
		private var totalProducts:int;
		private var curentProduct:int;
		private var textsCount:int;
		private var imagesCount:int;
		private var motivesLoaded:int;
		private var imagesVector:Array;
		private var loadedXML:XML;
		private var ordersXML:XML;
		private var sideNum:int;
		private var motiveGroup:int;
		private var workSpaceIsReady:Boolean;
		private var loadedMotivesIsReady:Boolean;
		
		public function ProductLoader() 
		{
			MainVO.dispatcher.addEventListener(MainVO.LOAD_PRODUCT, onLoadProduct);
			MainVO.dispatcher.addEventListener(MainVO.PDF_SAVED, onPdfSaved);
		}
		
		private function onLoadProduct(ev:Event):void {
			var sXmlLoader:SimpleXMLLoader = new SimpleXMLLoader();
			if (!MainVO.localTesting) {
				if (MainVO.flashVarsObject["generatetype"] == 1) {
					MainVO.saveFormat = "pdf";
				}else {
					MainVO.saveFormat = "image";
				}
				MainVO.pixCount = MainVO.flashVarsObject["bitmap"];
			}
			//MainVO.testMessage = String(MainVO.flashVarsObject["pdf_xml"]);
			//MainVO.dispatch(MainVO.SHOW_TEST_MESSAGE);
			if (MainVO.localTesting) {
				sXmlLoader.load(MainVO.configXML.rootDir.toString()+"/"+"flash/savedXML/loadXML/info.xml");
				//sXmlLoader.load(MainVO.configXML.rootDir.toString()+"/"+MainVO.configXML.loadParameters.ordersXmlDir.toString()+"/"+"order_"+"174"+".xml");
			}else{
				sXmlLoader.load(MainVO.configXML.rootDir.toString()+"/"+MainVO.configXML.loadParameters.ordersXmlDir.toString()+"/"+"order_"+String(MainVO.flashVarsObject["pdf_xml"]+".xml"));
			}
			sXmlLoader.addEventListener(SimpleXMLLoader.LOADED, onOrdersLoaded);
		}
		
		private function onOrdersLoaded(ev:Event):void {
			ordersXML = ev.target.loadedXML;
			totalProducts = ordersXML.item.length();
			MainVO.totalProducts = totalProducts;
			curentProduct = 0;
			loadProductXML();
		}
		
		private function loadProductXML():void {
			MainVO.productID = ordersXML.item[curentProduct];
			var sXmlLoader:SimpleXMLLoader = new SimpleXMLLoader();
			sXmlLoader.load(MainVO.configXML.rootDir.toString()+"/"+MainVO.configXML.loadParameters.productXmlDir.toString()+"/"+ordersXML.item[curentProduct]+".xml");
			sXmlLoader.addEventListener(SimpleXMLLoader.LOADED, onXmlLoaded);
		}
		
		private function onXmlLoaded(ev:Event):void {	
			loadedXML = ev.target.loadedXML;
			if (loadedXML.motives[1].item.length() > 0) sideNum = 2 else sideNum = 1;
			motiveGroup = 0;
			beginLoading();
		}
		private function beginLoading():void {
			MainVO.workSpace.maskBorder.visible = false;
			MainVO.dispatch(MainVO.PROCESSING_NEW_PDF);
			loadedMotivesIsReady = false;
			while (MotiveVO.motiveSpase.holderSide0.numChildren > 0) {
				MotiveVO.motiveSpase.holderSide0.removeChildAt(0);
			}
			while (MotiveVO.motiveSpase.holderSide1.numChildren > 0) {
				MotiveVO.motiveSpase.holderSide1.removeChildAt(0);
			}
			MainVO.productIsLoading = true;
			imagesVector = new Array();
			textsCount = 0;
			imagesCount = 0;
			motivesLoaded = 0;
			MainVO.chosenBanner = loadedXML.product.@kind;
			MainVO.workSpaceWidth = loadedXML.product.sizeFormat.@w;
			MainVO.workSpaceHeight = loadedXML.product.sizeFormat.@h;
			MainVO.chosenBackgroundColor = loadedXML.product.backgroundColor;
			//while (MainVO.workSpace.background.numChildren > 0) MainVO.workSpace.background.removeChildAt(0);
			//while (MainVO.workSpace.background2.numChildren > 0) MainVO.workSpace.background2.removeChildAt(0);
			MainVO.workSpace.groundHolder.graphics.clear();
			
			while (MainVO.workSpace.background.numChildren > 0) {
				MainVO.workSpace.background.removeChildAt(0);
				MainVO.workSpace.background.graphics.beginFill(0xFFFFFF);
				MainVO.workSpace.background.graphics.drawRect(0, 0, 1, 1);
				MainVO.workSpace.background.width = MainVO.workSpaceWidth + MainVO.colorEdgeSize*2;
				MainVO.workSpace.background.height = MainVO.workSpaceHeight + MainVO.colorEdgeSize * 2;
			}
			while (MainVO.workSpace.background2.numChildren > 0) {
				MainVO.workSpace.background2.removeChildAt(0);
			}
			while (MainVO.workSpace.stikerCutSprite.numChildren > 0) {
				MainVO.workSpace.stikerCutSprite.removeChildAt(0);
			}
			while (MainVO.workSpace.maska.numChildren > 0) {
				MainVO.workSpace.maska.removeChildAt(0);
				MainVO.workSpace.maska.graphics.clear();
				MainVO.workSpace.maska.graphics.beginFill(0);
				MainVO.workSpace.maska.graphics.drawRect(0, 0, 1, 1);
				MainVO.workSpace.width = MainVO.maskRect.width + MainVO.colorEdgeSize*2;
				MainVO.workSpace.height = MainVO.maskRect.height + MainVO.colorEdgeSize * 2;
				MainVO.workSpace.x = MainVO.maskRect.x;
				MainVO.workSpace.y = MainVO.maskRect.y;
			}
			MainVO.maskRect = new Rectangle(loadedXML.product.maskRect.@x, loadedXML.product.maskRect.@y, loadedXML.product.maskRect.@w, loadedXML.product.maskRect.@h);
			trace("maskRect_0",MainVO.maskRect.x, MainVO.maskRect.y, MainVO.maskRect.width, MainVO.maskRect.height);
			if (MainVO.chosenBackgroundColor == 0xFFFFFF) {
				MainVO.workSpace.groundHolder.graphics.beginFill(0xF0F0F0);
			}else {
				MainVO.workSpace.groundHolder.graphics.beginFill(0xFFFFFF);
			}
			MainVO.workSpace.groundHolder.graphics.drawRect(0, 0, MainVO.workSpace._workRect.width, MainVO.workSpace._workRect.height);
			
			//MainVO.workSpace.maska.width = MainVO.maskRect.width + MainVO.colorEdgeSize*2;
			//MainVO.workSpace.maska.height = MainVO.maskRect.height + MainVO.colorEdgeSize * 2;
			//MainVO.workSpace.maska.x = MainVO.maskRect.x;
			//MainVO.workSpace.maska.y = MainVO.maskRect.y;
			
			
			
			MainVO.chosenPrintMedia = loadedXML.product.printMedia;
			//MainVO.chosenBorder = Boolean(int(loadedXML.product.border));
			//MainVO.chosenKink = int(loadedXML.product.kink.@kind);
			//	trace(MainVO.chosenKink,loadedXML.product.kink.@kind);
			if (loadedXML.product.kink.length() > 0) {
				MainVO.chosenKink = 1000;
				MainVO.kinkIndividual = true;
				MainVO.kinkNumLeft = int(loadedXML.product.kink.left);
				MainVO.kinkNumUp = int(loadedXML.product.kink.up);
				MainVO.kinkNumRight = int(loadedXML.product.kink.right);
				MainVO.kinkNumDown = int(loadedXML.product.kink.down);
			}else {
				MainVO.chosenKink = 0;
				MainVO.kinkIndividual = false;
			}
			MainVO.chosenOffset = loadedXML.product.offset;
			MainVO.chosenSponsor = Boolean(int(loadedXML.product.sponsor));
			if (loadedXML.product.colorEdge.length() > 0) {
				MainVO.colorEdgeSize = Number(loadedXML.product.colorEdge.@size);
				MainVO.colorEdgeType = int(loadedXML.product.colorEdge.@type);
				MainVO.colorEdgeColor = int(loadedXML.product.colorEdge.@color);
			}else {
				MainVO.colorEdgeSize = 0;
			}
			if (loadedXML.product.flagPicSrc.length() > 0) {
				MainVO.flagPicSrc = loadedXML.product.flagPicSrc;
			}else {
				MainVO.flagPicSrc = "";
			}
			
			if (loadedXML.product.stickerBgSrc.length() > 0) {
				MainVO.stickerBgSrc = loadedXML.product.stickerBgSrc;
			}else {
				MainVO.stickerBgSrc = "";
			}
			if (loadedXML.product.shirt.length() > 0) {
				MainVO.shirtFrontSrc = loadedXML.product.shirt.frontSrc;
				MainVO.shirtBackSrc = loadedXML.product.shirt.backSrc;
				MainVO.shirtMaskRect = new Rectangle(loadedXML.product.shirt.maskX,
													loadedXML.product.shirt.maskY,
													loadedXML.product.shirt.maskW,
													loadedXML.product.shirt.maskH);
			}else {
				MainVO.shirtFrontSrc = "";
			}
			mainVoChanged();
			trace("maskRect",MainVO.maskRect.x, MainVO.maskRect.y, MainVO.maskRect.width, MainVO.maskRect.height);
			trace("maska",MainVO.workSpace.maska.x, MainVO.workSpace.maska.y, MainVO.workSpace.maska.width, MainVO.workSpace.maska.height);
			for (var i:int = 0; i < loadedXML.motives[motiveGroup].item.length(); i++) {
				if (loadedXML.motives[motiveGroup].item[i].@kind == "text") {
					textsCount++;
					motivesLoaded++;
					imagesVector.push(null);
				}
				if (loadedXML.motives[motiveGroup].item[i].@kind == "image") {
					imagesCount++;
					if (loadedXML.motives[motiveGroup].item[i].source == "fotolia") {
						loadImage(MainVO.configXML.rootDir+"/"+MainVO.configXML.loadParameters.fotoliaFotosDir+"/"+loadedXML.fotoliaPictures.item.(@id==loadedXML.motives[motiveGroup].item[i].src).@src);
					}else {
						loadImage(loadedXML.motives[motiveGroup].item[i].src);
					}
				}
				if (loadedXML.motives[motiveGroup].item[i].@kind == "clipart") {
					imagesCount++;
					loadSVG(loadedXML.motives[motiveGroup].item[i].src);
				}
			}
			if (imagesCount == 0) {
				allImagesLoaded();
			}
			
		}
		
		private function mainVoChanged():void {
			if (MainVO.shirtFrontSrc != "") {
				workSpaceIsReady = false;
				MainVO.dispatcher.addEventListener(MainVO.WORK_SPACE_READY, onWorkSpaceReady);
				MainVO.dispatch(MainVO.SHIRT_CHANGED);
			}
			if (MainVO.flagPicSrc != "") {
				workSpaceIsReady = false;
				MainVO.dispatcher.addEventListener(MainVO.WORK_SPACE_READY, onWorkSpaceReady);
				MainVO.dispatch(MainVO.FLAG_CHANGED);
			}
			if (MainVO.stickerBgSrc != "") {
				workSpaceIsReady = false;
				MainVO.dispatcher.addEventListener(MainVO.WORK_SPACE_READY, onWorkSpaceReady);
				MainVO.dispatch(MainVO.STICKER_CHOSEN);
			}
			MainVO.dispatch(MainVO.WORK_SPACE_SIZE_LOADED);
			//MainVO.dispatch(MainVO.WORK_SPACE_SIZE_CHANGED);
			MainVO.dispatch(MainVO.BACKGROUND_COLOR_SELECTED);
			MainVO.dispatch(MainVO.BORDER_CHOSEN);
			MainVO.dispatch(MainVO.KINK_CHOSEN);
			MainVO.dispatch(MainVO.OFFSET_CHOSEN);
			MainVO.dispatch(MainVO.SPONSOR_CHOSEN);
			MainVO.dispatch(MainVO.COLOR_EDGE_TYPE_CHANGED);
			MainVO.dispatch(MainVO.COLOR_EDGE_COLOR_CHANGED);
		}
		
		private function loadImage(src:String):void {
			var imLoader:ImLoader = new ImLoader(src, 400, 400);
			imagesVector.push(imLoader);
			imLoader.addEventListener(ImLoader.IMG_LOADED, onImageLoaded);	
		}
		
		private function loadSVG(src:String):void {
			var imLoader:SvgLoader = new SvgLoader(src, 400, 400);
			MainVO.invisibleHolder.addChild(imLoader);
			imagesVector.push(imLoader);
			imLoader.addEventListener(SvgLoader.IMG_LOADED, onImageLoaded);	
		}
		
		private function onImageLoaded(ev:Event):void {
			motivesLoaded++;
			if (motivesLoaded == imagesCount + textsCount) {
				allImagesLoaded();
			}
		}
		
		private function onWorkSpaceReady(ev:Event):void {
			MainVO.dispatcher.removeEventListener(MainVO.WORK_SPACE_READY, onWorkSpaceReady);
			workSpaceIsReady = true;
			readyCheck();
		}
		
		private function allImagesLoaded():void {
			for (var i:int = 0; i < motivesLoaded; i++) {
				addMotive(i);
			}
			loadedMotivesIsReady = true;
			readyCheck();
		}
		
		private function readyCheck():void {
			if (MainVO.flagPicSrc != ""||MainVO.stickerBgSrc != ""||MainVO.shirtFrontSrc != "") {
				if (workSpaceIsReady&&loadedMotivesIsReady) {
					//MainVO.productIsLoading = false;
					MainVO.savingSide = motiveGroup;
					MainVO.dispatch(MainVO.SAVE_PDF);
				}
			}else{
				//MainVO.productIsLoading = false;
				MainVO.savingSide = motiveGroup;
				MainVO.dispatch(MainVO.SAVE_PDF);
			}
		}
		
		private function onPdfSaved(ev:Event):void {
			motiveGroup++;
			if (motiveGroup < sideNum) {
				beginLoading();
			}else {
				curentProduct++;
				if (curentProduct < totalProducts) {	
					
					loadProductXML();
				}else {
					MainVO.dispatch(MainVO.ALL_PDF_GENERETED);
					var urlRequest:URLRequest = new URLRequest(MainVO.configXML.rootDir.toString()+"/"+MainVO.configXML.other.finishPDF.toString() + String(MainVO.flashVarsObject["pdf_xml"]));
					//var urlRequest:URLRequest = new URLRequest(MainVO.configXML.rootDir.toString() + "/" + MainVO.configXML.other.finishPDFparts.toString() + "&folder=" + MainVO.productID + "&w=" + MainVO.workSpace.maska.width*10 +"&h=" + MainVO.workSpace.maska.height*10);
					
					navigateToURL(urlRequest,"_self");
					//"_self" указывает текущий фрейм в текущем окне.
					//"_blank" определяет новое окно.
					//"_parent" указывает родительский объект текущего фрейма.
					//"_top" указывает фрейм самого верхнего уровня в текущем окне.
				}
			}
		}
		
		private function addMotive(i:int):void {
			MotiveVO.loadedMotiveX = loadedXML.motives[motiveGroup].item[i].x;
			MotiveVO.loadedMotiveY = loadedXML.motives[motiveGroup].item[i].y;
			MotiveVO.loadedMotiveScaleX = loadedXML.motives[motiveGroup].item[i].scaleWidth;
			MotiveVO.loadedMotiveScaleY = loadedXML.motives[motiveGroup].item[i].scaleHeight;
			MotiveVO.loadedMotiveRotation = loadedXML.motives[motiveGroup].item[i].rotation;
			if (loadedXML.motives[motiveGroup].item[i].@kind == "text") {
				MotiveVO.motiveText = loadedXML.motives[motiveGroup].item[i].text;
				MotiveVO.chosenTextColor = loadedXML.motives[motiveGroup].item[i].textColor;
				MotiveVO.selectedFont = loadedXML.motives[motiveGroup].item[i].textFont;
				MotiveVO.chosenTextAlign = loadedXML.motives[motiveGroup].item[i].textAlign;
				MainVO.dispatch(MainVO.NEW_TEXT);
			}
			if (loadedXML.motives[motiveGroup].item[i].@kind == "image") {
				MotiveVO.loadedBitmap = imagesVector[i].loadedBitmap;
				MotiveVO.originalBitmap = imagesVector[i].loadedBitmap;
				MotiveVO.imageSRC = loadedXML.motives[motiveGroup].item[i].src;
				MotiveVO.isCutted = Boolean(int(loadedXML.motives[motiveGroup].item[i].isCutted));
				MotiveVO.motiveSource = loadedXML.motives[motiveGroup].item[i].source;
				MotiveVO.cutRectangle = new Rectangle(	loadedXML.motives[motiveGroup].item[i].cutParameters.x, loadedXML.motives[motiveGroup].item[i].cutParameters.y,
														loadedXML.motives[motiveGroup].item[i].cutParameters.width, loadedXML.motives[motiveGroup].item[i].cutParameters.height);
				MotiveVO.dispatch(MotiveVO.IMAGE_LOADED);
			}
			if (loadedXML.motives[motiveGroup].item[i].@kind == "clipart") {
				MotiveVO.svgMotive = imagesVector[i];
				MotiveVO.svgElements = imagesVector[i].elementsArray;
				MotiveVO.svgElementsColor = imagesVector[i].elementsColor;
				MotiveVO.svgPalete = String(loadedXML.motives[motiveGroup].item[i].palete).split(",");
				MotiveVO.imageSRC = loadedXML.motives[motiveGroup].item[i].src;
				MotiveVO.motiveSource = loadedXML.motives[motiveGroup].item[i].source;
				MotiveVO.dispatch(MotiveVO.CLIP_LOADED);
			}
			
			
			if (Boolean(int(loadedXML.motives[motiveGroup].item[i].isCutted))) {
				MotiveVO.isCutted = Boolean(int(loadedXML.motives[motiveGroup].item[i].isCutted));
				MotiveVO.invisibleCutter = true;
				MotiveVO.dispatch(MotiveVO.SHOW_CUTTER);
			}
			
		}
	}

}