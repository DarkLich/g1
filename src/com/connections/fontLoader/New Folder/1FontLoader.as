package com.connections.fontLoader.New Folder Folder Folder Folder Folder Folder Folder
{
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.utils.*;
	
	public class FontLoader extends SimpleLoader
	{
		private const format:TextFormat = new TextFormat("Verdana",20,0x000000);
	
		public function FontLoader(_url:String)
		{
			super(_url);
		
		}
		override protected function completeHandler(evt:Event)
		{
			dispatchEvent(new Event("FontLoaded"));
		}
		private function getFontDefinitionName(_prop:String,_fontName:String="")
		{
			var fontDefinition:String;
			var prop = String(_prop);
			
			switch (prop)
			{
				case ("fontItalic"):
					fontDefinition = _fontName+"ItalicFontClass";
					break;
				case ("fontBold"):
					fontDefinition = _fontName+"FontBoldClass";
					break;
				case ("fontBoldItalic"):
					fontDefinition = _fontName+"BoldItalicFontClass";
					break;
				case ("font"):
					fontDefinition = _fontName+"FontClass";
					break;
				default:
					throw new Error ("FontLoader undefined font");
			}
			
			return fontDefinition
		}
		public function checkLoadedFont()
		{
			if (!checkFontDefinition("font"))
			{
				trace ("FontLoader checkLoadedFont font false ");
				
				return false;
			}
			if (!checkFontDefinition("fontItalic"))
			{
				trace ("FontLoader checkLoadedFont fontItalic false ");
				
				return false;
			}
			if (!checkFontDefinition("fontBold"))
			{
				trace ("FontLoader checkLoadedFont fontBold false ");
				
				return false;
			}
			if (!checkFontDefinition("fontBoldItalic"))
			{
				trace ("FontLoader checkLoadedFont fontBoldItalic false ");
				
				return false;
			}
			
			return true
		}
		private function checkFontDefinition(_prop:String)
		{
			var fontDefinition = getFontDefinitionName(_prop);
			
			try 
			{
				loader.contentLoaderInfo.applicationDomain.getDefinition(fontDefinition);
				return true
			}
			catch (e:Error)
			{
				return false
			}
		}
		public function getNewFontObject(_prop:String)
		{
			var fontDefinition = getFontDefinitionName(_prop);
			
			var fontClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(fontDefinition) as Class;
			Font.registerFont(fontClass);
			var font:Font = new fontClass();
			trace ("ProductTextField new font = "+font.fontName);
			var format = new TextFormat(font.fontName,14);
				format.align = "left";
			switch (_prop)
			{	
				case("fontItalic"):
					format.bold = false;
					format.italic = true;
					break;
				case("fontBold"):
					format.bold = true;
					format.italic = false;
					break;
				case("fontBoldItalic"):
					format.bold = true;
					format.italic = true;
					break;
				case("font"):
					format.bold = false;
					format.italic = false;
					break;
				default:
					throw new Error ("FontLoader  undefined textFormat");
			}
			return format
		}
		public function getEmbedFont(_fontFamily:String):Font
		{
			//trace ("FontLoader = "+loader);
			var fontClass:Class = loader.contentLoaderInfo.applicationDomain.getDefinition(_fontFamily) as Class;
				Font.registerFont(fontClass);
			
			var font:Font = new fontClass();
			
			return font
		}
	}
}