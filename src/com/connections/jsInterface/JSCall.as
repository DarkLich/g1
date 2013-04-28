package com.connections.jsInterface 
{
	import com.VO.MainVO;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ЙА
	 */
	public class JSCall extends EventDispatcher 
	{
		public var errorText:String;
		
		public static const ERROR:String = "error";
		
		public function JSCall(needCallback:Boolean=false,CallbackName:String="sendToActionScript") 
		{
			if (needCallback){
				if (ExternalInterface.available) {
					try {
						ExternalInterface.addCallback(CallbackName, receivedFromJavaScript);
						//MainVO.testMessage = "generated flash function: "+CallbackName;
						//MainVO.dispatch(MainVO.SHOW_TEST_MESSAGE);
					} catch (error:SecurityError) {
						//MainVO.testMessage = "A SecurityError occurred:" + error.message+" on function: "+CallbackName;
						//MainVO.dispatch(MainVO.SHOW_TEST_MESSAGE);
						//output.appendText("A SecurityError occurred: " + error.message + "\n");
					} catch (error:Error) {
						//MainVO.testMessage = "A Error occurred:" + error.message+" on function: "+CallbackName;
						//MainVO.dispatch(MainVO.SHOW_TEST_MESSAGE);
						//output.appendText("An Error occurred: " + error.message + "\n");
					}
				} else {
					//output.appendText("External interface is not available for this container.");
					//trace(ExternalInterface.available
				}
			}
			
		}
		
		public function call(func:String, ...args):int {
			if (ExternalInterface.available) {
				var result:int;
				try {
					result = ExternalInterface.call(func,args);
				} 
				catch (er:Error) {
					//MainVO.testMessage = "call Error on function: " + func;
					//MainVO.dispatch(MainVO.SHOW_TEST_MESSAGE);
					errorText = "Ошибка вызова JS функции";
					dispatchEvent(new Event(ERROR));
				}
			}
			return result;
		}
		
	    private function receivedFromJavaScript(value:int):void {
			// output.appendText("JavaScript says: " + value + "\n");
			//MainVO.testMessage = "recived from JS: " + value;
			//MainVO.dispatch(MainVO.SHOW_TEST_MESSAGE);
			MainVO.javaValue = value;
			MainVO.dispatch(MainVO.JAVA_DATA_OBTAINED);
        }

	}

}